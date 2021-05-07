{ config, pkgs, lib, ...}:

with lib;

{
  options.polybar = {
    enable = mkEnableOption "Polybar";
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

      settings = import ./settings.nix;
    };
  };
}
