function scp_no_check --description "SCP to machine without host key cheking; this is especially useful for cattle machines"
    scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null $argv
end
