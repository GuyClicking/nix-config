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
    home.packages = [ pkgs.any-nix-shell ];
    programs.zsh = {
      enable = true;

      history = {
        path = "/home/benjamin/.cache/zsh/history";
      };

      # bind keys properly for backword or switch to vi mode??

      shellAliases = {
        ls = "ls --color=auto";
        l = "ls";
        la = "ls -la";
        grep = "grep --color=auto";
        v = config.zsh.editor;
        tmux = "tmux -2";
        die = "shutdown now";
        idris2 = "rlwrap idris2";
      };

      sessionVariables = {
        EDITOR = config.zsh.editor;
        NIX_PATH = "\$HOME/.nix-defexpr/channels\${NIX_PATH:+:}\$NIX_PATH";
        TERMINAL = "alacritty";
      };

      initExtra = ''
        #. ~/.nix-profile/etc/profile.d/nix.sh

        any-nix-shell zsh --info-right | source /dev/stdin

        # From the fzf wiki
        fd() {
          local dir
          dir=$(find ''${1:-.} -path '*/\.*' -prune \
                          -o -type d -print 2> /dev/null | fzf-tmux -r +m) &&
          cd "$dir"
        }

        fh() {
          eval $(history -n | fzf-tmux -r +m)
        }

        fmv() {
          local dir
          dir=$(find ''${2:-.} -path '*/\.*' -prune \
                          -o -type d -print 2> /dev/null | fzf-tmux -r +m) &&
          mv $1 "$dir"
        }

        fcp() {
          local dir
          dir=$(find ''${2:-.} -path '*/\.*' -prune \
                          -o -type d -print 2> /dev/null | fzf-tmux -r +m) &&
          cp $1 "$dir"
        }
      '';

      #      plugins = [
      #        {
      #          name = "zsh-nix-shell";
      #          file = "nix-shell.plugin.zsh";
      #          src = pkgs.fetchFromGitHub {
      #            owner = "chisui";
      #            repo = "zsh-nix-shell";
      #            rev = "v0.1.0";
      #            sha256 = "0snhch9hfy83d4amkyxx33izvkhbwmindy0zjjk28hih1a9l2jmx";
      #          };
      #        }
      #      ];
    };
  };
}
