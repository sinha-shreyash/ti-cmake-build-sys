export TISDK_PATH=/home/edgeai/ti
export SOC=j784s4
export CORE=a72
export CMAKE_BUILD_TYPE=Debug

if [[ $CORE == "a72" || $CORE == "a53" ]]
then
	export CMAKE_TOOLCHAIN_FILE=./cmake/linux-core.cmake
    if [ $SOC == "j721e" ]
    then
        export SOC_TARGET_FS=/home/edgeai/sdk_workareas/j721e/targetfs
    elif [ $SOC == "j721s2" ]
    then
        export SOC_TARGET_FS=/home/edgeai/sdk_workareas/j721s2/targetfs
    elif [ $SOC == "j784s4" ]
    then
        export SOC_TARGET_FS=/home/edgeai/sdk_workareas/j784s4/targetfs
    elif [ $SOC == "am62a" ]
    then
        export SOC_TARGET_FS=/home/edgeai/sdk_workareas/am62a/targetfs
    fi
elif [ $CORE == "r5" ]
then
    export SOC_TARGET_FS=/home/edgeai/ti/ti-cgt-armllvm_3.2.0.LTS
    export CMAKE_TOOLCHAIN_FILE=./cmake/soc-r5.cmake
elif [ $CORE == "c7x" ]
then
    export SOC_TARGET_FS=/home/edgeai/ti/ti-cgt-c7000_3.1.0.LTS
	export CMAKE_TOOLCHAIN_FILE=./cmake/soc-c7x.cmake
elif [ $CORE == "c6x" ]
then
    export SOC_TARGET_FS=/home/edgeai/ti/ti-cgt-c6000_8.3.12
	export CMAKE_TOOLCHAIN_FILE=./cmake/soc-c6x.cmake
else
    true
fi
