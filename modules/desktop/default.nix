{ config, lib, pkgs, ... }:

let
  cfg = config.mynix.desktop;

  xserverOptions = with lib; {
    options = {
      replace_caps_with_ctrl = mkEnableOption "Replace CapsLock with Ctrl.";
      i3_show_battery = mkEnableOption "Show battery on i3 status bar.";
    };
  };

  usingNvidiaDriver = builtins.elem "nvidia" config.services.xserver.videoDrivers;

in {
  imports = [
    ./hidpi.nix
    ./i3-status.nix
    ./rofi-config.nix
    ./warpd.nix
    ./nomachine.nix
  ];

  options.mynix.desktop = with lib; {
    enable = mkEnableOption "Enable Desktop";
    xserver = mkOption {
      description = "Wrapper of xserver related configurations.";
      type = types.submodule xserverOptions;
    };
    bluetooth = mkEnableOption "Enable Bluetooth";
  };

  config = lib.mkIf cfg.enable {
    services.xserver = {
      enable = true;
      exportConfiguration = true;

      xkb.options = lib.mkIf cfg.xserver.replace_caps_with_ctrl "ctrl:nocaps";

      displayManager = {
        lightdm = {
          enable = true;
          greeters.enso.enable = true;
        };
      };

      desktopManager.xfce = {
        enable = true;
        noDesktop = true;
        enableXfwm = false;
      };

      desktopManager.wallpaper = {
        mode = "fill";
      };

      windowManager.i3 = {
        enable = true;
        extraPackages = with pkgs; [
          rofi rofi-power wmfocus
          i3status-rust i3lock-fancy-rapid
          i3-resurrect i3-get-window-criteria
        ];
        configFile = ./i3.config;
      };
    };

    services.displayManager.defaultSession = "xfce+i3";

    # Use picom as the X.org composite manager.
    services.picom = {
      enable = true;
      backend = "glx";
      fade = true;
      fadeDelta = 5;
      fadeExclude = [
        "name *= 'Fcitx'"
        "name *= 'rofi'"
      ];
      settings = {
        transparent-clipping = true;
        transparent-clipping-exclude = [
          "window_type *= 'menu'"
        ];
      };
    };

    services.libinput.touchpad.disableWhileTyping = true;

    services.pipewire = {
      enable = true;
      pulse.enable = true;
    };

    hardware.bluetooth = {
      enable = cfg.bluetooth;
      powerOnBoot = false;
    };
    services.blueman.enable = cfg.bluetooth;

    fonts = {
      packages = with pkgs; [
        # Wenquanyi Micro Hei is a nice-looking Chinese font.
        wqy_microhei
        # JetBrainsMono is a good font for coding, patched with Nerd Fonts.
        (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
      ];
      fontDir = {
        # Create a directory with links to all fonts: /run/current-system/sw/share/X11/fonts/
        enable = true;
      };
      fontconfig = {
        defaultFonts = {
          serif = [ "JetBrainsMono Nerd Font" "WenQuanYi Micro Hei" ];
          sansSerif = [ "JetBrainsMono Nerd Font" "WenQuanYi Micro Hei" ];
          monospace = [ "JetBrainsMono Nerd Font" "WenQuanYi Micro Hei Mono" ];
        };
      };
    };

    console = {
      packages = with pkgs; [ wqy_microhei terminus_font ];
      font = "ter-132n";
    };

    environment.systemPackages = with pkgs; [
      xfconf-helper feh
    ];

    services.udev.packages = with pkgs; [
      via
    ];

    services.gnome.gnome-keyring.enable = true;
  };
}
