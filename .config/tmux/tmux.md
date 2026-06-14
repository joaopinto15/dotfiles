# Tmux default commands Manual

ctrl+b -> prefix key

## Panes commands

prefix + % -> vertical pane
prefix + " -> horizontal pane
prefix + x -> kill pane
prefix + } -> swap pane

## Windows commands

prefix + c -> new window
prefix + , -> rename window

prefix + [number] -> switch window

prefix + & -> kill window

## Sessions commands

prefix + d -> detach session (exit session without killing it)
prefix + $ -> rename session

## Tmux cli commands

```bash
tmux ls # list sessions
tmux attach -t 0 # attach session
tmux rename-session -t 0 git # rename session to git
tmux new -s docker # create session named docker
tmux kill-session -t docker # kill docker session
```
