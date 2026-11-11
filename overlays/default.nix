final: prev:

let
  unstable = import <unstable> {
    config = {
      allowUnfree = true;
    };
  };
in
{
  rofi-power = final.callPackage ../pkgs/rofi-power { };
  i3-get-window-criteria = final.callPackage ../pkgs/i3-get-window-criteria { };
  git-fuzzy = final.callPackage ../pkgs/git-fuzzy { };
  pack = final.callPackage ../pkgs/pack { };
  debian-hostname = final.callPackage ../pkgs/debian-hostname { };
  typora = final.callPackage ../pkgs/typora { };
  nomachine = final.callPackage ../pkgs/nomachine { };
  clangd = final.callPackage ../pkgs/clangd { };
  xfconf-helper = final.callPackage ../pkgs/xfconf-helper { };
  corplink = final.callPackage ../pkgs/corplink { };
  sync-clipboard = final.callPackage ../pkgs/sync-clipboard { };
  lenovo-legion-module = prev.linuxPackages.lenovo-legion-module.overrideAttrs (old: {
    patches = [ ../pkgs/lenovo-legion-module/y9000p2024.diff ];
  });
  auto-cpufreq = prev.auto-cpufreq.overrideAttrs (old: {
    patches = old.patches ++ [ ../pkgs/auto-cpufreq/fix-stats.diff ];
  });
  # NoMachine removed old tarballs from download.nomachine.com and v10
  # changed licensing; v9.8 is still served from their new download host.
  nomachine-client = prev.nomachine-client.overrideAttrs (old: {
    version = "9.8.2";
    src = prev.fetchurl {
      url = "https://web9001.nomachine.com/download/9.8/Linux/nomachine_9.8.2_1_x86_64.tar.gz";
      sha256 = "06j4vm27wj3n9xccw08984amyj9v1jhj64hvlfn8ziz399wdi5bf";
    };
  });
  # feishu from nixos-25.11
  feishu = prev.feishu.overrideAttrs (old: {
    version = "7.50.14";
    src = prev.fetchurl {
      url = "https://sf3-cn.feishucdn.com/obj/ee-appcenter/e91d15e2/Feishu-linux_x64-7.50.14.deb";
      hash = "sha256-Ywlf3qi4q5nT3gC9r4ymtFYIrg8xmxapIfO2oQoBdC8=";
    };
  });
  herdr = unstable.herdr;
  claude-code = unstable.claude-code;
  codex = unstable.codex;
  opencode = unstable.opencode;
  pi-coding-agent= unstable.pi-coding-agent;
}
