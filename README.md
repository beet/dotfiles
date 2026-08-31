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

Each machine keeps an untracked `~/.zshenv` file which defines its host name, and corresponds to a custom config that may or may not be under version control.

Assuming the repo is checked out in `~/dotfiles/`:

### Home machine

1. Add `export DOTFILES_HOST="macbook_pro_home"` to `~/.zshenv`
2. Create `~dotfiles/zsh/.zshrc.macbook_pro_home` for any machine-specific config
3. Run `stow zsh` from `~/dotfiles`

### Work machine

1. Add `export DOTFILES_HOST="macbook_pro_work"` to `~/.zshenv`
2. Create `~dotfiles/zsh/.zshrc.macbook_pro_work` for any machine-specific config
3. Run `stow zsh` from `~/dotfiles`

### Oh My Zsh

When installing [Oh My Zsh](https://ohmyz.sh/), it will create `~/.zshrc`. If that was done before stowing the ZSH config, it may need to be deleted/renamed before running `stow zsh` from the dotfiles repo.

