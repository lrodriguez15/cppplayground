#CMakeLists for cpp playground

cmake_minimum_required (VERSION 3.16)

project(CPPPLAYGROUND)

#project VERSION
set(VERSION_MAJOR 0)
set(VERSION_MINOR 1)
set(VERSION_PATCH 0)

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

add_subdirectory(app)
