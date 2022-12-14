{ config, lib, pkgs, ... }:

let
  cfg = config.mynix.zsh;

in {
  imports = [
    ./options.nix
  ];

  home.sessionVariables = {
    # Do the initialization when the script is sourced.
    ZVM_INIT_MODE = "sourcing";
    # Use case-sensitive completion.
    CASE_SENSITIVE = "true";
    # To allow zsh load completion files under /nix/store.
    ZSH_DISABLE_COMPFIX = "true";
    # Let CMake automatically generates Compilation Databases.
    CMAKE_EXPORT_COMPILE_COMMANDS = "ON";
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    history = rec {
      size = 1000000;
      save = size;
    };
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git" "gitfast" "extract" "sudo" "colored-man-pages" "history-substring-search"
      ];
    };
    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "powerlevel10k-config";
        src = lib.cleanSource ./p10k-config;
        file = "${cfg.prompt_style}.zsh";
      }
      {
        name = "fast-syntax-highlighting";
        src = pkgs.zsh-fast-syntax-highlighting;
        file = "share/zsh/site-functions/fast-syntax-highlighting.plugin.zsh";
      }
      {
        name = "zsh-vi-mode";
        src = pkgs.zsh-vi-mode;
        file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
      }
      {
        name = "zsh-nix-shell";
        src = pkgs.zsh-nix-shell;
        file = "share/zsh-nix-shell/nix-shell.plugin.zsh";
      }
    ];
    initExtraFirst = ''
      # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
      # Initialization code that may require console input (password prompts, [y/n]
      # confirmations, etc.) must go above this block; everything else may go below.
      if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
        source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
      fi
    '';
    initExtra = ''
      # Use Up/Down arrow keys to search substring in history.
      zvm_bindkey viins "^[[A" history-substring-search-up
      zvm_bindkey viins "^[[B" history-substring-search-down
      # Fix Home/End keys in zsh-vi-mode.
      zvm_bindkey viins "^[[H" beginning-of-line
      zvm_bindkey viins  "^[[F" end-of-line
      zvm_bindkey vicmd "^[[H" beginning-of-line
      zvm_bindkey vicmd "^[[F" end-of-line
      zvm_bindkey visual "^[[H" beginning-of-line
      zvm_bindkey visual "^[[F" end-of-line

      # Add more LS_COLORS.
      source ${pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/trapd00r/LS_COLORS/edd84f960080fcd4ca2691748acbda4da8ae3939/lscolors.sh";
        hash = "sha256-XSFP48J78mrnjd0Rdzd6NzogTBWAgm7vUDu3gcHvdsE=";
      }}
    '';
    shellAliases = {
      # Vim
      v = "vim";
      gv = "gvim";
      # VCS
      origin = "git fetch origin $(current_branch) && git reset --hard origin/$(current_branch)";
      lg = "lazygit";
      ap = "arc patch --nobranch";
      ac = "arc diff HEAD~ --create";
      au = "arc diff HEAD~ --update";
      al = "arc land";
    };
  };
}
