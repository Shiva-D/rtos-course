# Set the executable name
set( exe_name set_name )

# Add the reuired .c and .h files
set ( exe_sources main.c 
                  ${CMAKE_SOURCE_DIR}/common/console.c
                  ${CMAKE_SOURCE_DIR}/common/run-time-stats-utils
    )

# Make the executable
add_executable( ${exe_name} ${exe_sources} )

target_link_libraries( ${exe_name} free-rtos pthread pcap )