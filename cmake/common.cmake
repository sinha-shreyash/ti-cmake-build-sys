include(GNUInstallDirs)

file(REMOVE_RECURSE ${CMAKE_SOURCE_DIR}/bin/
                    ${CMAKE_SOURCE_DIR}/lib/)

file(MAKE_DIRECTORY ${CMAKE_SOURCE_DIR}/bin/$ENV{SOC}/${CMAKE_BUILD_TYPE}/${CORE}
                    ${CMAKE_SOURCE_DIR}/lib/$ENV{SOC}/${CMAKE_BUILD_TYPE}/${CORE})

if(NOT CMAKE_OUTPUT_DIR)
  set(CMAKE_OUTPUT_DIR ${CMAKE_SOURCE_DIR})
endif()

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_OUTPUT_DIR}/lib/$ENV{SOC}/${CMAKE_BUILD_TYPE}/${CORE})
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_OUTPUT_DIR}/lib/$ENV{SOC}/${CMAKE_BUILD_TYPE}/${CORE})
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_OUTPUT_DIR}/bin/$ENV{SOC}/${CMAKE_BUILD_TYPE}/${CORE})

if(CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)
    set(CMAKE_INSTALL_PREFIX /usr CACHE PATH "Installation Prefix" FORCE)
endif()

include_directories(${CMAKE_SOURCE_DIR}/include
                    ${CGT7X_ROOT}/include
                    ${CGT6X_ROOT}/include)

link_directories( ${CMAKE_SOURCE_DIR}/lib
                  ${CGT7X_ROOT}/lib
                  ${CGT6X_ROOT}/lib)

function(build_app app_name lib_name)
    add_executable(${app_name} ${ARGN})
    target_link_libraries(${app_name}
                          ${lib_name}
                        )

    set(BIN_INSTALL_DIR ${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_BINDIR})
    set(BINS ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/${app_name})

    install(FILES ${BINS}
            PERMISSIONS OWNER_EXECUTE OWNER_WRITE OWNER_READ
            DESTINATION ${BIN_INSTALL_DIR})

endfunction()

function(build_lib lib_name lib_type lib_ver)
    add_library(${lib_name} ${lib_type} ${ARGN})

    SET_TARGET_PROPERTIES(${lib_name}
                          PROPERTIES
                          VERSION ${lib_ver}
                         )

    set(INCLUDE_INSTALL_DIR ${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_INCLUDEDIR}/${PROJECT_NAME})

    FILE(GLOB HDRS ${CMAKE_CURRENT_SOURCE_DIR}/include/*.h)

    install(TARGETS ${lib_name}
            EXPORT ${lib_name}Targets
            LIBRARY DESTINATION ${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR}  # Shared Libs
            ARCHIVE DESTINATION ${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR}  # Static Libs
            RUNTIME DESTINATION ${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_BINDIR}  # Executables, DLLs
           )

    # Specify the header files to install
    install(FILES ${HDRS} DESTINATION ${INCLUDE_INSTALL_DIR})

endfunction()
