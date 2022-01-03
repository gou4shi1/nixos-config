{ config, pkgs, ... }:

{
  imports = [
  ];

  services.xserver = {
    enable = true;
    xkbOptions = "ctrl:nocaps";

    displayManager = {
      lightdm.enable = true;
      defaultSession = "xfce+i3";
    };

    desktopManager.xfce = {
      enable = true;
      noDesktop = true;
      enableXfwm = false;
    };

    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [ rofi rofi-power-menu rofi-file-browser wmfocus i3status-rust i3lock i3lock-fancy-rapid ];
    };

    libinput.touchpad = {
      disableWhileTyping = true;
      # Disable the tap-to-click behavior.
      tapping = false;
    };
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

  i18n = {
    inputMethod = {
      enabled = "fcitx5";
      fcitx5.addons = with pkgs; [ fcitx5-chinese-addons ];
    };
  };

  environment.sessionVariables.TERMINAL = [ "xfce4-terminal" ];
}
