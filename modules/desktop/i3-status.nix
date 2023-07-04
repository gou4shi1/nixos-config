{ config, ... }:

let
  cfg = config.mynix.desktop.xserver;

  battery_block = if cfg.i3_show_battery then ''
    [[block]]
    block = "battery"
  '' else "";

  cycle_color_override = ''
    [block.theme_overrides]
    idle_bg = "#586e75"
    idle_fg = "#eee8d5"
  '';

in {
  environment.etc."i3/i3status-rust.toml" = {
    text = ''
      [theme]
      theme = "solarized-dark"

      [icons]
      icons = "material-nf"

      [[block]]
      block = "pomodoro"
      notify_cmd = "i3-nagbar -m ' ''${msg}'"
      blocking_cmd = true
      ${cycle_color_override}

      [[block]]
      block = "net"
      format = " ^icon_net_down$speed_down.eng(prefix:K) ^icon_net_up$speed_up.eng(prefix:K) $icon {$ssid.str(max_w:8).. |}{$ip |}"
      missing_format = ""
      inactive_format = ""

      [[block]]
      block = "net"
      device = "tun"
      format = "$icon {$ip |}"
      missing_format = ""
      inactive_format = ""

      [[block]]
      block = "cpu"
      format = " $icon $barchart $utilization "
      ${cycle_color_override}

      [[block]]
      block = "memory"
      format = " $icon $mem_used_percents.eng(w:1) "

      [[block]]
      block = "disk_space"
      format = " $icon $used.eng(p:Gi)/$total.eng(p:Gi) "
      ${cycle_color_override}

      ${battery_block}

      #[[block]]
      #block = "nvidia_gpu"

      #[[block]]
      #block = "backlight"

      #[[block]]
      #block = "sound"
      #headphones_indicator = true

      [[block]]
      block = "time"
      format = " $icon $timestamp.datetime(f:'%a, %b %d, %R') "
    '';
  };
}
