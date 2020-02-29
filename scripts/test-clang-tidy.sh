#!/bin/bash

set -e

# Invokes Clang-Tidy on a code-base to test for rule violations.

PROJECT_DIR=$(cd "$(dirname "$0")/.."; pwd)
NUM_CPUS=$(nproc)

# Produce "compile_commands.json".
"${PROJECT_DIR}/scripts/bits/configure-cmake.sh" -DCMAKE_EXPORT_COMPILE_COMMANDS=ON

# Make sure that dependencies are pulled in.
# (Ideally, conan would do this for us.)
cmake --build . -- -j "${NUM_CPUS}"

# Invoke Clang-Tidy in parallel.
"${PROJECT_DIR}/scripts/bits/run-clang-tidy.py" "-j${NUM_CPUS}"

echo success: ran Clang-Tidy 
