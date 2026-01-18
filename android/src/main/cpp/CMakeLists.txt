cmake_minimum_required(VERSION 3.22)
project(zstdsafe)

# Disable zstd programs and tests
set(ZSTD_BUILD_PROGRAMS OFF CACHE BOOL "" FORCE)
set(ZSTD_BUILD_TESTS OFF CACHE BOOL "" FORCE)
set(ZSTD_BUILD_SHARED OFF CACHE BOOL "" FORCE)
set(ZSTD_BUILD_STATIC ON CACHE BOOL "" FORCE)

add_library(zstd SHARED
    zstd_jni.cpp
)

add_subdirectory(zstd/build/cmake)

target_link_libraries(zstd
    libzstd_static
    log
)
