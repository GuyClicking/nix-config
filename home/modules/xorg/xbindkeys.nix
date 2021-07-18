{ config, pkgs, lib, ... }:

with lib;

{
  options.xbindkeys = {
    enable = mkEnableOption "xbindkeys";
  };

  config = mkIf config.xbindkeys.enable {
    home.packages = [ pkgs.xbindkeys ];

    home.file.".xbindkeysrc".text = ''
      # super + shift + Return
      "alacritty"
        m:0x41 + c:36

      # super + shift + l
      "xbindkeys"
        m:0x41 + c:46

      # super + ;
      "rofi -show run"
        m:0x40 + c:47

      # super + shift + alt + q
      "bspc quit"
        m:0x49 + c:29

      # super + alt + q
      "bspc wm -r"
        m:0x48 + c:29

      "bspc node -c"
        m:0x40 + c:54

      "bspc node -k"
        m:0x41 + c:54

#      "lock"
#        m:0x40 + c:53

#      "browser"
#        m:0x40 + c:56

#      "scratchpad"
#        m:0x40 + c:31

#      "calculate"
#        m:0x44 + c:54

      "amixer set Master 5%+"
          XF86AudioRaiseVolume

      "amixer set Master 5%-"
          XF86AudioLowerVolume

      "amixer set Master toggle"
          XF86AudioMute
    '';
  };
}
