#!/bin/bash

# count codelines in the directory
find . -type f | grep -v ".git" | xargs wc -l
