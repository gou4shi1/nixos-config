{ config, lib, pkgs, ... }:

let
  cfg = config.mynix.desktop.xserver;

  battery_block = if cfg.i3_show_battery then ''
    [[block]]
    block = "battery"
    allow_missing = true
  '' else "";

  ip_format = if cfg.i3_show_full_ip then "{ips}" else "{ips^8}..";

in {
  environment.etc."i3/i3status-rust.toml" = {
    text = ''
      theme = "solarized-dark"
      icons = "material-nf"

      [[block]]
      block = "pomodoro"

      [[block]]
      block = "net"
      hide_missing = true
      hide_inactive = true
      #device = "wlp2s0"
      #format = "{ssid} {signal_strength} {ip} {speed_down;K*b} {graph_down;K*b}"

      [[block]]
      block = "networkmanager"
      device_format = "{icon}{ap} ${ip_format}"
      interface_name_exclude = ["br\\-[0-9a-f]{12}", "docker\\d+"]
      interface_name_include = []

      [[block]]
      block = "cpu"
      format = "{barchart} {utilization}"

      [[block]]
      block = "memory"
      format_mem = "{mem_used_percents}"
      format_swap = "{swap_used_percents}"

      [[block]]
      block = "disk_space"
      format = "{icon} {used}/{total}"

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
      format = "%a, %b %d, %H:%M"
    '';
  };
}
