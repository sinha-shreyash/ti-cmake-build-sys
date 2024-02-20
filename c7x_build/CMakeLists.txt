cmake_minimum_required(VERSION 3.22)
project(add2Nos)

include(common)

set(LIB_SRC_FILES
    ${TOP_CMAKE_DIR}/src/add.c)

build_lib(${PROJECT_NAME}   # Named argument: library name
    SHARED                  # Named argument: library type
    0.1.0                   # Named argument: library version
    ${LIB_SRC_FILES})
