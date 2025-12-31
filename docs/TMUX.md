# Tmux

## Overview

This configuration focuses on fast navigation, consistent keybindings, and a clean status line. It enables 256-color support, removes ESC delay, and keeps status updates frequent for responsive feedback.

## Status Bar

- Position: top
- Left: session, window, and pane details
- Right: network, battery, and time
- Refresh interval: 1 second

## Navigation

- Pane movement: `h`, `j`, `k`, `l`
- Pane resize: `H`, `J`, `K`, `L`

## Windows and Panes

- New window in current directory
- Split vertically: `|`
- Split horizontally: `-`
- Base index: `1`

## Mouse

- Mouse mode enabled for pane and window selection

## Copy Mode

- Use vim-style keys in copy mode
- Start selection: `v`
- Select line: `V`
- Block selection: `C-v`
- Yank selection: `y`
- Yank line: `Y`
- Paste: `C-p`
