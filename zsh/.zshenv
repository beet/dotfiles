# Sourced by every zsh, login or not. Anything a non-interactive or GUI-launched
# process needs must be set here: .zprofile and .zshrc do not run for those.

# On macOS, XDG-aware tools default to ~/Library/Application Support unless this
# is set. Setting it keeps their configs in ~/.config so they can be stowed.
export XDG_CONFIG_HOME="$HOME/.config"

# .zshrc sources its plugins from $(brew --prefix), so brew has to be on PATH by
# then — .zprofile is too late: zellij panes and GUI shells are not login shells.
if [[ -z "$HOMEBREW_PREFIX" ]]; then
  for _brew in /opt/homebrew/bin/brew /usr/local/bin/brew /home/linuxbrew/.linuxbrew/bin/brew; do
    [[ -x "$_brew" ]] && eval "$("$_brew" shellenv zsh)" && break
  done
  unset _brew
fi

# Machine-local and untracked: DOTFILES_HOST, and anything holding a secret.
[[ -f ~/.zshenv.local ]] && source ~/.zshenv.local
