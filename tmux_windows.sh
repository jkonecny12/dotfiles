#!/bin/bash

sleep 1

SESSION=tmux

tmux has-session -t $SESSION

if [ $? -eq 1 ]; then

	tmux new-session -d -c ~/RH/projects/ -n "projects" -s $SESSION

	tmux neww -c ~/RH/scripts/vm_scripts/ -n "scripts" -t $SESSION
	tmux neww -c ~/RH/kickstart -n "kickstart" -t $SESSION
	tmux neww -t $SESSION
	#tmux neww -t $SESSION

        sleep 0.5

	tmux select-window -p -t $SESSION
	tmux select-window -p -t $SESSION
	tmux select-window -p -t $SESSION

fi

tmux attach-session -t $SESSION
