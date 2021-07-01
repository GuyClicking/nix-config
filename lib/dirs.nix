{ lib, ... }:

with lib;

rec {

  /*
   * Recursively read a directory
   * Ugly code warning!
   */
  readDirRec = dir:
  let d = builtins.readDir dir; in
  foldAttrs (n: a: n) [] (attrValues (mapAttrs (n: v:
  if v == "directory" then
  # Add the directory name to the start of the file
  # e.g. file.nix in directory called dir -> dir/file.nix
  mapAttrs' (fName: fVal:
  nameValuePair "${n}/${fName}" "${n}/${fName}")
  (readDirRec "${toString dir}/${n}")

  # Else it is a normal file
  # Yeah dont mind this weird stuff it's so that the
  # directory stuff works lol
  else {${n} = n;})
  d));

  /*
   * Map the function fn to every file in dir
   */
  mapOnDir = dir: fn:
  let d = builtins.readDir dir; in
  mapAttrs (fn) d;

  mapOnDir' = dir: fn:
  let d = builtins.readDir dir; in
  mapAttrs' (fn) d;

  mapOnDirRec = dir: fn:
  let d = readDirRec dir; in
  mapAttrs (fn) d;

  mapOnDirRec' = dir: fn:
  let d = readDirRec dir; in
  mapAttrs' (fn) d;

  importDir = dir:
  map (file: "${toString dir}/${file}") (filter (f: f != "default.nix") (attrValues (mapOnDir dir (name: a:
  name))));

  importDir' = dir:
  map (file: "${toString dir}/${file}") (filter (f: f != "default.nix") (attrValues (mapOnDir' dir (name: a:
  name))));

  importDirRec = dir:
  map (file: "${toString dir}/${file}") (filter (f: f != "default.nix" && hasSuffix ".nix" f) (attrValues (mapOnDirRec dir (name: a:
  name))));

  importDirRec' = dir:
  map (file: "${toString dir}/${file}") (filter (f: f != "default.nix" && hasSuffix ".nix" f) (attrValues (mapOnDirRec' dir (name: a:
  name))));
}
