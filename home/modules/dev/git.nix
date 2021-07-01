{ config, pkgs, lib, ... }:

with lib;

{
  options.git = {
    enable = mkEnableOption "Git";
  };

  config = mkIf config.git.enable {
    programs.git = {
      enable = true;
      aliases = {
        ga = "add";
        gc = "commit";
        gd = "diff";
        gp = "push";
        gs = "status";
      };
      userEmail = "bpaul@bpaul.xyz";
      userName = "Benjamin Paul";

      extraConfig = {
        core = {
          askPass = "";
          autocrlf = "input";
        };
        github.user = "GuyClicking";
        help.autocorrect = 1;
        init.defaultBranch = "main";
      };
    };
  };
}
