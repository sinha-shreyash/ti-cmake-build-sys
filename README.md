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

3. Adding Files:
    1. Place your .c and .h files in the src and include directories.
    2. Specify the file to be built (library or executable) by setting a variable (e.g., LIB_SRC_FILES).

4. Building Libraries:
    1. Ex: Consider mcu_build as Build Folder
    2. Pass the appropriate source files and other parameters (e.g., version, shared/static).
    3. User will Call the build_lib function in CMakeLists.txt within the target build folder.

    *For eg:*

    ```
    set(EG_LIB_SRC_FILES
    ${TOP_CMAKE_DIR}/src/sub.c)

    build_lib(subtract
    SHARED
    0.1.0
    ${EG_LIB_SRC_FILES})
    ```

5. Building Executables:
    1. Ex: Consider linux_build as Build Folder
    2. User will call the build_app function in CMakeLists.txt similarly to build binaries.
    3. Specify all required libraries.

    *For eg:*
    ```
    set(BIN_SRC_FILES
    ${TOP_CMAKE_DIR}/test/calculator.c)

    build_app(main
            lib_name
            ${BIN_SRC_FILES})
    ```

6.  Running the Build Script:
    1. Execute ./build.sh to trigger CMake.
    2. Clean the build with make clean.

    *For eg:*

    ```
    ./build.sh
    make clean
    ```

7.  The built binaries and libraries will be present inside,
    - SOC/CORE/bin/Release/ folder
    - SOC/CORE/lib/Release/ folder

8.  To install the binaries or libraries,
    ```
    sudo make install
    ```
