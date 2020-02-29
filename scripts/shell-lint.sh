#!/bin/bash

set -eu
set -o pipefail

print_usage() {
  echo -e "\nUsage:
  ./shell_lint.sh [--exclude <path-to-be-excluded>]
  
  --exclude Excluded paths have to be relative to the working directory
            If multiple paths need to be excluded, then pass multiple --exclude params
  "
}

if (( $# > 0 )) && [[ "$1" != "--exclude" ]]; then
  print_usage
  exit 1
fi

# Collect all shell files
SCRIPTS=$(find . -type f -name "*.sh" | sort)

# exclude passed folders
args=("$@")
for (( index=0; index<$#; index+=1 ))
do
  if [[ "${args[$index]}" == "--exclude" ]]; then
    SCRIPTS=$(echo "$SCRIPTS" | grep --invert-match "^\(./\)\?${args[(($index+1))]}")
    echo "excluded ${args[(($index+1))]}"
  fi
done

PASSED=()
FAILED=()
LONGEST_SCRIPT_LENGTH=0
GREEN='\033[0;32m'
RED='\033[0;31m'
NONE='\033[0m'
SEPARATOR="============================================================="

echo "$SEPARATOR"
for script in $SCRIPTS
do
  if (( LONGEST_SCRIPT_LENGTH < ${#script} )); then
    LONGEST_SCRIPT_LENGTH=${#script}
  fi

  # Exclude SC1090: Can't follow non-constant source, because apollo uses this as feature
  if shellcheck --color=always --external-sources "$script" --exclude=SC1090; then
    PASSED+=("$script")
  else
    echo "$SEPARATOR"
    FAILED+=("$script")
  fi
done

echo ""

if (( ${#PASSED[@]} > 0 )); then
  for script in ${PASSED[*]}
  do
    printf "%-${LONGEST_SCRIPT_LENGTH}s ${GREEN}PASSED${NONE}\n" "$script"
  done
fi

if (( ${#FAILED[@]} > 0 )); then
  for script in ${FAILED[*]}
  do
    printf "%-${LONGEST_SCRIPT_LENGTH}s ${RED}FAILED${NONE}\n" "$script"
  done
fi

printf "%s ${GREEN}passed${NONE}, %s ${RED}failed${NONE}\n" "${#PASSED[@]}" "${#FAILED[@]}"

if (( ${#FAILED[@]} > 0 )); then
  exit 1
fi
