function ssh_no_check --description "SSH to machine without host key cheking; this is especially useful for cattle machines"
    ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null $argv
end
