#!/bin/bash
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
WORK_DIR=$(mktemp -d)
# deletes the temp directory
function cleanup {
  rm -rf "$WORK_DIR"
  echo "Deleted temp working directory $WORK_DIR"
}

# register the cleanup function to be called on the EXIT signal
trap cleanup EXIT

set -ex
git fetch origin
git fetch oss
cp -af ./ "${WORK_DIR}"
cd "${WORK_DIR}"
git branch -d backup || echo "no backup branch"
git push -d oss backup || echo "no remote backup branch to delete"
(git checkout oss/main && git checkout -b backup && git push --force oss backup) || echo "Nothing to backup."
git checkout origin/main
git branch -d prepare-export || echo "ok cool no prepare export branch"
git checkout -b prepare-export
git filter-repo --invert-paths --path private/ --force
# Note expressions doesn't seem to be working so we try two different things
# git filter-repo --replace-text ${SCRIPT_DIR}/expressions.txt
git filter-repo --blob-callback '
# Skip binary files
if not b"\0" in blob.data[0:8192]:
  import re
  orig = blob.data
  rewrite = re.sub("\{\%.*\.\./\.\.\/private.*\%\}", "", blob.data.decode()).encode()
  blob.data = rewrite'
git push oss main --force
