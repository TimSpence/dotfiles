# dotfiles

One set of dotfiles to rule them all.  In theory at least. Managed with
[yadm](https://yadm.io/) for flexibility.  Made while streaming
[SomaFM Groove Salad](https://somafm.com/groovesalad/) through
[moOde audio player](http://moodeaudio.org/).

## Features
- Plugin-oriented
  - Vim version 8 or newer
  - zsh
- Ergonomics
  - TrueColor support
  - Eye-friendly open source fonts (currently [powerline](https://github.com/powerline/fonts))
  - Eye-friendly color palette (currently [gruvbox](https://github.com/morhetz/gruvbox.git))
  - Better hotkeys for reduced :chart_with_downwards_trend: keystroking
- Multi-Platform support
  - Automated package installation for apt and homebrew :beer:
  - OS X Catalina
  - Ubuntu 20.04
  - Bare metal, LXC, and Docker
- Flexibility
  - minimal bootstrap provides consistent look and feel
  - optional features available for more customized environments
- Optional features
  - Git author configuration
  - Identity (SSH/GPG)
  - More to come

## Supported Operating Systems
Tested and tuned on these operating systems:
- OS X Catalina
- Ubuntu 20.04 Server

## Installation
Yadm will `git stash` your existing dotfiles before overwriting them. You can
always run `yadm stash show -p` to access and restore your dotfiles.

Ubuntu 20.04:
```bash
  apt install yadm &&
  yadm clone https://github.com/TimSpence/dotfiles.git
```
OS X Catalina:
```bash
brew install yadm &&
  yadm clone https://github.com/TimSpence/dotfiles.git
```
After installation, bootstrap with this command to enable the basic features:
```bash
.config/yadm/bootstrap --minimal
```
Alternatively, bootstrap with this command to enable everything:
```bash
.config/yadm/bootstrap --all
```
## Testing
I like using containers--Docker or LXC--for testing so I don't spend all my time fixing bare metal.

Dockerfile inspired by [zinit-configs](https://github.com/zdharma/zinit-configs/blob/master/Dockerfile).

This is in progress, but here are the steps:
```bash
mkdir some-temp-dir
# copy Dockerfile and dotfiles to a temp dir

docker build --build-arg TERM="${TERM}" --build-arg user=me --tag dotfile-tester path-to-temp-dir

docker run -ti --rm dotfile-tester env TERM="${TERM}" zsh -i -l
```
