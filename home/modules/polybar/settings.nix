let
  #background = "\${xrdb:background}";
  background = "#222";
  background-alt = "#444";
  #foreground = "\${xrdb:background}";
  foreground = "#dfdfdf";
  foreground-alt = "#555";
  primary = "#ffb52a";
  secondary = "#e60053";
  alert = "#bd2c40";
in {
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
    modules-right = "battery powermenu";
  };
  # Modules

  "module/bspwm" = {
    type = "internal/bspwm";

    label-focused = "%index%";
    #label-focused = "";
    label-focused-background = background-alt;
    label-focused-underline= primary;
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
    format-underline = primary;
    format-padding = 2;
  };

  "module/battery" = {
    type = "internal/battery";
    battery = "BAT0";
    adapter = "ADP1";
    poll_interval = 5;

    format-charging = "<ramp-capacity> <label-charging>";
    #format-charging-background = background-alt;
    format-charging-underline = primary;
    format-charging-padding = 2;

    format-discharging = "<ramp-capacity> <label-discharging>";
    #format-discharging-background = background-alt;
    format-discharging-underline = primary;
    format-discharging-padding = 2;

    format-full = "<ramp-capacity> <label-full>";
    #format-full-background = background-alt;
    format-full-underline = primary;
    format-full-padding = 2;

    ramp-capacity-0 = " ";
    ramp-capacity-1 = " ";
    ramp-capacity-2 = " ";
    ramp-capacity-3 = " ";
    ramp-capacity-4 = " ";
  };

  "module/powermenu" = {
    type = "custom/menu";

    expand-right = "true";

    format-spacing = 1;

    label-open = "";
    label-open-foreground = secondary;
    label-close = " cancel";
    label-close-foreground = secondary;
    label-separator = "|";
    label-separator-foreground = foreground-alt;

    menu-0-0 = "reboot";
    menu-0-0-exec = "menu-open-1";
    menu-0-1 = "power off";
    menu-0-1-exec = "menu-open-2";

    menu-1-0 = "cancel";
    menu-1-0-exec = "menu-open-0";
    menu-1-1 = "reboot";
    menu-1-1-exec = "sudo reboot";

    menu-2-0 = "power off";
    menu-2-0-exec = "sudo poweroff";
    menu-2-1 = "cancel";
    menu-2-1-exec = "menu-open-0";
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
