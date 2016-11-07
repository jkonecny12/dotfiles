############# HOOKS ########################

# add lines numbers
hook global WinCreate .* %{addhl number_lines}

# add brackets highliting
hook global WinCreate .* %{addhl show_matching}

# use only spaces do not use tabs
hook -group TabExpander global InsertChar \t %{ exec -draft h@}

# Add autowrap to 72 characters in git-commit
hook -group GitWrapper global WinSetOption filetype=git-commit %{
    set buffer autowrap_column 72
    autowrap-enable

    hook window WinSetOption filetype=(?!git-commit).* %{ autowrap-disable }
}

hook -group PythonJediAutostart global WinSetOption filetype=python %{
    jedi-enable-autocomplete
}

hook global WinSetOption filetype=(?!python).* %{
    jedi-disable-autocomplete
}

# Add our special .ks.in files as normal Kickstart
hook global WinCreate .*\.ks\.in %{
    set buffer filetype kickstart
}

# show all trailing whispaces red
hook -group TrailingWhitespaces global WinCreate .* %{
    addhl regex '\h+$' 0:default,red
}

# autowrap the status.txt file
hook -group StatusAutowrap global WinCreate .*status\.txt %{
    set buffer autowrap_column 35
    autowrap-enable

    hook window WinClose .*(?!status\.txt) %{ echo "test close" }
}

#################################

set global tabstop 4

map global user n ':eval %{buffernext}<ret>'
map global user b ':eval %{bufferprev}<ret>'

# yank and paste to/from external clipboard
map global user y '<a-|>xsel -b <ret>:echo -color Information "Yanked to clipboard"<ret>'
map global user p '<a-!>xsel -b -o<ret>:echo -color Information "Pasted from clipboard"<ret>'

map global user h ':doc shortcuts<ret>'

# yank to system clipboard always
hook global NormalKey y|d|c %{ nop %sh{
   echo "$kak_selection" | xsel
}}

# write pdb to this row
map global user d '<esc>oimport pdb; pdb.set_trace()<esc>'

# select all occurrences in this buffer
map global user a '*%s<c-/><ret>'

# my personal functions
def push_kickstart -docstring "Push actual buffer to cobra02" %{
write
%sh{
    /home/jkonecny/RH/scripts/vm_scripts/push_kickstart.sh "$kak_buffile" > /dev/null

    if [ $? -eq 0 ]; then
        echo "echo -color Information KS $kak_bufname pushed successful"
    else
        echo "echo -color Error Push failed"
    fi
}}


###############################
# Testing stuff

hook global WinSetOption filetype=python %{

    def pylint_test -docstring "Test active buffer with pylint - python static checker utility" %{
       %sh{
            pylint=$(which pylint)
            if [ -z $pylint ]; then
                echo "echo -color red 'You don't have pylint installed!'"
                exit 1
            fi
            #if [ -f $kak_buffile ]; then
            #    TEMP=$(mktemp pylint-test.XXXXXXX)
            #fi
            out_fifo=$(mktemp -d -t kak-pylint.XXXXXXXX)/fifo
            mkfifo ${out_fifo}
            ( $pylint --reports=n $kak_buffile > $out_fifo 2>&1 ) > /dev/null 2>&1 < /dev/null &

            printf %s "eval -client '$kak_client' %{
                      edit! -fifo ${out_fifo} *pylint*
                      hook -group pylint_fifo buffer BufCloseFifo .* %{
                          nop %sh{ rm -r $(dirname ${out_fifo}) }
                          rmhooks buffer pylint_fifo
                      }
                  }"
        }
    }
}
