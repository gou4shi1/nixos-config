{ config, lib, pkgs, ... }:

let

in {
  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    userName = "Guangqing Chen";
    userEmail = "hi@goushi.me";
    extraConfig = {
      init = {
        defaultBranch = "master";
      };
      fetch.prune = true;
      pull.rebase = true;
    };
    aliases = {
      edit-unmerged = "!f() { git ls-files --unmerged | cut -f2 | sort -u ; }; vim `f`";
    };
    lfs = {
      enable = true;
      skipSmudge = false;
    };
    delta = {
      enable = true;
      options = {
        line-number = true;
        side-by-side = true;
        navigate = true;
      };
    };
  };
}
