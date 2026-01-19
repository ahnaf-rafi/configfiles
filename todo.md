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
