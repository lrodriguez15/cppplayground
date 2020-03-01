set(BINARY ${CMAKE_PROJECT_NAME}_tst)

file(GLOB_RECURSE TEST_SOURCES LIST_DIRECTORIES false *.h *.cpp)
set(SOURCES ${TEST_SOURCES})

add_executable(${BINARY} ${TEST_SOURCES})

add_test(NAME ${BINARY} COMMAND ${BINARY})

#add_dependencies(${BINARY} GoogleTest)
    target_include_directories(
        ${BINARY}
        SYSTEM PRIVATE "${CMAKE_BINARY_DIR}/include"
    )

    target_include_directories(
        ${BINARY}
        PRIVATE "${PROJECT_SOURCE_DIR}/src"
    )

    add_dependencies(${BINARY} dummy_lib
    )
    target_link_libraries(${BINARY} dummy_lib
                                    gtest_main
                          "$<$<CONFIG:Debug>:-lasan>")

message("${CMAKE_BUILD_DIRECTORY}")

    target_link_libraries(${BINARY}
        "${CMAKE_BUILD_DIRECTORY}googletest/googletest-build/googlemock/gtest/libgtest_main.a"
        "${CMAKE_BUILD_DIRECTORY}googletest/googletest-build/googlemock/gtest/libgtest.a"
       general pthread
    )