#crontab
# 10 2 * * * /blog-hexo/sync.sh

pro_dir="$(dirname "$0")"
pre_commit_file="${pro_dir}/.sync_commit.log"

commot="$(git show --stat | head -n 1 | awk '{print $NF}')"
if [ "$commot" != "$(cat "${pre_commit_file}" 2>&-)"  ]; then
    hexo generate
    rsync -e 'ssh -i ~/.ssh/vps/id_rsa' -avz --delete public/ root@wminyu.top:/var/www/blog/
    rsync -e 'ssh -i ~/.ssh/vps/id_rsa' -avz --delete public/ opc@x86.wminyu.top:/var/www/blog/
    rsync -e 'ssh -i ~/.ssh/vps/id_rsa' -avz --delete public/ opc@arm.wminyu.top:/var/www/blog/
    echo "$commot" > "${pre_commit_file}"
fi
