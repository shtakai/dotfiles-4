# macOS/OS X

## Full generic setup, in order

### Install App Store apps

- `Amphetamine` - better than caffeine
- `Display Menu` - for setting native resolutions on multiple monitors
- `xcode`
    - Then run `xcode-select --install` to prompt for CLI tools.

### Setup ssh keys

1. keygen
1. add to GitHub
    - NEED alternate means of logging in via web
    - then do a test login and store the passphrase in Keychain
1. add to GitLab

### Install homebrew

### Install git from brew

Don't need completions, we'll use zsh completions instead

```bash
brew install git --without-completions
brew install git-extras hub
```

### Install dotfiles

1. `git clone` for `~/.dotfiles/`
1. `~/.dotfiles/bootstrap/symlink.sh`
1. `~/.dotfiles/mac/settings` -- set apple defaults and fix some issues like
   zsh startup
1. `git clone` for `~/.secrets` and link as needed

### Install macvim

We want this to override the outdated system vim too. Just use
`~/.dotfiles/bootstrap/mac/macvim.sh`.

### Install zsh and set as default

```bash
brew install zsh
chsh -s /usr/local/bin/zsh
```

### Install Powerline patched fonts from source

1. `git clone https://github.com/powerline/fonts ~/src/fonts`
1. Run `install.sh`

### Install iterm2 from brew

1. Install `iterm2-beta`, which is technically iterm3:
    ```bash
    brew tap caskroom/versions
    brew cask install iterm2-beta
    ```
1. Set up fonts (Fura Mono for Powerline, see _Powerline patched fonts_ above)
1. Set up base16 from <https://github.com/chriskempson/base16-iterm2> or
   start app -> Preferences -> Load preferences from custom folder, point to
   existing plist exports.

### Install dev stuff

- Install `chruby`, `ruby-install`
    1. `ruby-install ruby` to install latest
    1. `chruby` to latest version just installed
    1. Install gems using `~/.dotfiles/ruby/install-default-gems.sh`
- Install [nvm](https://github.com/creationix/nvm) MANUALLY via git clone into
  `$XDG_CONFIG_HOME`, then use it to install a version of `node` (and
  consequently `npm`)
    1. Use nvm managed node
    1. `npm install -g npm@latest`
    1. Install the default packages using `~/.dotfiles/node/install.sh`
- Install `pyenv` and make sure to use the libs provided by `brew openssl`
    1. `brew install openssl`
    1. Follow <https://github.com/yyuu/pyenv/wiki/Common-build-problems#error-the-python-ssl-extension-was-not-compiled-missing-the-openssl-lib>
    1. Install `pyenv-doctor` if needed.
    1. Install `pyenv-virtualenv`
    1. Set up python virtualenvs called `neovim{2,3}` -- nvim is configured to
       use those already. E.g.,
        1. `pyenv install 2.7.12`
        1. `pyenv virtualenv 2.7.12 neovim2`
- `brew install redis` for `redismru.vim` later
- run `bootstrap/mac/install.sh`
- run `bootstrap/mac/completions.sh`
- run `bootstrap/terminfo.sh` (added terminfo for iterm with italics support)
- Install `gpgtools` from brew cask (using GPG suite since it provides
  `gpg-agent` and can store passphrase in keychain with minimal cfg on
  El Capitan)
    - Import keybase public/private keys into gpg
    - Setup local gitconfig to sign commits

### Install neovim

1. Follow <https://github.com/neovim/homebrew-neovim> for HEAD
    ```bash
    brew tap neovim/neovim
    brew update
    brew install --HEAD --with-release neovim
    ```
1. Launch `nvim` and let `vim-plug` install itself, exit
1. Launch `nvim` and `:PlugInstall`, exit

### Install keepassx from source

Some of the requirements to `brew install` first:

- cmake
- libgcrypt
- oath-toolkit

Install keepassx 2.0 with http support from the source of this fork (inspect
diff first):
<https://github.com/eugenesan/keepassx/tree/2.0-http-totp>

It is fine to run the `cmake -DCMAKE_BUILD_TYPE=Release` step until it builds
successfully (it will tell you what deps are missing each time, and the deps
can all be installed via brew).

### Install from cask

- bettertouchtool
    - License acquired
    - Provide window snapping
    - Provide better trackpad swipe configs
- google-chrome
    - Login and sync
    - Provides `authy`
- dropbox
    - Then setup keepassx to load the key database from dropbox
- karabiner
    - Maps simultaneous-dual-shift to capslock and show capslock state.
        - Run `karabiner/install.sh` to symlink `private.xml`
        - In prefs must enable by toggling checkbox
- kaleidoscope
    - Load license file
- transmission
    - Load blocklist `http://john.bitsurge.net/public/biglist.p2p.gz`

Rest of stuff from bootstrap/mac/cask.sh

## Reduce desktop icon size

Click desktop to focus Finder, `cmd-j` use smallest sizes for everything.

## Source order

- zshenv
    - shell/vars
        - shell/xdg
- /etc/zprofile
- zsh/.zprofile
- zshrc
    - shell/before
        - shell/path
        - shell/os
        - shell/functions
        - shell/x11
        - shell/aliases
        - shell/node
            - nvm
            - avn
        - shell/python
        - shell/ruby
            - chruby
    - zplug
        - keybindings.zsh
        - prompt.zsh
        - title.zsh
    - fzf
    - shell/after
        - travis
    - .secret/local/shellrc

