{ config, pkgs, lib, ... }:

with lib;

let editor = "nvim";
in
{
  options.zsh = {
    enable = mkEnableOption "Zsh";

    editor = mkOption {
      type = types.str;
      default = "nvim";
      example = "nano";
      description = "The default editor, which is what \$EDITOR will be set to";
    };
  };

  config = mkIf config.zsh.enable {
    programs.zsh = {
      enable = true;

      history = {
        path = ".cache/zsh/history";
      };

      # bind keys properly for backword or switch to vi mode??

      shellAliases = {
        ls = "ls --color=auto";
        l = "ls";
        la = "ls -la";
        grep = "grep --color=auto";
        v = config.zsh.editor;
        ga = "git add";
        gc = "git commit";
        gd = "git diff";
        gp = "git push";
        gs = "git status";
        tmux = "tmux -2";
        die = "shutdown now";
      };

      sessionVariables = {
        EDITOR = config.zsh.editor;
        NIX_PATH = "\$HOME/.nix-defexpr/channels\${NIX_PATH:+:}\$NIX_PATH";
        TERMINAL = "alacritty";
      };

      #  initExtra = ''
      #    . ~/.nix-profile/etc/profile.d/nix.sh
      #  '';

      plugins = [
        {
          name = "zsh-nix-shell";
          file = "nix-shell.plugin.zsh";
          src = pkgs.fetchFromGitHub {
            owner = "chisui";
            repo = "zsh-nix-shell";
            rev = "v0.1.0";
            sha256 = "0snhch9hfy83d4amkyxx33izvkhbwmindy0zjjk28hih1a9l2jmx";
          };
        }
      ];
    };
  };
}
