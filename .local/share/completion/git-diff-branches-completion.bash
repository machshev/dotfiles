#/usr/bin/env bash
_git_diff_branches_completions()
{
    BRANCHES=$(git branch --list -a \
                 | sed 's/^[ \*]*//' \
                 | sed 's/remotes\///' \
                 | cut -d ' ' -f 1)
    
    COMPREPLY=($(compgen -W "$BRANCHES" -- "${COMP_WORDS[1]}"))
}

complete -F _git_diff_branches_completions git-diff-branches
