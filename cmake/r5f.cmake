cmake_path(GET CMAKE_CURRENT_SOURCE_DIR PARENT_PATH TOP_CMAKE_DIR)
list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR};${TOP_CMAKE_DIR}/cmake")
include(tool_paths)

if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE Release)
endif()

set(CORE                    r5f)
set(CMAKE_SYSTEM_NAME       Generic)
set(CMAKE_SYSTEM_PROCESSOR  arm)
set(CROSS_COMPILER_PREFIX   tiarm)
set(TOOLCHAIN_PREFIX        ${TIARMCGT_LLVM_ROOT}/bin/${CROSS_COMPILER_PREFIX})
set(CMAKE_C_COMPILER        ${TOOLCHAIN_PREFIX}clang)
set(CMAKE_CXX_COMPILER      ${TOOLCHAIN_PREFIX}clang)
set(CMAKE_LINKER            ${TOOLCHAIN_PREFIX}lnk)
set(CMAKE_AR                ${TOOLCHAIN_PREFIX}ar)

set(CMAKE_C_COMPILER_WORKS 1)
set(CMAKE_CXX_COMPILER_WORKS 1)

set(SUPPRESS_WARNING_FLAGS "-Wno-dev -Wall -Wno-extra -Wno-exceptions -ferror-limit=100 \
    -Wno-unused-command-line-argument -Wno-gnu-variable-sized-type-not-at-end \
    -Wno-unused-function -Wno-address-of-packed-member \
    -Wno-bitfield-constant-conversion -Wno-excess-initializers \
    -Wno-extern-initializer -Weverything -Wno-deprecated -Weverything -Wno-deprecated" CACHE STRING "" FORCE)

set(CPU_FLAGS "-mfloat-abi=hard -mfpu=vfpv3-d16 \
    -mcpu=cortex-r5 -march=armv7-r -fno-strict-aliasing" CACHE STRING "" FORCE)

if (${CMAKE_BUILD_TYPE} MATCHES Release)
    set(CPU_FLAGS "${CPU_FLAGS} -Oz")
else()
    set(CPU_FLAGS  "${CPU_FLAGS} -O0 -g")
endif()

set(CMAKE_C_FLAGS   "${CMAKE_C_FLAGS} ${SUPPRESS_WARNING_FLAGS} ${CPU_FLAGS}" CACHE STRING "" FORCE)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${SUPPRESS_WARNING_FLAGS} ${CPU_FLAGS}" CACHE STRING "" FORCE)

add_link_options(-Wl,--use_memcpy=fast -Wl,--use_memset=fast
                -Wl,--diag_suppress=10063-D -Wl,--diag_suppress=10068-D
                -Wl,--zero_init=on -Wl,--rom_model)

if (DEFINED TIARMCGT_LLVM_ROOT)
    set(CMAKE_SYSROOT           ${TIARMCGT_LLVM_ROOT})
endif()