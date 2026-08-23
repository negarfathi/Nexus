cmake_minimum_required(VERSION 4.0)
project(Nexus LANGUAGES C CXX)

# ------------------------------------------------------------------
# C++ standard
# ------------------------------------------------------------------
set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS ON)

# ------------------------------------------------------------------
# Homebrew package locations
# ------------------------------------------------------------------
list(APPEND CMAKE_PREFIX_PATH
        "/opt/homebrew"
        "/opt/homebrew/opt/llvm"
        "/opt/homebrew/opt/nlohmann-json"
        "/opt/homebrew/opt/curl"
)

# ------------------------------------------------------------------
# LLVM
# ------------------------------------------------------------------
find_package(LLVM REQUIRED CONFIG)

message(STATUS "Found LLVM ${LLVM_PACKAGE_VERSION}")
message(STATUS "Using LLVMConfig.cmake in: ${LLVM_DIR}")

include_directories(${LLVM_INCLUDE_DIRS})
add_definitions(${LLVM_DEFINITIONS})

# ------------------------------------------------------------------
# Clang
# ------------------------------------------------------------------
find_package(Clang REQUIRED CONFIG)

message(STATUS "Using ClangConfig.cmake in: ${Clang_DIR}")

include_directories(${CLANG_INCLUDE_DIRS})

# ------------------------------------------------------------------
# nlohmann/json
# ------------------------------------------------------------------
find_package(nlohmann_json CONFIG REQUIRED)

# ------------------------------------------------------------------
# CURL
# ------------------------------------------------------------------
find_package(CURL REQUIRED)

message(STATUS "Found CURL ${CURL_VERSION_STRING}")
message(STATUS "CURL libraries: ${CURL_LIBRARIES}")

# ------------------------------------------------------------------
# OpenXLSX
# ------------------------------------------------------------------
include(FetchContent)

FetchContent_Declare(
        OpenXLSX
        GIT_REPOSITORY https://github.com/troldal/OpenXLSX.git
        GIT_TAG master
)

set(OPENXLSX_CREATE_DOCS OFF)
set(OPENXLSX_BUILD_SAMPLES OFF)
set(OPENXLSX_BUILD_TESTS OFF)
set(OPENXLSX_BUILD_BENCHMARKS OFF)
set(BUILD_SHARED_LIBS OFF)

set(CMAKE_POLICY_VERSION_MINIMUM 3.5)

FetchContent_MakeAvailable(OpenXLSX)

# ------------------------------------------------------------------
# Nexus executable
# ------------------------------------------------------------------
add_executable(Nexus
        src/main.cpp

        src/inline_attribute_injector.cpp
        include/inline_attribute_injector.h

        src/loop_information_extractor.cpp
        include/loop_information_extractor.h

        src/candidate_synthesizer.cpp
        include/candidate_synthesizer.h

        src/candidate_parser.cpp
        include/candidate_parser.h

        src/validator_generator.cpp
        include/validator_generator.h

        src/experiment_recorder.cpp
        include/experiment_recorder.h
)

# ------------------------------------------------------------------
# Project headers
# ------------------------------------------------------------------
target_include_directories(Nexus
        PRIVATE
        ${CMAKE_CURRENT_SOURCE_DIR}/include
        ${OpenXLSX_INCLUDES}
)

# ------------------------------------------------------------------
# Libraries
# ------------------------------------------------------------------
target_link_libraries(Nexus
        PRIVATE

        # LLVM
        LLVM

        # Clang
        clangAST
        clangFrontend
        clangTooling

        # JSON
        nlohmann_json::nlohmann_json

        # HTTP client used for OpenAI API
        CURL::libcurl

        # Excel
        OpenXLSX::OpenXLSX
)