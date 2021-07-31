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

    aliases = mkOption {
      type = types.attrsOf types.string;
      default = {};
      example = { a = "echo hello"; };
      description = "Attrset of aliases";
    };
  };

  config = mkIf config.zsh.enable {
    home.packages = [ pkgs.any-nix-shell ];
    programs.zsh = {
      enable = true;

      defaultKeymap = "viins";

      dotDir = ".config/zsh";

      # Fix slow startup time on laptop
      # https://gist.github.com/ctechols/ca1035271ad134841284
      completionInit = ''
      autoload -Uz compinit

      for dump in ''${ZDOTDIR}/.zcompdump(N.mh+24); do
        compinit
      done

      compinit -C;
      '';

      history = {
        path = "/home/benjamin/.cache/zsh/history";
      };

      shellAliases = {
        die = "shutdown now";
        ga = "git add";
        gc = "git commit";
        gd = "git diff";
        gp = "git push";
        grep = "grep --color=auto";
        gs = "git status";
        idris2 = "rlwrap idris2";
        l = "ls";
        la = "ls -la";
        ls = "ls --color=auto";
        ssh = "TERM=xterm-256color ssh";
        tmux = "tmux -2";
        v = config.zsh.editor;
      };

      sessionVariables = {
        EDITOR = config.zsh.editor;
        NIX_PATH = "\$HOME/.nix-defexpr/channels\${NIX_PATH:+:}\$NIX_PATH";
        TERMINAL = "alacritty";
      };

      initExtra = ''
        #. ~/.nix-profile/etc/profile.d/nix.sh

        any-nix-shell zsh --info-right | source /dev/stdin

        PATH=$PATH:$HOME/.local/scripts:$HOME/.local/bin

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
