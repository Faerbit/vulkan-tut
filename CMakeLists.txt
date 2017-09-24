cmake_minimum_required(VERSION 3.0)
list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")
include("CompileGLSL")

project(vulkan-triangle)

set (CMAKE_CXX_STANDARD 14)

find_package(glfw3 3.2 REQUIRED)
find_package(Vulkan REQUIRED)

file(GLOB SOURCE_FILES "${CMAKE_SOURCE_DIR}/src/*.cpp")

include_directories("${CMAKE_SOURCE_DIR}/src")
#include_directories(${glfw3_INCLUDE_DIRS})
#include_directories(${Vulkan_INCLUDE_DIRS})

compile_glsl("${CMAKE_SOURCE_DIR}/src/shaders/default.vert" "VERTEX_SHADER" "vertexShader.h")
compile_glsl("${CMAKE_SOURCE_DIR}/src/shaders/default.frag" "FRAGMENT_SHADER" "fragmentShader.h")

add_executable(vulkan-triangle ${SOURCE_FILES})
add_dependencies(vulkan-triangle compile-shaders)
target_link_libraries(vulkan-triangle glfw)
target_link_libraries(vulkan-triangle Vulkan::Vulkan)
