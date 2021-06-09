function cdp --description "cd to projects directory; you can pass argument to cd to a sub-directory"
    if test 0 -ne (count $argv)
      cd ~/RH/projects/$argv
    else
      cd ~/RH/projects/
    end
end

