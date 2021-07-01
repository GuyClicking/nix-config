{ config, ... }:

let
  background = config.polybar.colours.background;
  background-alt = config.polybar.colours.background-alt;
  foreground = config.polybar.colours.foreground;
  foreground-alt = config.polybar.colours.foreground-alt;
  alert = config.polybar.colours.alert;

in
{
  # Bars
  "bar/bar" = {
    font-0 = "HackNerdFont:size=10:antialias=true#3";

    height = 25;

    background = background;

    wm-restack = "bspwm";

    padding = 2;

    line-size = 2;

    modules-left = "bspwm";
    modules-center = "date";
    modules-right = "battery";
  };
  # Modules

  "module/bspwm" = {
    type = "internal/bspwm";

    label-focused = "%index%";
    #label-focused = "";
    label-focused-background = background-alt;
    label-focused-underline = config.polybar.colours.wm-underline;
    label-focused-padding = 2;

    label-occupied = "%index%";
    #label-occupied = "";
    label-occupied-padding = 2;

    label-urgent = "%index%!";
    #label-urgent = "";
    label-urgent-background = alert;
    label-urgent-padding = 2;

    label-empty = "%index%";
    #label-empty = "";
    label-empty-foreground = foreground-alt;
    label-empty-padding = 2;

    # Separator in between workspaces
    #label-separator = "|";
  };

  "module/date" = {
    type = "internal/date";
    interval = 1;

    date = "";
    time = "%H:%M";

    date-alt = "%d/%m/%y";
    time-alt = "%H:%M:%S";

    label = "%date% %time%";

    format = " <label>";
    #format-background = background-alt;
    format-underline = config.polybar.colours.date-underline;
    format-padding = 2;
  };

  "module/battery" = {
    type = "internal/battery";
    battery = "BAT0";
    adapter = "ADP1";
    poll_interval = 5;

    format-charging = "<ramp-capacity> <label-charging>";
    #format-charging-background = background-alt;
    format-charging-underline = config.polybar.colours.battery-underline;
    format-charging-padding = 2;

    format-discharging = "<ramp-capacity> <label-discharging>";
    #format-discharging-background = background-alt;
    format-discharging-underline = config.polybar.colours.battery-underline;
    format-discharging-padding = 2;

    format-full = "<ramp-capacity> <label-full>";
    #format-full-background = background-alt;
    format-full-underline = config.polybar.colours.battery-underline;
    format-full-padding = 2;

    ramp-capacity-0 = " ";
    ramp-capacity-1 = " ";
    ramp-capacity-2 = " ";
    ramp-capacity-3 = " ";
    ramp-capacity-4 = " ";
  };

  "settings" = {
    screenchange-reload = true;
    #compositing-background = xor
    #compositing-background = screen
    #compositing-foreground = source
    #compositing-border = over
    #pseudo-transparency = false
  };

  "global/wm" = {
    margin-top = 5;
    margin-bottom = 5;
  };
  # vim:ft=dosini
}
