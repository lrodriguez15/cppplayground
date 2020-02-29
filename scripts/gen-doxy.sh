#!/usr/bin/env bash

DOXY_OUTPUT_FILE="doxy.out"
RED='\033[0;31m'
GREEN='\033[0;32m'
WHITE='\033[0m'

touch $DOXY_OUTPUT_FILE
# Run doxygen and any warnings will be sent to $DOXY_OUTPUT_FILE
doxygen

if grep -iq 'warning\|error' "$DOXY_OUTPUT_FILE";
then
        echo -e "\n\n\n"
        echo -e "${RED}FAIL: Doxygen generated with warnings"
        echo -e "\n\n\n"
        echo    "Doxygen Warnings:"
        echo -e "${WHITE}"
        cat $DOXY_OUTPUT_FILE
        exit 1
else
        echo -e "\n\n\n"
        echo -e "${GREEN}PASS: Doxygen generated without any warnings"
        echo -e "${WHITE}"
        echo -e "\n\n\n"
fi