#!/bin/bash

set -e

# Runs all test.
# A good command to run to feel reasonably confident about any chances you
# made.

SCRIPTS_DIR=$(cd "$(dirname "$0")"; pwd)

"${SCRIPTS_DIR}/test.sh" "$@"
"${SCRIPTS_DIR}/test-coverage.sh"
"${SCRIPTS_DIR}/test-clang-format.sh"
"${SCRIPTS_DIR}/test-clang-tidy.sh"

echo success
