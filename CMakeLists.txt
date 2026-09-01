cmake_minimum_required(VERSION 4.0)
project(Nexus LANGUAGES C CXX)

# C++ standard
set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS ON)

# macOS paths
if(APPLE)
    list(APPEND CMAKE_PREFIX_PATH
            "/opt/homebrew"
            "/opt/homebrew/opt/llvm"
            "/opt/homebrew/opt/nlohmann-json"
            "/opt/homebrew/opt/curl"
            "/usr/local"
            "/usr/local/opt/llvm"
            "/usr/local/opt/nlohmann-json"
            "/usr/local/opt/curl"
    )
endif()

# LLVM
find_package(LLVM REQUIRED CONFIG)

message(STATUS "Found LLVM ${LLVM_PACKAGE_VERSION}")
message(STATUS "Using LLVMConfig.cmake in: ${LLVM_DIR}")

include_directories(${LLVM_INCLUDE_DIRS})
add_definitions(${LLVM_DEFINITIONS})

# Clang
find_package(Clang REQUIRED CONFIG)

message(STATUS "Using ClangConfig.cmake in: ${Clang_DIR}")

include_directories(${CLANG_INCLUDE_DIRS})

# LLVM tools
find_program(CLANG_EXECUTABLE
        NAMES clang
        PATHS "${LLVM_TOOLS_BINARY_DIR}"
        NO_DEFAULT_PATH
        REQUIRED
)

find_program(OPT_EXECUTABLE
        NAMES opt
        PATHS "${LLVM_TOOLS_BINARY_DIR}"
        NO_DEFAULT_PATH
        REQUIRED
)

find_program(LLVM_DIS_EXECUTABLE
        NAMES llvm-dis
        PATHS "${LLVM_TOOLS_BINARY_DIR}"
        NO_DEFAULT_PATH
        REQUIRED
)

message(STATUS "Using clang: ${CLANG_EXECUTABLE}")
message(STATUS "Using opt: ${OPT_EXECUTABLE}")
message(STATUS "Using llvm-dis: ${LLVM_DIS_EXECUTABLE}")

file(TO_CMAKE_PATH "${CLANG_EXECUTABLE}" CLANG_EXECUTABLE_CMAKE)
file(TO_CMAKE_PATH "${OPT_EXECUTABLE}" OPT_EXECUTABLE_CMAKE)
file(TO_CMAKE_PATH "${LLVM_DIS_EXECUTABLE}" LLVM_DIS_EXECUTABLE_CMAKE)

# JSON
find_package(nlohmann_json CONFIG REQUIRED)

# CURL
find_package(CURL REQUIRED)

message(STATUS "Found CURL ${CURL_VERSION_STRING}")
message(STATUS "CURL libraries: ${CURL_LIBRARIES}")

# OpenXLSX
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

# Nexus
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

# Tool paths
target_compile_definitions(Nexus
        PRIVATE
        NEXUS_CLANG_EXECUTABLE="${CLANG_EXECUTABLE_CMAKE}"
        NEXUS_OPT_EXECUTABLE="${OPT_EXECUTABLE_CMAKE}"
        NEXUS_LLVM_DIS_EXECUTABLE="${LLVM_DIS_EXECUTABLE_CMAKE}"
)

# Headers
target_include_directories(Nexus
        PRIVATE
        ${CMAKE_CURRENT_SOURCE_DIR}/include
        ${OpenXLSX_INCLUDES}
)

# Libraries
target_link_libraries(Nexus
        PRIVATE
        LLVM
        clangAST
        clangFrontend
        clangTooling
        nlohmann_json::nlohmann_json
        CURL::libcurl
        OpenXLSX::OpenXLSX
)