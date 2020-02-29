#!/bin/bash

set -e


if diff -u <(cat "$1") <(clang-format -style=file "$1")
then
    echo "PASSED: $1"
    exit 0
fi

echo ""
echo "FAILED: $1 is not correctly formatted."
exit 1
