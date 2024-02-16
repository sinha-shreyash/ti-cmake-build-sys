# TI CMake Build System

![](docs/TI.png)

## Description
A Sample CMake Project to Build / Cross-Compile for Different Cores (A72,A53,R5F,C7x and C6x) across Four TI's SOCs (J784S4, J721S2, J721E, AM62A)

## Dependencies
CMake 3.22.1 version is atleast required

Installation Steps:
```
wget https://cmake.org/files/v3.22/cmake-3.22.1.tar.gz
tar xf cmake-3.22.1.tar.gz
cd cmake-3.22.1
./configure
make
sudo make install
```

## Usage
1.  Clone the Repo into your workspace
    ```
    git clone --single-branch -b v3 https://github.com/sinha-shreyash/ti-cmake-build-sys.git <project>
    cd <project>
    ```
2.  Set SOC to j721e/j721s2/j784s4/am62a
    eg:
    ```
    export SOC=am62a
    ```
    Check the directory where the toolchains are installed in your setup

    Note: The directory name of the toolchains are fixed as of now, please go through tool_paths.cmake inside cmake folder if it is installed in some other directory

3.  Place the source files to be built as library for the respective target core inside LIB_SRC_FILES variable in the target core's         CMakeLists.txt.
    For eg:
    ```
    set(LIB_SRC_FILES
    ${TOP_CMAKE_DIR}/src/add.c)
    ```
    Note: One can build a binary by setting a variable to take in source files and call build_app function
    For eg:
    ```
    set(BIN_SRC_FILES
    ${TOP_CMAKE_DIR}/test/main.c)

    build_app(main
            lib_name
            ${BIN_SRC_FILES})
    ```
4.  The build script creates the build directories in the target cores and triggers cmake
    ```
    ./build.sh
    ```

5.  To clean build
    ```
    make clean
    ```

6.  The built binaries and libraries will be present inside the TARGET_CORE/bin/SOC/build-type/ and TARGET_CORE/lib/SOC/build-type/ folders

7.  To install the binaries or libraries,
    ```
    sudo make install
    ```
