if [ -z "${SOC}" ]; then
    echo "SOC is not set, set SOC to j721e/j784s4/j721s2/am62a"
    exit 1
fi

mkdir -p build linux/build mcu/build c7x/build c6x/build
cd build
cmake .. && make -j$(nproc)