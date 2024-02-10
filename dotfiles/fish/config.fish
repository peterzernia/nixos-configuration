if status is-interactive
  tmux new-session -A -s default || tmux new-session -s default
end
