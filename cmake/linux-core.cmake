if (NOT DEFINED ENV{CORE})
    message(FATAL_ERROR "Core not defined.")
endif()

if (NOT DEFINED ENV{TISDK_PATH})
    message(WARNING "Toolchain path not defined.")
endif()

if ("$ENV{CORE}" STREQUAL "a72" OR "$ENV{CORE}" STREQUAL "a53")
    set(CMAKE_SYSTEM_NAME       Linux)
    set(CMAKE_SYSTEM_PROCESSOR  aarch64)
    set(CROSS_COMPILER_PATH     $ENV{TISDK_PATH}/arm-gnu-toolchain-11.3.rel1-x86_64-aarch64-none-linux-gnu)
    set(CROSS_COMPILER_PREFIX   aarch64-none-linux-gnu-)
    set(TOOLCHAIN_PREFIX        ${CROSS_COMPILER_PATH}/bin/${CROSS_COMPILER_PREFIX})
    set(CMAKE_C_COMPILER        ${TOOLCHAIN_PREFIX}gcc)
    set(CMAKE_CXX_COMPILER      ${TOOLCHAIN_PREFIX}g++)
    set(CMAKE_LINKER            ${TOOLCHAIN_PREFIX}ld)
    set(CMAKE_AR                ${TOOLCHAIN_PREFIX}ar)
else()
    message(WARNING "CROSS_COMPILER_PATH not defined, Using default TOOLCHAIN")
endif()

set(CMAKE_C_COMPILER_WORKS 1)
set(CMAKE_CXX_COMPILER_WORKS 1)

set(CPU_FLAGS "-Wall -fms-extensions -Wno-write-strings -Wno-format-security \
     -fno-short-enums -Wno-stringop-overread -mabi=lp64 -mstrict-align" CACHE STRING "" FORCE)

if ("$ENV{CORE}" STREQUAL "a72")
    set(CPU_FLAGS "${CPU_FLAGS} -mcpu=cortex-a72")

elseif("$ENV{CORE}" STREQUAL "a53")
    set(CPU_FLAGS  "${CPU_FLAGS} -mcpu=cortex-a53")
else()
endif()

if ("${CMAKE_BUILD_TYPE}" STREQUAL "Release")
    set(CPU_FLAGS "${CPU_FLAGS} -O3 -DNDEBUG")
else()
    set(CPU_FLAGS  "${CPU_FLAGS} -ggdb -ggdb3 -gdwarf-2 -D_DEBUG_=1")
endif()

set(CMAKE_C_FLAGS   "${CPU_FLAGS}" CACHE STRING "" FORCE)
set(CMAKE_CXX_FLAGS "${CPU_FLAGS}" CACHE STRING "" FORCE)

if (DEFINED ENV{SOC_TARGET_FS})
    set(CMAKE_SYSROOT           $ENV{SOC_TARGET_FS})
else()
    message(WARNING "TARGET_FS not defined, Using /")
endif()
