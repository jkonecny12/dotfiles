#!/bin/fish

function git_test_on_fork --description "reset current HEAD to given repository and add test change"
    if test 0 -eq (count $argv)
        echo "Please specify source branch for 'reset --hard' call" >&2
        echo "Help:" >&2
        echo " git_test_on_fork <target_master_branch> [File to change]" >&2
        return 2
    end

    set file_to_change "./README.rst"

    if test 2 -eq (count $argv)
        set file_to_change $argv[2]
    end

    git reset --hard $argv[1]; and echo 'a' >> $file_to_change; and git commit -a -m "WIP - test commit"; and git push -f fork
end
