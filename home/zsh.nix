{ pkgs, ... }:

let editor = "nvim";
in
{
  enable = true;

  # use starship

  history = {
    path = ".cache/zsh/history";
  };

  # use auto-complete

  # bind keys properly for backword or switch to vi mode??

  shellAliases = {
    ls = "ls --color=auto";
    l = "ls";
    la = "ls -la";
    grep = "grep --color=auto";
    v = editor;
    ga = "git add";
    gc = "git commit";
    gd = "git diff";
    gp = "git push";
    gs = "git status";
    tmux = "tmux -2";
    die = "shutdown now";
  };

  sessionVariables = {
    EDITOR = "nvim";
    NIX_PATH = "\$HOME/.nix-defexpr/channels\${NIX_PATH:+:}\$NIX_PATH";
    TERMINAL = "alacritty";
  };

  initExtra = ''
    . ~/.nix-profile/etc/profile.d/nix.sh
  '';

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
}
