#!/bin/sh
set -e

cd s3-directory-listing
python3 generate.py
mv out/index.json out/dist/index.json
mv out/index.txt out/dist/index.txt
