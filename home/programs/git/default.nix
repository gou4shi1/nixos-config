{ config, lib, pkgs, ... }:

let

in {
  home.packages = with pkgs; [
    lazygit git-fuzzy difftastic
  ];

  programs.git = {
    enable = true;
    package = with pkgs; (if stdenv.isDarwin then git else gitFull);
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
        features = "calochortus-gou4shi1";
        side-by-side = true;
        navigate = true;
      };
    };
    includes = [
      { path = ./delta-themes.gitconfig; }
      { path = ./difftastic.gitconfig; }
    ];
  };
}
