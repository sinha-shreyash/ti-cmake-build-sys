if (NOT DEFINED ENV{CORE})
    message(WARNING "Core not defined.")
endif()

if (NOT DEFINED ENV{TISDK_PATH})
    message(WARNING "Toolchain path not defined.")
endif()

if ("$ENV{CORE}" STREQUAL "c7x" AND "$ENV{SOC}" STREQUAL "j721e")
    set(CMAKE_SYSTEM_NAME           Generic)
    set(CROSS_COMPILER_PATH         $ENV{TISDK_PATH}/ti-cgt-c7000_3.1.0.LTS)
    set(CROSS_COMPILER_POSTFIX      7x)
    set(CMAKE_C_COMPILER            ${CROSS_COMPILER_PATH}/bin/cl${CROSS_COMPILER_POSTFIX})
    set(CMAKE_CXX_COMPILER          ${CROSS_COMPILER_PATH}/bin/cl${CROSS_COMPILER_POSTFIX})
    set(CMAKE_LINKER                ${CROSS_COMPILER_PATH}/bin/cl${CROSS_COMPILER_POSTFIX})
    set(CMAKE_AR                    ${CROSS_COMPILER_PATH}/bin/ar${CROSS_COMPILER_POSTFIX})
    set(COMPILE_FLAGS               "--silicon_version=7100 --silicon_errata_i2117")
    set(AR_FLAGS                    "--silicon_version=7100")

elseif("$ENV{CORE}" STREQUAL "c7x" AND ("$ENV{SOC}" STREQUAL "j721s2" OR "$ENV{SOC}" STREQUAL "j784s4"))
    set(CMAKE_SYSTEM_NAME           Generic)
    set(CROSS_COMPILER_PATH         $ENV{TISDK_PATH}/ti-cgt-c7000_3.1.0.LTS)
    set(CROSS_COMPILER_POSTFIX      7x)
    set(CMAKE_C_COMPILER            ${CROSS_COMPILER_PATH}/bin/cl${CROSS_COMPILER_POSTFIX})
    set(CMAKE_CXX_COMPILER          ${CROSS_COMPILER_PATH}/bin/cl${CROSS_COMPILER_POSTFIX})
    set(CMAKE_LINKER                ${CROSS_COMPILER_PATH}/bin/cl${CROSS_COMPILER_POSTFIX})
    set(CMAKE_AR                    ${CROSS_COMPILER_PATH}/bin/ar${CROSS_COMPILER_POSTFIX})
    set(COMPILE_FLAGS               "--silicon_version=7120")
    set(AR_FLAGS                    "--silicon_version=7120")

elseif("$ENV{CORE}" STREQUAL "c7x" AND "$ENV{SOC}" STREQUAL "am62a")
    set(CMAKE_SYSTEM_NAME           Generic)
    set(CROSS_COMPILER_PATH         $ENV{TISDK_PATH}/ti-cgt-c7000_3.1.0.LTS)
    set(CROSS_COMPILER_POSTFIX      7x)
    set(CMAKE_C_COMPILER            ${CROSS_COMPILER_PATH}/bin/cl${CROSS_COMPILER_POSTFIX})
    set(CMAKE_CXX_COMPILER          ${CROSS_COMPILER_PATH}/bin/cl${CROSS_COMPILER_POSTFIX})
    set(CMAKE_LINKER                ${CROSS_COMPILER_PATH}/bin/cl${CROSS_COMPILER_POSTFIX})
    set(CMAKE_AR                    ${CROSS_COMPILER_PATH}/bin/ar${CROSS_COMPILER_POSTFIX})
    set(COMPILE_FLAGS               "--silicon_version=7504")
    set(AR_FLAGS                    "--silicon_version=7504")
else()
    message(WARNING "CROSS_COMPILER_PATH not defined, Using default TOOLCHAIN")
endif()

set(CMAKE_C_COMPILER_WORKS 1)
set(CMAKE_CXX_COMPILER_WORKS 1)

include_directories(${CROSS_COMPILER_PATH}/include)
link_directories(${CROSS_COMPILER_PATH}/lib)

set(CPU_FLAGS "--abi=eabi --gcc --gen_func_subsections" CACHE STRING "" FORCE)

set(CMAKE_C_FLAGS   "${COMPILE_FLAGS} ${CPU_FLAGS}" CACHE STRING "" FORCE)
set(CMAKE_CXX_FLAGS "${COMPILE_FLAGS} ${CPU_FLAGS}" CACHE STRING "" FORCE)

set(CMAKE_STATIC_LINKER_FLAGS "${AR_FLAGS}" CACHE STRING "" FORCE)

add_link_options(--issue_remarks --warn_sections --reread_libs --rom_model)

if (DEFINED ENV{SOC_TARGET_FS})
    set(CMAKE_SYSROOT           $ENV{SOC_TARGET_FS})
else()
    message(WARNING "TARGET_FS not defined, Using /")
endif()
