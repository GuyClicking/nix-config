{ lib, ... }:
let
  libExtra = import ../../lib { inherit lib; };
in {
  imports = libExtra.importDir ./.;
}
