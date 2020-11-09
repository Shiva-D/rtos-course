#!/bin/bash

getopt --test > /dev/null
if [[ $? -ne 4 ]]; then
    printf "${0} uses get-opt(); on ubuntu install util-linux package / on mac install gnu-getopt\n"
    exit 1
fi

which gsed > /dev/null
if [[ $? -ne 0 ]]; then
    printf "${red}Install gnu-sed in mac${normal}\n"
fi

# Exit the script as soon as a command fails
# set -exit
set -o pipefail

# Global variables
red=$'\e[1;31m'
green=$'\e[1;32m'
yellow=$'\e[1;33m'
blue=$'\e[1;34m'
magenta=$'\e[1;35m'
cyan=$'\e[1;36m'
normal=$'\e[0m'
bold=$'\e[1m'

gs_build=false
gs_cmake_gen="Ninja"
gs_sym_links=false
gs_create_project=false
gs_project_name=""

usage() {
    printf ${yellow}
    printf "Usage of $(basename ${0})\n"
    printf "\n"
    printf "%s | %-25s  %-5s\n" "-h" "--help"                   "Prints the help menu"
    printf "%s | %-25s  %-5s\n" "-c" "--clean"                  "Cleans the build directory"
    printf "%s | %-25s  %-5s\n" "-b" "--build"                  "Builds all the apps"
    printf "%s | %-25s  %-5s\n" "-m" "--make"                   "Uses make instead of ninja"
    printf "%s | %-25s  %-5s\n" "-l" "--links"                  "Creates a symbolic link of all the executable in the executables dir"
    printf "%s | %-25s  %-5s\n" "-p" "--project <project-name>" "Creates a project folder with the provided name based on the template"
    printf "${normal}\n"
    exit 0
}

#parameter parsing
short_options=h,c,b,m,l,p:
long_options=help,clean,build,make,links,project:

script_options=$(getopt --options=${short_options} --longoptions=${long_options} --name "${0}" -- "$@")
if [[ $? -ne 0 ]]; then
    #getopt error
    exit 2
fi

# Necessary for proper parsing of getopt results
eval set -- "${script_options}"

# Primary bash argumenst parsing loop; new arguments are added as a switch parameter
while true ; do
    case "${1}" in
    -h|--help)
        usage
        ;;
    -m|--make)
        gs_cmake_gen="Unix Makefiles"
        shift
        ;;
    -c|--clean)
        printf "${cyan}Cleaning the build directory${normal}\n"
        rm -rf ./build/*
        rm -rf ./executables/*
        shift
        ;;
    -b|--build)
        gs_build=true
        shift
        ;;
    -l|--links)
        gs_sym_links=true
        shift
        ;;
    -p|--project)
        gs_create_project=true
        gs_project_name=$2
        shift 2
        ;;
    --)
        shift
        break
        ;;
    esac
done

mkdir -p $PWD/apps

if [[ ! -f $PWD/apps/CMakeLists.txt ]]; then
    printf "${yellow}Creating:${normal} ${bold}$PWD/apps/CMakeLists.txt${normal}\n"
    printf "# Add the required apps in this file\n" >> "$PWD/apps/CMakeLists.txt"
fi

if [[ ${gs_create_project} == true ]]; then
    if [[ -d $PWD/apps/${gs_project_name} ]]; then
        printf "${bold}${gs_project_name}${normal}: ${red}Project already exists${normal}\n"
    else
        printf "${blue}Creating project:${normal} ${bold}${gs_project_name} ${normal}\n"
        cp -rf $PWD/template $PWD/apps/${gs_project_name}
        
        gsed -i "s/set_name/${gs_project_name}/" "$PWD/apps/${gs_project_name}/CMakeLists.txt"
        
        grep ${gs_project_name} $PWD/apps/CMakeLists.txt > /dev/null
        if [[ $? -ne 0 ]]; then 
            printf "add_subdirectory(${gs_project_name})\n" >> "$PWD/apps/CMakeLists.txt"
        fi
    fi
fi

mkdir -p $PWD/build

pushd $PWD/build > /dev/null
printf "${green}Configuring all projects${normal}\n"

cmake -G "${gs_cmake_gen}" ../

if [[ $? -ne 0 ]]; then
    exit 13
fi

popd > /dev/null

if [[ ${gs_build} == true ]]; then
    printf "${green}Building all projects${normal}\n"
    pushd $PWD/build > /dev/null

    if [[ ${gs_cmake_gen} == "Ninja" ]]; then
        ninja
    else 
        make
    fi

    if [[ $? -ne 0 ]]; then
        exit 13
    else 
        if [[ ${gs_sym_links} == true ]]; then
            printf "${yellow}Creating symbolic links of the executables${normal}\n"

            rm -rf ../executables/*
            mkdir -p ../executables
            exe_files=($( gfind ./ -executable -type f | grep -v bin | grep -v out ))
            for i in "${exe_files[@]}"
            do 
                ln -sfn "$PWD/${i}" "../executables/$(basename ${i})"
            done
        fi
    fi

    popd > /dev/null
fi

exit 0