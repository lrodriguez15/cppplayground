#!/bin/bash

set -e

# Fix formatting errors identified by clang-format.

PROJECT_DIR=$(cd "$(dirname "$0")/.."; pwd)

git ls-files "${PROJECT_DIR}"/*.h "${PROJECT_DIR}"/*.cpp|xargs -L 1 clang-format -style=file "$1" -i
