#!/bin/bash
URL="https://api.github.com/repos/geekgit/linux_scripts_meta_2022/commits"
LastCommitRemote="$(curl -s "${URL}" | grep -e "\"sha\"" | cut -f 1 -d ':' --complement | awk -F\" '{print $2}' | uniq | head -n1 | xargs)"
echo "${LastCommitRemote}"
