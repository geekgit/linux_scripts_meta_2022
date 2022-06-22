#!/bin/bash
LastCommitLocal="$(git rev-parse HEAD | xargs)"
echo "${LastCommitLocal}"
