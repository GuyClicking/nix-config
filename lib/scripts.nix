{ lib, ... }:

# Library functions for writing scripts

{
  createScriptFile = name: source: {
    target = ".local/scripts/${name}";
    text = builtins.readFile source;
    executable = true;
  };
}
