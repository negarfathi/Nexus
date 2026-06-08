cmake_minimum_required(VERSION 4.0)
project(Nexus)

# Set the C++ standard to C++26
set(CMAKE_CXX_STANDARD 26)

# Find LLVM package
find_package(LLVM REQUIRED CONFIG)
message(STATUS "Found LLVM ${LLVM_PACKAGE_VERSION}")
message(STATUS "Using LLVMConfig.cmake in: ${LLVM_DIR}")

# Include LLVM headers
include_directories(${LLVM_INCLUDE_DIRS})
add_definitions(${LLVM_DEFINITIONS})

# Find Clang package
find_package(Clang REQUIRED CONFIG)
message(STATUS "Using ClangConfig.cmake in: ${CLANG_DIR}")

# Include Clang headers
include_directories(${CLANG_INCLUDE_DIRS})

list(APPEND CMAKE_PREFIX_PATH "/opt/homebrew" "/opt/homebrew/opt/nlohmann-json")
find_package(nlohmann_json CONFIG REQUIRED)

add_executable(Nexus
        src/main.cpp

        src/inline_attribute_injector.cpp
        include/inline_attribute_injector.h

        include/loop_summary_extractor.h
        src/loop_summary_extractor.cpp

        include/candidate_synthesizer.h
        src/candidate_synthesizer.cpp

        src/validator_generator.cpp
        include/validator_generator.h)

target_include_directories(Nexus PRIVATE include)

# Link against specific LLVM and Clang libraries
target_link_libraries(Nexus
        PRIVATE
        LLVM
        clangAST
        clangFrontend
        clangTooling
        nlohmann_json::nlohmann_json)