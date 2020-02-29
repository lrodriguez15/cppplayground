#!/bin/bash

set -e

# Returns non-zero if any C++ source files need to be auto-formatted.
# This is intrusive: the user is forced to run this tool in order for tests to pass.
# However, it ensures consistency of code style which aids productivity.
# 

PROJECT_DIR=$(cd "$(dirname "$0")/.." || exit 1; pwd)

cd "${PROJECT_DIR}"
git ls-files "${PROJECT_DIR}"/*.h "${PROJECT_DIR}"/*.cpp|xargs -L 1 "${PROJECT_DIR}/scripts/bits/run-clang-format.sh"

echo success: ran Clang-Format 
