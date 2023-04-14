#!/usr/bin/bash

echo $OLJ_SCRIPT | base64 --decode > olj-start.py && python3 olj-start.py
