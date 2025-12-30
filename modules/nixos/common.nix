{ config, lib, pkgs, inputs, ... }:

{

  imports = [
    ../common
  ];

  # User account.
  users.users.ahnafrafi = {
    isNormalUser = true;
    description = "Ahnaf Rafi";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # Enable Network Manager
  networking.networkmanager.enable = true;

  # Enable bluetooth support
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        # Allow headsets to connect using the A2DP profile.
        Enable = "Source,Sink,Media,Socket";
        # Shows battery charge of connected devices on supported
        # Bluetooth adapters. Defaults to 'false'.
        Experimental = true;
      };
      Policy = {
        # Enable all controllers when they are found. This includes
        # adapters present on start as well as adapters that are plugged
        # in later on. Defaults to 'true'.
        AutoEnable = true;
      };
    };
  };

  # Time zone is set automatically by automatic-timezond, but defaults to
  # America/New_York.
  services.automatic-timezoned.enable = true;
  time.timeZone = lib.mkDefault "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Programs:
  # Regreet greeter for greetd.
  programs.regreet.enable = true;

  # Hyprland compositor.
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Packages installed in system profile.
  environment.systemPackages = with pkgs; [
    brightnessctl
    foot
    wl-clipboard
    waybar
    rofi
    hyprpaper
    pcmanfm
    adwaita-icon-theme
  ];

  # List of services.
  # TODO: Make all/most of these conditional on being a laptop.
  # Bluetooth management with blueman.
  services.blueman.enable = true;

  # Audio with pipewire.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.extraConfig.bluetoothEnhancements = {
      "monitor.bluez.properties" = {
          "bluez5.enable-sbc-xq" = true;
          "bluez5.enable-msbc" = true;
          "bluez5.enable-hw-volume" = true;
          "bluez5.roles" = [ "hsp_hs" "hsp_ag" "hfp_hf" "hfp_ag" ];
      };
    };
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable dbus.
  services.dbus.enable = true;

  # Enable touchpad support.
  services.libinput.enable = true;

  # Enable CPU temperature management by thermald.
  services.thermald.enable = true;

  # Enable tlp powermanagement.
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

      # Optional helps save long term battery health
      START_CHARGE_THRESH_BAT0 = 75; # 40 and below it starts to charge
      STOP_CHARGE_THRESH_BAT0 = 90; # 80 and above it stops charging
    };
  };
}
