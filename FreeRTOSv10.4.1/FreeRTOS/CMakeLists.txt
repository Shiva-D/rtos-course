# Add all the required .c and .h files
file ( GLOB free_rtos_main_source ${CMAKE_CURRENT_SOURCE_DIR}/Source/*.c )

set ( lib_sources ${free_rtos_main_source}
                  ${CMAKE_CURRENT_SOURCE_DIR}/Source/portable/MemMang/heap_3.c
                  ${CMAKE_CURRENT_SOURCE_DIR}/Source/portable/ThirdParty/GCC/Posix/utils/wait_for_event.c 
                  ${CMAKE_CURRENT_SOURCE_DIR}/Source/portable/ThirdParty/GCC/Posix/port.c
                  ${CMAKE_CURRENT_SOURCE_DIR}/../FreeRTOS-Plus/Source/FreeRTOS-Plus-Trace/trcKernelPort.c
                  ${CMAKE_CURRENT_SOURCE_DIR}/../FreeRTOS-Plus/Source/FreeRTOS-Plus-Trace/trcSnapshotRecorder.c
                  ${CMAKE_CURRENT_SOURCE_DIR}/../FreeRTOS-Plus/Source/FreeRTOS-Plus-Trace/trcStreamingRecorder.c
                  ${CMAKE_CURRENT_SOURCE_DIR}/../FreeRTOS-Plus/Source/FreeRTOS-Plus-Trace/streamports/File/trcStreamingPort.c
                  ${CMAKE_CURRENT_SOURCE_DIR}/Demo/Common/Minimal/AbortDelay.c
                  ${CMAKE_CURRENT_SOURCE_DIR}/Demo/Common/Minimal/BlockQ.c
                  ${CMAKE_CURRENT_SOURCE_DIR}/Demo/Common/Minimal/blocktim.c
                  ${CMAKE_CURRENT_SOURCE_DIR}/Demo/Common/Minimal/countsem.c
                  ${CMAKE_CURRENT_SOURCE_DIR}/Demo/Common/Minimal/death.c
                  ${CMAKE_CURRENT_SOURCE_DIR}/Demo/Common/Minimal/dynamic.c
                  ${CMAKE_CURRENT_SOURCE_DIR}/Demo/Common/Minimal/EventGroupsDemo.c
                  ${CMAKE_CURRENT_SOURCE_DIR}/Demo/Common/Minimal/flop.c
                  ${CMAKE_CURRENT_SOURCE_DIR}/Demo/Common/Minimal/GenQTest.c
                  ${CMAKE_CURRENT_SOURCE_DIR}/Demo/Common/Minimal/integer.c
                  ${CMAKE_CURRENT_SOURCE_DIR}/Demo/Common/Minimal/IntSemTest.c
                  ${CMAKE_CURRENT_SOURCE_DIR}/Demo/Common/Minimal/MessageBufferAMP.c
                  ${CMAKE_CURRENT_SOURCE_DIR}/Demo/Common/Minimal/MessageBufferDemo.c
                  ${CMAKE_CURRENT_SOURCE_DIR}/Demo/Common/Minimal/PollQ.c
                  ${CMAKE_CURRENT_SOURCE_DIR}/Demo/Common/Minimal/QPeek.c
                  ${CMAKE_CURRENT_SOURCE_DIR}/Demo/Common/Minimal/QueueOverwrite.c
                  ${CMAKE_CURRENT_SOURCE_DIR}/Demo/Common/Minimal/QueueSet.c
                  ${CMAKE_CURRENT_SOURCE_DIR}/Demo/Common/Minimal/QueueSetPolling.c
                  ${CMAKE_CURRENT_SOURCE_DIR}/Demo/Common/Minimal/recmutex.c
                  ${CMAKE_CURRENT_SOURCE_DIR}/Demo/Common/Minimal/semtest.c
                  ${CMAKE_CURRENT_SOURCE_DIR}/Demo/Common/Minimal/StaticAllocation.c
                  ${CMAKE_CURRENT_SOURCE_DIR}/Demo/Common/Minimal/StreamBufferDemo.c
                  ${CMAKE_CURRENT_SOURCE_DIR}/Demo/Common/Minimal/StreamBufferInterrupt.c
                  ${CMAKE_CURRENT_SOURCE_DIR}/Demo/Common/Minimal/TaskNotify.c
                  ${CMAKE_CURRENT_SOURCE_DIR}/Demo/Common/Minimal/TimerDemo.c

    )

set ( lib_headers "" )

set ( lib_name free-rtos ) 

# Make freeRTOS staic library
add_library( ${lib_name} STATIC ${lib_sources} ${lib_headers} ) 

target_include_directories( ${lib_name}
    PUBLIC
        ${CMAKE_SOURCE_DIR}/common
        ${CMAKE_CURRENT_SOURCE_DIR}/Source/include
        ${CMAKE_CURRENT_SOURCE_DIR}/Source/include
        ${CMAKE_CURRENT_SOURCE_DIR}/Source/portable/ThirdParty/GCC/Posix
        ${CMAKE_CURRENT_SOURCE_DIR}/Source/portable/ThirdParty/GCC/Posix/utils
        ${CMAKE_CURRENT_SOURCE_DIR}/Demo/Common/include
        ${CMAKE_CURRENT_SOURCE_DIR}/../FreeRTOS-Plus/Source/FreeRTOS-Plus-Trace/Include
        ${CMAKE_CURRENT_SOURCE_DIR}/../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/portable/NetworkInterface/linux/
        ${CMAKE_CURRENT_SOURCE_DIR}/../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/include/
        ${CMAKE_CURRENT_SOURCE_DIR}/../FreeRTOS-Plus/Source/FreeRTOS-Plus-TCP/portable/Compiler/GCC/
)