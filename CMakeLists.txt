cmake_minimum_required(VERSION 3.22)
project(add2Nos)

include(cmake/build_flags.cmake)
include(cmake/common.cmake)

set(LIB_SRC_FILES
    src/add.c)

build_lib(${PROJECT_NAME}   # Named argument: library name
    SHARED                  # Named argument: library type
    0.1.0                   # Named argument: library version
    ${LIB_SRC_FILES})
