function fzf_git_checkout -d "fzf source to checkout git branch"
    git rev-parse --is-inside-work-tree >/dev/null ^/dev/null

    if not test $status -eq 0
        return
    end

    git branch -a | fzf | tr -d ' ' | read branch

    if test -n "$branch"
        if echo $branch | grep -q -E '^.*remotes/.*$'
            set -l b (echo $branch | sed -e 's/^\([^\/]*\)\/\([^\/]*\)\///g')
            commandline "git checkout -b $b $branch"
            commandline -f execute
        else
            commandline "git checkout $branch"
            commandline -f execute
        end
    end
end
