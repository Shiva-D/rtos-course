cmake_minimum_required(VERSION 3.10)

project(RTOS VERSION 1.0 LANGUAGES C CXX ASM)

# Global gcc cflags and linker flags
set ( CMAKE_C_FLAGS "-ggdb3 -O0 -DprojCOVERAGE_TEST=0 -D_WINDOWS_ -fdata-sections -ffunction-sections" )
set ( CMAKE_EXE_LINKER_FLAGS "-Wl,-dead_strip" )

# Set the following to remove "has no symbols" warning message
set ( CMAKE_C_ARCHIVE_CREATE   "<CMAKE_AR> Scr <TARGET> <LINK_FLAGS> <OBJECTS>" )
set ( CMAKE_CXX_ARCHIVE_CREATE "<CMAKE_AR> Scr <TARGET> <LINK_FLAGS> <OBJECTS>" )
set ( CMAKE_C_ARCHIVE_FINISH   "<CMAKE_RANLIB> -no_warning_for_no_symbols -c <TARGET>" )
set ( CMAKE_CXX_ARCHIVE_FINISH "<CMAKE_RANLIB> -no_warning_for_no_symbols -c <TARGET>" )

# Set the C/C++ standard
set ( CMAKE_CXX_STANDARD 11 )
set ( CMAKE_CXX_STANDARD_REQUIRED ON )
set ( CMAKE_C_STANDARD 11 )
set ( CMAKE_C_STANDARD_REQUIRED ON )

set ( CMAKE_C_EXTENSIONS ON )

# Build the freeRTOS static library and the apps 
add_subdirectory(FreeRTOSv10.4.1)
add_subdirectory(apps)