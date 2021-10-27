#!/bin/bash
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
set -ex
git fetch origin
git fetch oss
cp -af ./ ../export-magic
cd ../export-magic
git checkout origin/main
git branch -d prepare-export
git checkout -b prepare-export
git filter-repo --invert-paths --path private/ --force
# Note expressions doesn't seem to be working so we try two different things
# git filter-repo --replace-text ${SCRIPT_DIR}/expressions.txt
git filter-repo --blob-callback '
import re
orig = blob.data
rewrite = re.sub("\{\%.*\.\./\.\.\/private.*\%\}", "", blob.data.decode()).encode()
print(orig)
print(rewrite)
blob.data = rewrite'
