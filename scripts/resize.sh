#!/bin/bash
height=$(echo "$(tmux display-message -p "#{window_height}") * 0.15" | bc | cut -d'.' -f1)

tmux \
    resize-pane -t 0 -x 30 \; \
    resize-pane -t 2 -y $height \; \
    resize-pane -t 2 -x $((($(tmux display-message -p "#{window_width}") - 30) / 2))
