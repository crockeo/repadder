# Setting up the project.
cmake_minimum_required(VERSION 2.6)
project(repadder)

# Installing tools to get SDL2.
include(FindPkgConfig)

# Setting output directories.
set(EXECUTABLE_OUTPUT_PATH "${PROJECT_BINARY_DIR}/build/bin")
set(LIBRARY_OUTPUT_PATH "${PROJECT_BINARY_DIR}/build/lib")

# Setting the C++11 flag.
set(CMAKE_CXX_FLAGS "-std=c++11 ${CMAKE_CXX_FLAGS}")

# Setting up the main executable.
add_executable(repadder "src/main.cpp")

# Linking the SDL library.
#pkg_search_module(SDL2 REQUIRED sdl2)
#include_directories(${SDL2_INCLUDE_DIRS})
#target_link_libraries(repadder ${SDL2_LIBRARIES})
