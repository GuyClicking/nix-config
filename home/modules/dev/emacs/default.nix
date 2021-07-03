{ config, pkgs, lib, ... }:

with lib;

{
  options.emacs = {
    enable = mkEnableOption "Emacs";
  };

  config = mkIf config.emacs.enable {
    programs.emacs = {
      enable = true;
      package = pkgs.emacsPgtkGcc;

      extraPackages = epkgs: [
        epkgs.gruvbox-theme
      ];
    };

    home.file.".emacs.d/init.el".text = ''
;; Set up package.el to work with MELPA
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
(package-refresh-contents)

;; Download Evil
(unless (package-installed-p 'evil)
  (package-install 'evil))

(setq evil-want-C-u-scroll t)

;; Enable Evil
(require 'evil)
(evil-mode 1)

(load-theme 'gruvbox t)
    '';
    services.emacs.enable = true;
  };
}
