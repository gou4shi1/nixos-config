{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    git-fuzzy
    difftastic
  ];

  programs.git = {
    enable = true;
    package = with pkgs; (if stdenv.isDarwin then git else gitFull);
    settings = {
      init = {
        defaultBranch = "master";
      };
      fetch.prune = true;
      pull.rebase = true;
      alias = {
        edit-unmerged = "!f() { git ls-files --unmerged | cut -f2 | sort -u ; }; nvim `f`";
      };
    };
    lfs = {
      enable = true;
      skipSmudge = false;
    };
    includes = [
      { path = ./delta-themes.gitconfig; }
      { path = ./difftastic.gitconfig; }
    ];
  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options = {
      features = "calochortus-gou4shi1";
      side-by-side = true;
      navigate = true;
    };
  };

  programs.lazygit = {
    enable = true;
    settings = {
      git.paging = {
        pager = "delta --paging=never";
      };
    };
  };
}
