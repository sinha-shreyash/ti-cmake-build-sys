if (NOT DEFINED ENV{CORE})
    message(WARNING "Core not defined.")
endif()

if (NOT DEFINED ENV{TISDK_PATH})
    message(WARNING "Toolchain path not defined.")
endif()

if ("$ENV{CORE}" STREQUAL "c6x" AND "$ENV{SOC}" STREQUAL "j721e")
    set(CMAKE_SYSTEM_NAME           Generic)
    set(CROSS_COMPILER_PATH         $ENV{TISDK_PATH}/ti-cgt-c6000_8.3.12)
    set(CROSS_COMPILER_POSTFIX      6x)
    set(CMAKE_C_COMPILER            ${CROSS_COMPILER_PATH}/bin/cl${CROSS_COMPILER_POSTFIX})
    set(CMAKE_CXX_COMPILER          ${CROSS_COMPILER_PATH}/bin/cl${CROSS_COMPILER_POSTFIX})
    set(CMAKE_LINKER                ${CROSS_COMPILER_PATH}/bin/cl${CROSS_COMPILER_POSTFIX})
    set(CMAKE_AR                    ${CROSS_COMPILER_PATH}/bin/ar${CROSS_COMPILER_POSTFIX})
    set(COMPILE_FLAGS               "--silicon_version=6600")

else()
    message(FATAL_ERROR "Given SOC doesnt have C6x DSP")
endif()

set(CMAKE_C_COMPILER_WORKS 1)
set(CMAKE_CXX_COMPILER_WORKS 1)

include_directories(${CROSS_COMPILER_PATH}/include)
link_directories(${CROSS_COMPILER_PATH}/lib)

set(CPU_FLAGS "--abi=eabi --gcc --gen_func_subsections" CACHE STRING "" FORCE)

if ("${CMAKE_BUILD_TYPE}" STREQUAL "Release")
    set(CPU_FLAGS "${CPU_FLAGS} --opt_level=3 --gen_opt_info=2 -DNDEBUG")
else()
    set(CPU_FLAGS  "${CPU_FLAGS} -g -D_DEBUG_=1")
endif()

set(CMAKE_C_FLAGS   "${COMPILE_FLAGS} ${CPU_FLAGS}" CACHE STRING "" FORCE)
set(CMAKE_CXX_FLAGS "${COMPILE_FLAGS} ${CPU_FLAGS}" CACHE STRING "" FORCE)

add_link_options(--zero_init=on --warn_sections --reread_libs --rom_model)

if (DEFINED ENV{SOC_TARGET_FS})
    set(CMAKE_SYSROOT           $ENV{SOC_TARGET_FS})
else()
    message(WARNING "TARGET_FS not defined, Using /")
endif()
