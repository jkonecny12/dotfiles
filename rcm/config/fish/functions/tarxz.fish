function tarxz --description "make xz compression multi-thread"
    tar -I "xz -T0" $argv
end
