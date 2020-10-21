# RTOS-COURSE

Run the setup.sh script to clean, build, create a project and link the exe
    
    Usage of setup.sh

    -h | --help                     Prints the help menu
    -c | --clean                    Cleans the build directory
    -b | --build                    Builds all the apps
    -m | --make                     Uses make instead of ninja
    -l | --links                    Creates a symbolic link of all the executable in the execuatbles dir
    -p | --project <project-name>   Creates a project folder with the provided name based on the template
    
Example usage of the `setup.sh`:
    
    # The following command would create a project called assign-2, build and link the exe in the "executables" directory
    ➜ ./setup.sh -cbl -p assign-1
    
**NOTE: Currently, all above mentioned functionality will only work on macOS**

## LICENCE
SPDX short identifier: BSD-3-Clause

let the fun begin!!! `¯\_(ツ)_/¯`