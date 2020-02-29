#!/bin/bash

set -e

PROJECT_DIR=$(cd "$(dirname "$0")/../.."; pwd)

cmake \
    "${PROJECT_DIR}" \
    -DCMAKE_CXX_COMPILER_LAUNCHER=ccache \
    -DCMAKE_CXX_FLAGS="-Werror -Wall -Wextra -Wpedantic" \
    "$@"
