# dotfiles

One set of dotfiles to rule them all.  In theory at least. Managed with
[yadm](https://yadm.io/) for flexibility.

## Requirements
- Vim version 8 or newer

## Goals
- ergonomics
  - easy on eyes
  - minimal keyboarding
- pluggable
- portable across Linux and OS X
- flexible: many features are optional
- groovy bootstrap script (not the language, it is actually groovy)

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
