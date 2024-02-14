# Compilers
set (PSDK_TOOL_PATH         $ENV{HOME}/ti)
set (GCC_LINUX_ARM_ROOT     ${PSDK_TOOL_PATH}/arm-gnu-toolchain-11.3.rel1-x86_64-aarch64-none-linux-gnu)
set (TIARMCGT_LLVM_ROOT     ${PSDK_TOOL_PATH}/ti-cgt-armllvm_3.2.0.LTS)
set (CGT7X_ROOT             ${PSDK_TOOL_PATH}/ti-cgt-c7000_3.1.0.LTS)
set (CGT6X_ROOT             ${PSDK_TOOL_PATH}/ti-cgt-c6000_8.3.12)

# CMake Linux Sysroot Path
set (LINUX_TARGET_FS         $ENV{HOME}/sdk_workareas/$ENV{SOC}/targetfs)
