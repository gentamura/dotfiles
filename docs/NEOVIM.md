# Neovim Commands and Keymaps

This document lists the custom commands and keymaps configured in `./.config/nvim/init.lua`.

## Leader Key

Leader is set to `Space`.

## File Explorer

- `Space + pv`: Open netrw file explorer.

## Clipboard

- `Space + cp`: Copy full path.
- `Space + cr`: Copy relative path.

## Git (gitsigns.nvim)

Navigation
- `]c`: Next hunk.
- `[c`: Previous hunk.

Actions
- `Space + hs`: Stage hunk (normal/visual).
- `Space + hr`: Reset hunk (normal/visual).
- `Space + hS`: Stage buffer.
- `Space + hu`: Undo stage hunk.
- `Space + hR`: Reset buffer.
- `Space + hp`: Preview hunk.
- `Space + hb`: Blame current line (full).
- `Space + tb`: Toggle current line blame.
- `Space + hd`: Diff this.
- `Space + hD`: Diff this against `~`.
- `Space + td`: Toggle deleted.

Text object
- `ih`: Select hunk (operator-pending/visual).

## Formatting

- `Space + f`: Format buffer (normal).
- `Space + f`: Format selection (visual).

## Telescope

- `Space + ff`: Find files.
- `Space + fa`: Find all files (including gitignored, e.g., `.env.local`).
- `Space + fg`: Live grep.
- `Space + fb`: Buffers.
- `Space + fh`: Help tags.

## LSP UI (lspsaga.nvim)

- `gh`: Finder.
- `Space + ca`: Code action (normal/visual).
- `gr`: Rename (project scope).
- `gd`: Go to definition.
- `[e`: Previous diagnostic.
- `]e`: Next diagnostic.
- `[E`: Previous error diagnostic.
- `]E`: Next error diagnostic.
- `Space + o`: Outline.
- `K`: Hover doc.
- `Space + ci`: Incoming calls.
- `Space + co`: Outgoing calls.
- `Alt + d`: Toggle terminal (normal/terminal).

## Notes

- Plugins are managed by lazy.nvim and installed on first launch.
- Treesitter parsers are installed via `:TSUpdate` (runs automatically on install).
