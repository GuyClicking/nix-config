{ lib, ... }:
# Directory library functions

with lib;

let
  dirs = import ./dirs.nix { inherit lib; };

  files = filterAttrs (name: value: name != "default.nix") (dirs.mapOnDir ./.
    # a will be "regular" on a file and "directory" on a directory
    (name: a:
      let path = "${toString ./.}/${name}"; in
      import path { inherit lib; }
    ));
in
foldAttrs (n: a: n) [] (attrValues files)
