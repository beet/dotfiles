# macOS /etc/zprofile runs path_helper, which hoists the system paths back above
# Homebrew's. .zshenv is sourced before that, so re-assert the order here.
if [[ -n "$HOMEBREW_PREFIX" ]]; then
  path=("$HOMEBREW_PREFIX/bin" "$HOMEBREW_PREFIX/sbin" ${path:#$HOMEBREW_PREFIX/(bin|sbin)})
fi
