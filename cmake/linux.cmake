cmake_path(GET CMAKE_CURRENT_SOURCE_DIR PARENT_PATH TOP_CMAKE_DIR)
list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR};${TOP_CMAKE_DIR}/cmake")
include(tool_paths)

if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE Release)
endif()

set(CORE                    linux)
set(CMAKE_SYSTEM_NAME       Linux)
set(CMAKE_SYSTEM_PROCESSOR  aarch64)
set(CROSS_COMPILER_PREFIX   aarch64-none-linux-gnu-)
set(TOOLCHAIN_PREFIX        ${GCC_LINUX_ARM_ROOT}/bin/${CROSS_COMPILER_PREFIX})
set(CMAKE_C_COMPILER        ${TOOLCHAIN_PREFIX}gcc)
set(CMAKE_CXX_COMPILER      ${TOOLCHAIN_PREFIX}g++)
set(CMAKE_LINKER            ${TOOLCHAIN_PREFIX}ld )
set(CMAKE_AR                ${TOOLCHAIN_PREFIX}ar )

set(CMAKE_C_COMPILER_WORKS 1)
set(CMAKE_CXX_COMPILER_WORKS 1)

set(CPU_FLAGS "-Wno-dev -Wall -fms-extensions -Wno-write-strings -Wno-format-security \
-fno-short-enums -Wno-stringop-overread -mabi=lp64 -mstrict-align")

if (${MPU_CPU} MATCHES a72)
set(CPU_FLAGS "${CPU_FLAGS} -mcpu=cortex-a72")

elseif(${MPU_CPU} MATCHES a53)
set(CPU_FLAGS  "${CPU_FLAGS} -mcpu=cortex-a53")
else()
endif()

if (${CMAKE_BUILD_TYPE} MATCHES Release)
    set(CPU_FLAGS "${CPU_FLAGS} -O3 -DNDEBUG")
    else()
    set(CPU_FLAGS  "${CPU_FLAGS} -ggdb -ggdb3 -gdwarf-2 -D_DEBUG_=1")
endif()

set(CMAKE_C_FLAGS   "${CPU_FLAGS}")
set(CMAKE_CXX_FLAGS "${CPU_FLAGS}")

set(CMAKE_SYSROOT           ${LINUX_TARGET_FS})
