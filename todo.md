# TODOs
- Configure mako.
- Configure waybar.
- Configure vimtex and make pdf viewer OS agnostic.
- Configure tmux.
- Consider setting up gammastep for night light.
- Add the following to package list for pacman:
  openconnect
  networkmanager-openconnect
  texlive-latex
  texlive-binextra
  texlive-latexrecommended
  texlive-latexextra
  texlive-fontsrecommended
  texlive-bibtexextra
  texlive-mathscience
  biber
  texlab
  tree-sitter-cli
  zathura
  zathura-djvu
  zathura-pdf-mupdf
  noto-fonts-emoji
  python-systemd  # for maestral
  flameshot
  xdg-desktop-portal
  xdg-desktop-portal-wlr
  seahorse  # for keyring management
  yazi
  sshfs
  nodejs
  lynx
  lua-language-server
- Add the following to package list for yay:
  sioyek zoom maestral maestral-qt jabref
- Configure whitespace handling in Neovim.
- Note: For printer Ricoh IM 7000, set `Finisher: SR4140'
- Fix sway workspace configuration startup.

# Arch
## CPU microcode
Figure out if microcode updates are getting loaded correctly
[here](https://wiki.archlinux.org/title/Microcode).

## Swap and zram
See [here](https://wiki.archlinux.org/title/Zram#Usage_as_swap)
and [here](https://wiki.archlinux.org/title/Swap#Swap_file).

## Power management
```sh
tlp thermald
```
## Wifi
```sh
network-manager
nmtui
network-manager-applet
```
## Automatic timezone setting
## Audio
## Bluetooth
## Touchpad support
## Graphics and hardware acceleration
## Basic packages
```sh
systemd
mesa
libva-mesa-driver  # Hardware accelaration
vim
git
coreutils
devtools
wget
curl
tree

kitty
foot

pipewire
alsa-firmware
pavucontrol

<cups>
<dbus>

brightnessctl
foot
wl-clipboard
waybar
rofi
pcmanfm
adwaita-icon-theme
xdg-utils

<wallpapaer-manager>

htop
fontconfig
julia-mono-ttf
nerd-fonts-symbols-only
nerd-fonts.jetbrains-mono
openssh
openssl

google-chrome

gcc
gnumake
cmake
automake
autoconf
libpng
zlib
libgccjit

ripgrep
fd
fzf
bat
neovim
tree-sitter
tmux
lazygit
delta

aerc
notmuch

aspell  # and dictionaries

texlive  # appropriate texlive packages
texlab

typst
tinymist
pandoc

zathura.override zathura-pdf-mupdf
sioyek

brave
lynx

zoom-us

papis

R
Rstudio
```
## Window management
## AUR

```sh
yay
```

## Dropbox

# Neovim

## Plugins to consider
```lua
{"stevearc/dressing.nvim"},
{"lewis6991/gitsigns.nvim"},
{"DNLHC/glance.nvim"},
{"rebelot/kanagawa.nvim"},
{"stevearc/oil.nvim"},
{"nvim-lua/plenary.nvim"},
{"nvim-telescope/telescope.nvim"},
{"pmizio/typescript-tools.nvim"},
{"tpope/vim-fugitive"},
{"tpope/vim-sleuth"},
{"tpope/vim-surround"},
{"tpope/vim-unimpaired"},
{"ggandor/leap.nvim"}
{"OXY2DEV/markview.nvim"}
```

## Folding

```lua
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
```
