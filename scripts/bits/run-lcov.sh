#!/bin/bash

set -e

PROJECT_DIR=$(cd "$(dirname "$0")/../.."; pwd)
LCOV_TRACEFILE=report.info
LCOV_OUTPUT_DIRECTORY="coverage-report"
LCOV_CONFIG_FILE="${PROJECT_DIR}/scripts/bits/lcovrc"

# Collate coverage data.
lcov \
    --base-directory "${PROJECT_DIR}" \
    --capture \
    --config-file "${LCOV_CONFIG_FILE}" \
    --gcov-tool gcov \
    --directory . \
    --output-file "${LCOV_TRACEFILE}"

# Exclude coverage data from dependencies.
lcov \
    --remove "${LCOV_TRACEFILE}" "*/gsl/*" "*/gtest/*" "*test/*" "*/lib/*"\
    --output-file "${LCOV_TRACEFILE}" \
    --config-file "${LCOV_CONFIG_FILE}"

# Generate HTML report
mkdir "${LCOV_OUTPUT_DIRECTORY}" -p
genhtml \
    --branch-coverage \
    --config-file "${LCOV_CONFIG_FILE}" \
    --output-directory "${LCOV_OUTPUT_DIRECTORY}" \
    "${LCOV_TRACEFILE}" | tee coverage-log

# Check output for coverage
SUCCESS=1

set +e


if ! grep "functions..: 100.0%" coverage-log ; then
  echo error: function coverage is too low
  SUCCESS=0
fi


if ! grep "lines......: 100.0%" coverage-log ; then
  echo error: line coverage is too low
  SUCCESS=0
fi


if ! grep "branches...: 100.0%" coverage-log ; then
  echo warning: branch coverage is too low
  # TODO: Enforce 100% branch coverage
  #SUCCESS=0
fi

set -e

echo report generated in ./coverage-report/

if [[ ${SUCCESS} -eq 0 ]] ; then
  echo failure
  exit 1
else
  echo success
  exit 0
fi
