# Dotfiles

See [How To Easily Manage Your Dotfiles With GNU Stow](https://www.josean.com/posts/how-to-manage-dotfiles-with-gnu-stow).

Main directories:

* `bin` - my shell scripts
* `btop` - my [btop](https://github.com/aristocratos/btop) config
* `git` - my [Git](https://git-scm.com/) config
* `hunk` - my [Hunk](https://github.com/modem-dev/hunk) config
* `lazygit` - my [lazygit](https://github.com/jesseduffield/lazygit) config
* `nvim` - my [LazyVim](https://www.lazyvim.org) config
* `wezterm` - my [WezTerm](https://wezterm.org/) config 
* `yazi` - my [Yazi](https://yazi-rs.github.io/) config
* `zellij` - my [Zellij](https://zellij.dev/) config
* `zsh` my [Oh My Zsh](https://ohmyz.sh/) config. _(see below for machine-specific configs)_

Pretty much everything else is old guff prior to discovering [GNU Stow](https://www.gnu.org/software/stow/).

## Machine-specific ZSH config

The base ZSH config in `zsh/.zshrc` defines the core setup, plugins, etc. and then pulls in machine-specific config at the end, allowing multiple machines to use the same basic settings, while also keeping their own customisations segregated but still under version control if needed.

`zsh/.zshenv` is stowed too. Zsh sources it for *every* shell, login or not, so it is where Homebrew and `XDG_CONFIG_HOME` are set up: `.zprofile` runs for login shells only, which leaves zellij panes, `nvim :terminal` and anything launched from the GUI without them.

`zsh/.zprofile` then does one job on top of that: macOS `/etc/zprofile` runs `path_helper`, which hoists the system paths back above Homebrew's, so the order has to be re-asserted afterwards.

Each machine keeps an untracked `~/.zshenv.local` file, sourced from the end of `zsh/.zshenv`, which defines its host name and holds anything with a secret in it. It corresponds to a custom config that may or may not be under version control.

Assuming the repo is checked out in `~/dotfiles/`:

### Home machine

1. Add `export DOTFILES_HOST="macbook_pro_home"` to `~/.zshenv.local`
2. Create `~dotfiles/zsh/.zshrc.macbook_pro_home` for any machine-specific config
3. Run `stow zsh` from `~/dotfiles`

### Work machine

1. Add `export DOTFILES_HOST="macbook_pro_work"` to `~/.zshenv.local`
2. Create `~dotfiles/zsh/.zshrc.macbook_pro_work` for any machine-specific config
3. Run `stow zsh` from `~/dotfiles`

### Oh My Zsh

When installing [Oh My Zsh](https://ohmyz.sh/), it will create `~/.zshrc`. If that was done before stowing the ZSH config, it may need to be deleted/renamed before running `stow zsh` from the dotfiles repo. The same goes for any pre-existing `~/.zshenv` — move its contents to `~/.zshenv.local` first.

