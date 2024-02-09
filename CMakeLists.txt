cmake_minimum_required(VERSION 3.22)
project(main)

if(NOT DEFINED CMAKE_BUILD_TYPE)
  SET(CMAKE_BUILD_TYPE Release)
endif()

if (NOT DEFINED ENV{SOC})
    message(WARNING "SOC not defined.")
endif()

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/lib/${CMAKE_BUILD_TYPE})
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/lib/${CMAKE_BUILD_TYPE})
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/bin/${CMAKE_BUILD_TYPE})

include_directories(${CMAKE_SOURCE_DIR}/include)
add_library($ENV{SOC}-$ENV{CORE} STATIC ${CMAKE_SOURCE_DIR}/src/add.c)

add_executable(main ${CMAKE_SOURCE_DIR}/test/main.c)
target_link_libraries(main $ENV{SOC}-$ENV{CORE})

set_target_properties($ENV{SOC}-$ENV{CORE} PROPERTIES PUBLIC_HEADER "add.h")

install(TARGETS $ENV{SOC}-$ENV{CORE} LIBRARY DESTINATION lib
        PUBLIC_HEADER DESTINATION include)
