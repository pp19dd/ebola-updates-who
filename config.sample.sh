#!/bin/bash

# ============================================================================
# config: change these
# ============================================================================
email="username@example.com"
folder="/var/www/programs/ebola"
url="http://apps.who.int/ebola/ebola-situation-reports"

# ============================================================================
# hopefully this exists
# ============================================================================
script="${folder}/daily.sh"

if [ ! -f ${script} ]; then
    echo "ERROR: script {$script} not found?"
    exit;
fi

source "${folder}/daily.sh"
