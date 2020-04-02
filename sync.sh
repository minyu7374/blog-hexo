#!/usr/bin/env bash
#########################################################################
# File Name: ./sync.sh
# Author: minyu
# mail: minyu7374@gmail.com
# Created Time: Wed 01 Apr 2020 09:00:10 PM CST
#########################################################################
#crontab
# 10 2 * * * /blog-hexo/sync.sh

pro_dir="$(dirname "$0")"
pre_commit_file="${pro_dir}/.sync_commit.log"

commot="$(git show --stat | head -n 1 | awk '{print $NF}')"
if [ "$commot" != "$(cat "${pre_commit_file}" 2>&-)"  ]; then
    hexo generate
    rsync -avz --delete public/ root@wminyu.top:/var/www/blog
    echo "$commot" > "${pre_commit_file}"
fi
