{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (config.lib.dots.whoami) pgpPublicKey;

  dotsPath = "${config.xdg.configHome}/dots";
in {
  home.sessionVariables.AGENIX_ROOT = dotsPath;
}
