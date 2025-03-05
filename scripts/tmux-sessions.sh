#!/usr/bin/zsh

search_result=$(find $@ -path "./proc/*" -prune -o -path "/proc/*" -prune -o -type d | fzf)

if [[ -z $search_result ]]; then
    return
fi

session_name=$(basename $search_result)
tmux has-session -t $session_name 2>/dev/null

session_exists=$?

# currently in tmux session and selected session exists
# switch client
if [[ ! -z $TMUX && $session_exists == 0 ]]; then
    tmux switch-client -t $session_name
# currently in tmux session and selected session doesn't exist
# create new session without attaching terminal to it and switch client
elif [[ ! -z $TMUX && $session_exists == 1 ]]; then
    tmux new-session -d -c $search_result -s $session_name
    tmux switch-client -t $session_name
# not in tmux session and selected session exists
# attach to selected session
elif [[ -z $TMUX && $session_exists == 0 ]]; then
    tmux a -t $session_name
# not in tmux session and selected session doesn't exist
# create new session
elif [[ -z $TMUX && $session_exists == 1 ]]; then
    tmux new-session -c $search_result -s $session_name
fi
