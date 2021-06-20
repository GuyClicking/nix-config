{ lib, ... }:

with lib;

rec {
  /*
    * Map the function fn to every file in dir
  */
  mapOnDir = dir: fn:
  let d = builtins.readDir dir; in
  builtins.mapAttrs (fn) d;

  importDir = dir:
  map (file: "${toString dir}/${file}") (filter (f: f != "default.nix") (attrValues (mapOnDir dir (name: a:
  name))));
}
