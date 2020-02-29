#!/bin/bash

set -e

# Invokes CMake-based unit-tests using CTest.

PROJECT_DIR=$(cd "$(dirname "$0")/.."; pwd)
NUM_CPUS=$(nproc)

"${PROJECT_DIR}/scripts/bits/configure-cmake.sh"
cmake \
    "${PROJECT_DIR}" \
    -DCMAKE_BUILD_TYPE=Debug \
    -DCMAKE_CXX_FLAGS_DEBUG="--coverage -fno-exceptions"

cmake --build . -- -j "${NUM_CPUS}"
ctest --output-on-failure -j "${NUM_CPUS}"

"${PROJECT_DIR}/scripts/bits/configure-cmake.sh"
cmake \
    "${PROJECT_DIR}" \
    -DCMAKE_BUILD_TYPE=Debug \
    -DCMAKE_CXX_FLAGS_DEBUG="--coverage -fexceptions"
cmake --build . -- -j "${NUM_CPUS}"
ctest --output-on-failure -j "${NUM_CPUS}"

log_file="run-lcov.log"
"${PROJECT_DIR}/scripts/test/bits/run-lcov.sh" | tee "$log_file"

heading="Overall coverage rate:"
coverages=()
mapfile -t coverages < <(grep -A 3 "$heading" < "$log_file" | grep "%" | awk '{print $2}' )

min_coverage_int=$(( 101 ))
min_coverage="101.0%"
for coverage in "${coverages[@]}"; do
  coverage_int=$(echo "$coverage" | tr '.' ' ' | awk '{print $1}' )
  if (( coverage_int <= min_coverage_int )); then
    min_coverage_int=$coverage_int
    min_coverage=$coverage
  fi
done

echo "Minimal coverage is $min_coverage"


echo success: ran lcov
