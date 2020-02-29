#CMakeLists for cpp playground

cmake_minimum_required (VERSION 3.5)

project(INTERPOLATION)

#project VERSION
set(VERSION_MAJOR 0)
set(VERSION_MINOR 1)
set(VERSION_PATCH 0)

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)


add_compile_options(
  "-Wall" "-Wextra" "-Werror" "-Wpedantic" "--coverage"
)

if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang")
    add_compile_options(
    "$<$<CONFIG:Debug>:-fsanitize-trap=undefined>"
    "$<$<CONFIG:Debug>:-fsanitize=undefined>"
    )
else ()
    add_compile_options("$<$<CONFIG:Debug>:-fsanitize=undefined,address>"
    )
endif ()

add_compile_options("$<$<CONFIG:Debug>:-fno-omit-frame-pointer>"
)

add_subdirectory(app)
