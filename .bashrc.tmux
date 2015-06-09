# If not running interactively, do not do anything
if command -v tmux &>/dev/null; then
    [[ $- != *i* ]] && return
    [[ -z "$TMUX" ]] && exec tmux
fi
