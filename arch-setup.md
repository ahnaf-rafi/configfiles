# Arch Linux installation
I install Arch Linux folloiwng the SSH installation instructions given on the
ArchWiki
[here](https://wiki.archlinux.org/title/Install_Arch_Linux_via_SSH).
This involves the following steps.
1. Follow the ArchWiki [installation
   guide](https://wiki.archlinux.org/title/Installation_guide) up to and
   including the section on connecting to the internet;
2. Setting up the SSH connection as detailed in
   [here](https://wiki.archlinux.org/title/Install_Arch_Linux_via_SSH).
   Here are some of my additional steps: (a) check status of `ssh` daemon with
   `systemctl status sshd`, (b) activate it if it is not active with
   `systemctl start sshd`, and (c) get the IP address with `ip addr show`.
3. I then use `archinstall` to install Arch.
   I use the "Minimal" profile with Bluetooth, Audio with Pipewire and
   NetworkManager all enabled. 
   See also the package list below to be installed.

I use `archinstall` to create and format two partitions:
1. A 1 GiB boot partition formatted to FAT32 (via
   `mkfs.fat -F 32 /dev/efi_system_partition`).
   This is mounted using 
   `mount --mkdir /dev/efi_system_partition /mnt/boot` *after* mounting the
   main Linux Filesystem partition below.
2. A Linux Filesystem partition which takes up all the remaining hard drive
   space (via `mkfs.ext4 /dev/root_partition`).
   This is mounted using `mount /dev/root_partition /mnt`.
One can also do this via `fdisk` and `mkfs`.

Here is a package list I like to have the installer install.
```sh
  adwaita-fonts
  adwaita-icon-theme
  amd-ucode
  base-devel
  bash
  bash-completion
  blueman
  bluetui
  bluez
  bluez-utils
  brightnessctl
  coreutils
  curl
  fastfetch
  fd
  foot
  foot-terminfo
  fzf
  git
  greetd
  greetd-regreet
  grim
  htop
  imagemagick
  kanshi
  kitty
  lazygit
  linux
  linux-firmware
  linux-headers
  linux-lts
  linux-lts-headers
  mako
  man-db
  man-pages 
  mesa
  neovim
  network-manager-applet
  networkmanager
  nm-connection-editor
  openssh
  openssl
  pavucontrol
  pipewire
  pipewire-audio
  pipewire-alsa
  pipewire-docs
  polkit
  ripgrep
  rofi
  slurp
  smartmontools
  stow
  sudo
  sway
  swaybg
  swayidle
  swaylock
  texinfo
  tlp
  tlp-rdw
  tlpui
  tmux
  vim
  vulkan-icd-loader
  vulkan-radeon
  waybar
  wget
  which
  wireless_tools
  wireplumber
  wireplumber-docs
  wl-clipboard
  wpa_supplicant
  xdg-utils
  xorg-xwayland
```

From here on out, I follow the remaining ArchWiki installation guide
instructions up to and until setting the root password.
One note on using `arch-chroot`: I use `arch-chroot -S /mnt` to make sure I can
use `bootctl install` properly to install the `systemd-boot` UEFI boot manager.
Then, I set up my user as follows:
```sh
useradd -m -G wheel ahnafrafi
```
Details and additional flags/options for this can be found on the ArchWiki
[here](https://wiki.archlinux.org/title/Users_and_groups).

Additional software installed with `pacman` before finishing up:
```sh
pacman -Syyu --needed \
  dosfstools mtools os-prober udisks2 cmake pacman-contrib \
  python r gcc-fortran openblas \
  cups cups-pdf pass gnupg kitty foot foot-terminfo \
  git tmux vim neovim fd ripgrep lazygit git-delta bat \
  tar gzip zip unzip \
  acpi hddtemp sysstat lm_sensors \
  ttf-jetbrains-mono-nerd ttf-nerd-fonts-symbols ttf-nerd-fonts-symbols-mono \
  firefox
```

Edit `/etc/tlp.conf`, uncomment the following lines and ensure the following
vlaues are set:
```conf
START_CHARGE_THRESH_BAT0 = 75;
STOP_CHARGE_THRESH_BAT0 = 80;
```

Enable the following `systemd` services:
```sh
systemctl enable sshd
systemctl enable NetworkManager
systemctl enable NetworkManager-dispatcher
systemctl enable tlp.service
systemctl enable systemd-timesyncd
systemctl enable bluetooth.service
systemctl enable cups
```

## Configure and enable `greetd` with ReGreet
Copy over the files in `./extras/greetd/` to `/etc/greetd/`.
Then enable the `greetd` service:
```sh
systemctl enable greetd.service
```

## Older package lists (REORGANIZE)
```sh
pacman -Syyu 
  xarchiver udisks2 networkmanager network-manager-applet wpa_supplicant \
  wireless_tools netctl dialog wget openconnect networkmanager-dispatcher-ntpd \
  networkmanager-openconnect tlp tlp-rdw acpi hddtemp sysstat lm_sensors \
  i3-gaps i3lock rofi i3blocks wmctrl libappindicator-gtk3 alacritty feh \
  ranger thunar neofetch fzf fd ripgrep clang tar xclip xdotool dunst \
  alsa-firmware alsa-utils pulseaudio pulseaudio-alsa pulsemixer bluez \
  bluez-utils pulseaudio-bluetooth blueman gnu-free-fonts noto-fonts \
  ttf-liberation adobe-source-code-pro-fonts ttf-fira-mono ttf-fira-code \
  ttf-jetbrains-mono ttf-fira-sans powerline-fonts ttf-font-awesome
```

```sh
pacman -S r graphviz xdot dotnet-host dotnet-runtime dotnet-sdk nodejs npm mpd \
  ncmpcpp mpv vlc htop w3m firefox qutebrowser python-adblock isync msmtp \
  msmtp-mta neomutt notmuch pandoc haskell-citeproc texlive-most biber texlab \
  zathura zathura-cb zathura-djvu zathura-pdf-mupdf zathura-ps xournalpp \
  libreoffice-still rclone python-gpgme youtube-dl flameshot transmission-gtk \
  qt5-base qt5-webengine qt5-tools qt5-webkit pdfjs
```

# Post-Install (WIP)

## AUR (WIP)
As per the instructions on the `yay` 
[GitHub page](https://github.com/Jguer/yay), run the following.
```sh
sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
```
Then, I install packages as follows.
```sh
yay -Syyu --needed google-chrome ttf-juliamono
```

### Older AUR stuff (REORGANIZE)
```sh
paru -Syu google-chrome dropbox thunar-dropbox zotero zoom spotify tzupdate \
  armadillo ttf-juliamono ttf-iosevka nerd-fonts-source-code-pro \
  nerd-fonts-fira-mono nerd-fonts-fira-code nerd-fonts-jetbrains-mono \
  nerd-fonts-iosevka ttf-ms-fonts skypeforlinux-stable-bin vim-language-server \
  lua-language-server-git dotnet-sdk-bin dotnet-runtime-bin \
  openprinting-ppds-pxlmono-ricoh dxvk-bin \
```

## Older stuff (REORGANIZE)

### Install packages using `conda`
```sh
conda install -y numpy scipy pandas statsmodels linearmodels \
  scikit-learn matplotlib python-lsp-server jedi pep8 flake8 ipython jupyter \
  pynvim sphinx
```

```
conda install -y seaborn sympy xarray scikit-image pandas-datareader visidata \
  xeus xeus-python xeus-cling jupytext \
  networkx dask netCDF4 bottleneck pygraphviz pydot \
  lfortran psutil mypy python-language-server[all] pyls-mypy \
  httplib2 pygments pygobject gtk3
```

### Julia
```julia
using Pkg
Pkg.add(["NLopt", "JuMP", "HDF5", "JLD", "CSV", "DataFrames", "StatFiles",
         "ReadStat", "NPZ", "CategoricalArrays", "ShiftedArrays", "StatsBase",
         "Distributions", "Distances", "StatsFuns", "LogExpFunctions",
         "MultivariateStats", "GLM", "MixedModels", "TimeSeries", "Clustering",
         "Loess", "KernelDensity", "HypothesisTests", "Bootstrap", "StatsKit",
         "Plots", "StatsPlots", "IJulia", "PackageCompiler", "BenchmarkTools",
         "LanguageServer", "SymbolServer", "StaticLint", "Debugger",
         "LibSSH2_jll", "JuliaInterpreter", "MKL_jll", "Grisu", "GR_jll",
         "Latexify", "LibVPX_jll", "Contour", "PrettyTables", "EzXML"])
```


## Systemd User services
- Maestral
- kanshi
- swayosd ?
