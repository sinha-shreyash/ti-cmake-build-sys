# TI CMake Build System

![](docs/TI.png)

## Description
A Sample CMake Project to Build / Cross-Compile for Different Cores (A72,A53,R5F,C7x and C6x) across Four TI's SOCs (J784S4, J721S2, J721E, AM62A)

## Usage
1.  Clone the Repo into your workspace
    ```
    git clone https://github.com/sinha-shreyash/ti-cmake-build-sys.git <project>
    cd <project>
    ```
2.  In setup.sh, set TISDK_PATH (root directory of installed toolchains), SOC name (j721e/j784s4/j721s2/am62a), Core name (a72/a53/c7x/r5f/c6x) and
    the release type you want to build for (Release/Debug)
    eg:-
    ```
    export TISDK_PATH=<root dir of the installed toolchains>
    export SOC=am62a
    export CORE=a53
    export CMAKE_BUILD_TYPE=Release
    ```
    Note: The directory name of the toolchains are fixated as of now, please update the TARGET_SOC variable if there are any further updates

3.  ```
    source setup.sh
    mkdir build/ lib/ bin/
    ```
4.  ```
    cd build
    cmake ..
    make -j$(nproc)
    ```

5.  To clean build
    ```
    make clean
    ```

6.  The built binaries and libraries will be present inside the bin/build-type/ and lib/'build-type'/ folders

7.  To install the binaries or libraries,
    ```
    sudo make install
    ```
