list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")
include(tool_paths)

if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE Release)
endif()

set(CORE C6x)

if ($ENV{SOC} MATCHES j721e)
    set(CMAKE_SYSTEM_NAME           Generic)
    set(CROSS_COMPILER_POSTFIX      6x)
    set(CMAKE_C_COMPILER            ${CGT6X_ROOT}/bin/cl${CROSS_COMPILER_POSTFIX})
    set(CMAKE_CXX_COMPILER          ${CGT6X_ROOT}/bin/cl${CROSS_COMPILER_POSTFIX})
    set(CMAKE_LINKER                ${CGT6X_ROOT}/bin/cl${CROSS_COMPILER_POSTFIX})
    set(CMAKE_AR                    ${CGT6X_ROOT}/bin/ar${CROSS_COMPILER_POSTFIX})
    set(COMPILE_FLAGS               "--silicon_version=6600")
else()
    message(FATAL_ERROR "Given SOC doesnt have C6x DSP")
endif()

set(CMAKE_C_COMPILER_WORKS 1)
set(CMAKE_CXX_COMPILER_WORKS 1)

set(CPU_FLAGS "--abi=eabi --gcc --gen_func_subsections" CACHE STRING "" FORCE)

if (${CMAKE_BUILD_TYPE} MATCHES Release)
    set(CPU_FLAGS "${CPU_FLAGS} --opt_level=3 --gen_opt_info=2 -DNDEBUG")
else()
    set(CPU_FLAGS  "${CPU_FLAGS} -g -D_DEBUG_=1")
endif()

set(CMAKE_C_FLAGS   "${COMPILE_FLAGS} ${CPU_FLAGS}" CACHE STRING "" FORCE)
set(CMAKE_CXX_FLAGS "${COMPILE_FLAGS} ${CPU_FLAGS}" CACHE STRING "" FORCE)

add_link_options(--zero_init=on --warn_sections --reread_libs --rom_model)

if (DEFINED CGT6X_ROOT)
    set(CMAKE_SYSROOT           ${CGT6X_ROOT})
else()
    message(WARNING "TARGET_FS not defined, Using /")
endif()
