# Tmux

## Overview

This configuration focuses on fast navigation, consistent keybindings, and a clean status line. It enables 256-color support, removes ESC delay, and keeps status updates frequent for responsive feedback.

## Plugins (TPM and Resurrect)

This repo configures TPM and tmux-resurrect in `.tmux.conf`, but TPM must be installed once on the machine to activate plugin bindings.

Install TPM:

```sh
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

Reload tmux:

```tmux
Ctrl+b :source-file ~/.tmux.conf
```

Install plugins:

```tmux
Ctrl+b I
```

Save and restore sessions:

- Save: `Ctrl+b Ctrl+s`
- Restore: `Ctrl+b Ctrl+r`

Resurrect snapshots are stored under `~/.local/share/tmux/resurrect/` by default. You can override the location with `set -g @resurrect-dir "~/.tmux/resurrect"` in `.tmux.conf` if you prefer the legacy path.

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
