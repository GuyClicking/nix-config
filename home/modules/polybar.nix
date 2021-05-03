{
  enable = true;

  script = builtins.readFile ./polybar.sh;

  config = ./polybar.conf;
}
