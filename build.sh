if [ -z "${SOC}" ]; then
    echo "SOC is not set, set SOC to j721e/j784s4/j721s2/am62a"
    exit 1
fi

mkdir -p build linux_build/build mcu_build/build c7x_build/build c6x_build/build
cd build
cmake .. && make -j$(nproc)