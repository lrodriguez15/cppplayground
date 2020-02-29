#!/bin/bash

set -e

# Invokes Clang-Tidy on a code-base to perform code fix-ups.

PROJECT_DIR=$(cd "$(dirname "$0")/.."; pwd)
NUM_CPUS=$(nproc)

# Produce "compile_commands.json".
"${PROJECT_DIR}/scripts/bits/configure-cmake.sh" -DCMAKE_EXPORT_COMPILE_COMMANDS=ON

# Make sure that dependencies are pulled in.
# (Ideally, conan would do this for us.)
cmake --build . -- -j "${NUM_CPUS}"

# Invoke Clang-Tidy in serial to ensure fixes aren't applied multiple times.
run-clang-tidy -fix
