#!/bin/bash

set -e

# Invokes CMake-based unit-tests using CTest.

PROJECT_DIR=$(cd "$(dirname "$0")/.."; pwd)
NUM_CPUS=$(nproc)

"${PROJECT_DIR}/scripts/bits/configure-cmake.sh" "$@"
cmake --build . -- -j "${NUM_CPUS}"
ctest --output-on-failure -j "${NUM_CPUS}"
