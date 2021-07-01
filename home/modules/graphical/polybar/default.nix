{ config, pkgs, lib, ... }:

with lib;

{
  options.polybar = {
    enable = mkEnableOption "Polybar";
    colours = {
      background = mkOption {
        type = types.str;
        default = "#222";
        example = "#123456";
        description = "The background colour of the bar.";
      };
      background-alt = mkOption {
        type = types.str;
        default = "#444";
        example = "#123456";
        description = "A colour that replaces the background in some modules.";
      };
      foreground = mkOption {
        type = types.str;
        default = "#dfdfdf";
        example = "#123456";
        description = "The foreground (text) colour of the bar.";
      };
      foreground-alt = mkOption {
        type = types.str;
        default = "#555";
        example = "#123456";
        description = "A colour that replaces the foreground in some modules.";
      };
      alert = mkOption {
        type = types.str;
        default = "#bd2c40";
        example = "#123456";
        description = "A colour used when an alert happens (usually wm modules I think).";
      };
      wm-underline = mkOption {
        type = types.str;
        default = "#ffb52a";
        example = "#123456";
        description = "The colour used for underlining the wm module";
      };
      date-underline = mkOption {
        type = types.str;
        default = "#ffb52a";
        example = "#123456";
        description = "The colour used for underlining the date module";
      };
      battery-underline = mkOption {
        type = types.str;
        default = "#ffb52a";
        example = "#123456";
        description = "The colour used for underlining the battery module";
      };
    };
  };

  config = mkIf config.polybar.enable {
    services.polybar = {
      enable = true;

      script = ''
        # Terminate already running bar instances
        #killall -q polybar

        # Wait until the processes have been shut down
        #while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

        # Launch Polybar
        export DISPLAY=:0
        polybar -rq bar &
      '';

      settings = import ./settings.nix { inherit config; };
    };
  };
}
