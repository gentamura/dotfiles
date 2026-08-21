# LaunchAgents

## `com.gentamura.codex-home.plist`

This is a temporary workaround for the ChatGPT macOS computer-use worker leak
when `~/.codex` is a symlink. It makes the user launchd session export
`CODEX_HOME` as the resolved dotfiles path before GUI applications are opened.

Enable it for the current user session with:

```sh
DOTFILES_DIR="$(git rev-parse --show-toplevel)"
mkdir -p "$HOME/Library/LaunchAgents"
ln -sfn "$DOTFILES_DIR/.config/launchagents/com.gentamura.codex-home.plist" \
  "$HOME/Library/LaunchAgents/com.gentamura.codex-home.plist"
launchctl bootstrap "gui/$(id -u)" \
  "$HOME/Library/LaunchAgents/com.gentamura.codex-home.plist"
```

Verify the GUI launchd domain (the domain used by Dock/Finder-launched apps):

```sh
launchctl print "gui/$(id -u)" | grep CODEX_HOME
```

`launchctl getenv CODEX_HOME` from a Terminal shell may inspect the separate
`user/<uid>` domain and can therefore be empty even when GUI applications
receive `CODEX_HOME` correctly. The definitive check is the ChatGPT process:

```sh
PID=$(pgrep -x ChatGPT | head -1)
ps eww -p "$PID" | tr ' ' '\n' | grep '^CODEX_HOME='
```

Remove the workaround after the upstream ChatGPT fix is confirmed:

```sh
launchctl bootout "gui/$(id -u)/com.gentamura.codex-home" 2>/dev/null || true
unlink "$HOME/Library/LaunchAgents/com.gentamura.codex-home.plist"
```

Log out and back in afterward so the current GUI launchd domain drops the
temporary environment variable.
