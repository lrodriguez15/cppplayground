#!/bin/bash

# wrapper around llvm-cov that allows it to be used with lcov
# source: http://logan.tw/posts/2015/04/28/check-code-coverage-with-clang-and-lcov/
exec llvm-cov gcov "$@"
