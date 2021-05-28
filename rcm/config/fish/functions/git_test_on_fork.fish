#!/bin/fish

function git_test_on_fork --description "reset current HEAD to given repository and add test change"
    if test 1 -ne (count $argv)
        echo "Please specify source branch for 'reset --hard' call" >&2
    end

    git reset --hard $argv[1]; and echo 'a' >> ./README.rst; and git commit -a -m "WIP - test commit"; and git push -f fork
end
