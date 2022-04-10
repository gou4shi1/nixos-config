{ config, lib, pkgs, ... }:

let
  cfg = config.mynix.desktop;

  xserverOptions = with lib; {
    options = {
      i3_show_battery = mkEnableOption "Show battery on i3 status bar.";
      i3_show_full_ip = mkEnableOption "Show full ip on i3 status bar.";
      i3_bar_font_size = mkOption {
        description = "The font size of i3 status bar.";
        type = types.int;
        default = 11;
      };
    };
  };

in {
  imports = [
    ./i3-status.nix
    ./rofi-config.nix
    ./session-locker.nix
  ];

  options.mynix.desktop = with lib; {
    enable = mkEnableOption "Enable Desktop";
    xserver = mkOption {
      description = "Wrapper of xserver related configurations.";
      type = types.submodule xserverOptions;
    };
  };

  config = lib.mkIf cfg.enable {
    services.xserver = {
      enable = true;
      xkbOptions = "ctrl:nocaps";

      displayManager = {
        lightdm = {
          enable = true;
          greeters.enso.enable = true;
        };
        defaultSession = "xfce+i3";
      };

      desktopManager.xfce = {
        enable = true;
        noDesktop = true;
        enableXfwm = false;
      };

      windowManager.i3 = {
        enable = true;
        extraPackages = with pkgs; [
          rofi rofi-power wmfocus
          i3status-rust i3lock-fancy-rapid
          i3-resurrect i3-get-window-criteria
        ];
        configFile = with cfg.xserver; pkgs.substituteAll {
          src = ./i3.config;
          inherit i3_bar_font_size;
        };
      };

      libinput.touchpad.disableWhileTyping = true;
    };

    sound.enable = true;
    hardware.pulseaudio.enable = true;

    fonts = {
      fonts = with pkgs; [
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
  };
}
