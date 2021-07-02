{ config, pkgs, lib, ... }:

with lib;

{
  options.dunst = {
    enable = mkEnableOption "Dunst";

    geometry = {
      width = mkOption {
        type = types.int;
        default = 300;
        example = 200;
        description = "Width of notifications";
      };
      height = mkOption {
        type = types.int;
        default = 5;
        example = 10;
        description = "Height of notifications";
      };
      x = mkOption {
        type = types.int;
        default = 30;
        example = 50;
        description = "x position of notifications";
      };
      y = mkOption {
        type = types.int;
        default = 20;
        example = 50;
        description = "y position of notifications";
      };
    };

    font = mkOption {
      type = types.str;
      default = "Hack";
      example = "Hack";
      description = "Font used";
    };
  };

  config = mkIf config.dunst.enable {
    home.packages = [ pkgs.libnotify ];
    services.dunst = {
      enable = true;
      settings = {
        global = {
          follow = "keyboard";

          geometry = (g: "${toString g.width}x${toString g.height}-${toString g.x}+${toString g.y}") config.dunst.geometry;
          #corner_radius = 0;
          #transparency = 0;

          #progress_bar = true;
          #progress_bar_height = 10;
          #progress_bar_frame_width = 1;
          #progress_bar_min_width = 150;
          #progress_bar_max_width = 300;

          #indicate_hidden = true;

          #shrink = false;

          #notification_height = 0;

          #separator_height = 2;
          #separator_color = "auto";

          #padding = 0;
          #horizontal_padding = 0;
          #text_icon_padding = 0;

          #frame_color = "#888888";
          #frame_width = 0;

          #sort = true;

          #idle_threshold = 0;

          font = config.dunst.font;

          #line_height = 0;

          #markup = "no";

          #format = "%s %b";

          #alignment = "left";
          #vertical_alignment = "center";

          #show_age_threshold = -1;

          #word_wrap = false;

          #ellipsize = "middle";

          #ignore_newline = false;

          #stack_duplicates = true;
          #hide_duplicate_count = false;

          #show_indicatores = true;

          #icon_position = "off";
          #min_icon_size = 0;
          #max_icon_size = 0;

          #sticky_history = true;
          #history_length = 20;

          #dmenu = an option;
          #browser = an option;

          #always_run_script = true;

          #title = "Dunst";
          #class = "Dunst";

          #startup_notification = false;

          #verbosity = "mesg";

          #mouse_left_click = "none";
          #mouse_middle_click = "none";
          #mouse_right_click = "none";

          #ignore_dbusclose = false;
        };
        urgency_critical = {};
        urgency_normal = {};
        urgency_low = {};
      };
    };
  };
}
