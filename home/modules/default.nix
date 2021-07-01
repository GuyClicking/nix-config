{ lib, ... }:

with lib;

let
  libExtra = import ../../lib { inherit lib; };

  importModulesRecursively = dir:
    let d = builtins.readDir dir; in
    if hasAttrByPath [ "default.nix" ] d then [ "" ] else
    concatLists (mapAttrsToList
      (n: v:
        if v == "directory" then
          map (f: "${n}/${f}") (importModulesRecursively "${toString dir}/${n}")
        else [ "${n}" ])
      d);

  callImportModules = dir:
    let d = builtins.readDir dir; in
    concatLists (mapAttrsToList
      (n: v:
        if v == "directory" then
          map (f: "${toString dir}/${n}/${f}") (importModulesRecursively "${toString dir}/${n}")
        else "${toString dir}/${n}")
      (filterAttrs (n: v: n != "default.nix") d));
in
{
  # Basically just imports everything
  # If importing a directory which contains a default.nix treat it like
  # it is its own module
  # An example of one of these is ./dev/neovim
  imports = callImportModules ./.;
}
