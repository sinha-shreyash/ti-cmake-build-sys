# TI CMake Build System

![](docs/ticmake.png)

## Description
A Sample CMake Project to Build / Cross-Compile for Different Targets (A72,A53,R5F,C7x and C6x) across Four TI's SOCs (J784S4, J721S2, J721E, AM62A)

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
## Directory Structure
1. The target_build folder i.e c6x_build, c7x_build, linux_build, mcu_build are individual CMake Projects which are configured to build for SOC's respective target cores, they are called from a top level cmake file i.e CMakeLists.txt

2. the cmake folder contains,
    1. Common make configs which are used to build libraries and binaries
    2. Build flags to set the flags for the target core to build for the respective SOC
    3. Tool paths to set the toolchain paths
    4. Target cores i.e r5f.cmake, .. to set compiler specific flags

3. include folder contains the header files
4. src folder contains C files *meant for building libraries*
5. test folder contains main.c files *meant for building executables*

## Usage
1.  Clone the Repo into your workspace
    ```
    git clone --single-branch -b v3 https://github.com/sinha-shreyash/ti-cmake-build-sys.git <project>
    cd <project>
    ```
2.  Set SOC to j721e/j721s2/j784s4/am62a

    *For eg:*

    ```
    export SOC=am62a
    ```
    Check the directory where the toolchains are installed in your setup

    **Note:** The directory name of the toolchains are fixed as of now, please go through tool_paths.cmake inside cmake folder if it is installed in some other directory

3. After placing the necessary .c and .h files in the src and include directories, pass the file to be built (library/  executable) as an argument in the build_lib or build_app function, which is called in CMakeLists.txt inside the targets_build folder. Here, we set a variable LIB_SRC_FILES to a particular file and pass this variable to the build_lib function in CMakeLists, one can append the variable or set a different variable and call build_lib or build_app function to build libs or exe.

    *For eg:*

    ```
    set(EG_LIB_SRC_FILES
    ${TOP_CMAKE_DIR}/src/sub.c)

    build_lib(subtract   
    SHARED                  
    0.1.0                  
    ${EG_LIB_SRC_FILES})
    ```

    **Note:** To build a binary call build_app function and pass the libraries (if needed) and source files as an argument
    
    *For eg:*
    ```
    set(BIN_SRC_FILES
    ${TOP_CMAKE_DIR}/test/calculator.c)

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
