# Setting up the project.
cmake_minimum_required(VERSION 2.6)
project(repadder)

# Setting output directories.
set(EXECUTABLE_OUTPUT_PATH "${PROJECT_BINARY_DIR}/build/bin")
set(LIBRARY_OUTPUT_PATH "${PROJECT_BINARY_DIR}/build/lib")

# Setting the C++11 flag.
set(CMAKE_CXX_FLAGS "-std=c++11 ${CMAKE_CXX_FLAGS}")

# Setting the location of the Frameworks.
set(CMAKE_CXX_FLAGS "-F/Library/Frameworks ${CMAKE_CXX_FLAGS}")

# Linking SDL2.
set(CMAKE_CXX_FLAGS "-framework SDL2 ${CMAKE_CXX_FLAGS}")

# Setting up the main executable.
add_executable(repadder "src/main.cpp")
