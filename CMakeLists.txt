cmake_minimum_required(VERSION 3.22)
project(cmake_master)

include(cmake/build_flags.cmake)
include(ExternalProject)

if (BUILD_CPU MATCHES yes)
    ExternalProject_Add(linux
            SOURCE_DIR  ${CMAKE_SOURCE_DIR}/linux
            BINARY_DIR  ${CMAKE_SOURCE_DIR}/linux/build
            CMAKE_ARGS  -DCMAKE_TOOLCHAIN_FILE=${CMAKE_SOURCE_DIR}/cmake/linux.cmake
                        -DCMAKE_BUILD_TYPE=Release
            BUILD_ALWAYS    1
            INSTALL_COMMAND ""
    )
endif()

if(BUILD_MCU MATCHES yes)
    ExternalProject_Add(mcu
            SOURCE_DIR  ${CMAKE_SOURCE_DIR}/mcu
            BINARY_DIR  ${CMAKE_SOURCE_DIR}/mcu/build
            CMAKE_ARGS  -DCMAKE_TOOLCHAIN_FILE=${CMAKE_SOURCE_DIR}/cmake/r5f.cmake
                        -DCMAKE_BUILD_TYPE=Release
            BUILD_ALWAYS    1
            INSTALL_COMMAND ""
    )
endif()

if(BUILD_C7X MATCHES yes)
    ExternalProject_Add(c7x
            SOURCE_DIR  ${CMAKE_SOURCE_DIR}/c7x
            BINARY_DIR  ${CMAKE_SOURCE_DIR}/c7x/build
            CMAKE_ARGS  -DCMAKE_TOOLCHAIN_FILE=${CMAKE_SOURCE_DIR}/cmake/c7x.cmake
                        -DCMAKE_BUILD_TYPE=Release
            BUILD_ALWAYS    1
            INSTALL_COMMAND ""
    )
endif()

if(BUILD_C6X MATCHES yes)
    ExternalProject_Add(c6x
            SOURCE_DIR  ${CMAKE_SOURCE_DIR}/c6x
            BINARY_DIR  ${CMAKE_SOURCE_DIR}/c6x/build
            CMAKE_ARGS  -DCMAKE_TOOLCHAIN_FILE=${CMAKE_SOURCE_DIR}/cmake/c6x.cmake
                        -DCMAKE_BUILD_TYPE=Release
            BUILD_ALWAYS    1
            INSTALL_COMMAND ""
    )
endif()