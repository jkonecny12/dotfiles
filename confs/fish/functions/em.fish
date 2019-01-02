function em  --description "Run emacs server if not running and attach to that"
    emacsclient -a '' -nw $argv
end
