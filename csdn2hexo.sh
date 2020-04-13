#!/usr/bin/env bash
#########################################################################
# File Name: csdn2hexo.sh
# Author: minyu
# mail: minyu7374@gmail.com
# Created Time: Sun 12 Apr 2020 06:50:04 PM CST
#########################################################################
# set -x

url_base="https://blog.csdn.net"
user_id="u010129448"

url_home=${url_base}/${user_id}

page_size=40
article_total=133
page_count=$(((article_total+page_size-1)/page_size))

url_list_base=${url_home}/article/list
page_query='t=1'

url_article_base=${url_home}/article/details

blog_dir="$(dirname "$0")/source/_drafts"
mkdir -p "${blog_dir}"

deal_article() {
    content="$(curl -s "${url_article_base}/$1")"

    # <h1 class="title-article">gh60(OK60RGB)刷固件折腾日志（MacOs版）</h1>
    # title="$(grep -Po '(?<=<h1 class="title-article">).*(?=</h1>)' <<<"$content")"
    title="$(grep -o '<h1 class="title-article">.*</h1>' <<<"$content" | sed -r 's/<\/h1>//;s/<h1.*>//')"

    # <div class="up-time">发布于2017-11-18 14:24:11</div> => date: 2017-11-18T14:24:11+08:00
    date="$(grep -Po '(?<=<div class="up-time">发布于)[0-9-]{10} [0-9:]{8}(?=</div>)' <<<"$content" | tr ' ' 'T')+08:00"

    file="${blog_dir}/$(echo "$title" | sed -r 's/\s+/-/g;s/\//_/').md"

    echo "article $1 with title '$title' write to file '$file'"

    echo '---
title: "'"$title"'"
date: "'"$date"'"
categories:
tags:
---
' > "$file"

    article="$(grep -zoE '<article class=".*">.*</article>' <<<"$content" | tr '\0' '\n')"
    start_line="$(grep -n '<div class="htmledit_views" id="content_views">.*' <<<"$article" | cut -d: -f1)"
    end_line="$(grep -n '<div class="more-toolbox">.*' <<<"$article" | cut -d: -f1)"
    article="$(sed -n "$((start_line+1)),$((end_line-2))p" <<<"$article")"


    echo "${article}" | tr '\n' '\0' | \
        # <p>原题链接  <a href="http://uva.onlinejudge.org/index.php?option=com_onlinejudge&amp;Itemid=8&amp;category=21&amp;page=show_problem&amp;problem=1885" rel="nofollow"> http://uva.onlinejudge.org/index.php?option=com_onlinejudge&amp;Itemid=8&amp;category=21&amp;page=show_problem&amp;problem=1885</a><br /></p>
        sed -r 's/<a href="([^"]*)"[^>]*>\s*([^<]*)<\/a>/[\2](\1)/g' | \
        # <p><img src="https://img-blog.csdn.net/20171118112233758?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMDEyOTQ0OA==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast" alt="my gh60" title=""></p>
        sed -r 's/<img src="([^"]*)"\s*alt="([^"]*)"[^>]*>/![\2](\1)/g' | \
        sed -r 's/<h1\b[^>]*>/# /g;s/<h2\b[^>]*>/## /g;s/<h3\b[^>]*>/### /g;s/<h4\b[^>]*>/#### /g;s/<h5\b[^>]*>/##### /g;s/<h6\b[^>]*>/###### /g;s/<\/h[0-6]>//g' | \
        sed -r 's/<pre><code class="language-([^"]*)">/```\1\n/g' | \
        sed -r 's/<pre><code\b[^>]*>/```\n/g' | \
        sed -r 's/<\/code><\/pre>/\n```/g' | \
        sed -r 's/<\/?pre\b[^>]*>//g' | \
        sed -r 's/<br \/>/\n/g' | \
        sed -r 's/<\/?span\b[^>]*>//g;s/<\/?p\b[^>]*>//g;s/<\/?div\b[^>]*>//g' | \
        sed -r 's/\&amp\;/\&/g;s/\&lt\;/</g;s/\&gt\;/>/g' | \
        tr '\0' '\n' >> "$file"
}

for page in $(seq ${page_count}); do
    url_list_page="${url_list_base}/${page}?${page_query}"
    while read -r article_id; do
        deal_article "${article_id}"
    # done <<<"$(curl -s "${url_list_page}" | grep -Eo "<a href=\"${url_article_base}/[0-9]*\" target=\"_blank\">" | cut -d'"' -f2 | awk -F/ '{print $NF}' | sort | uniq)"
    done <<<"$(curl -s "${url_list_page}" | grep -Po "(?<=<a href=\"${url_article_base}/)[0-9]*(?=\" target=\"_blank\">)" | sort | uniq)"
done
