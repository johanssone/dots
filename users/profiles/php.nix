{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: let
  inherit (pkgs) system writeShellScriptBin;
  inherit (inputs.phps.packages.${system}) php80;
  inherit (pkgs.lib.our) dotsPath;
in {
  home.packages = with pkgs; [
    php80
    php80.packages.composer
  ];
  home.sessionPath = [
    # TODO: prepend not append
    "${dotsPath}/.composer/bin"
  ];
  home.sessionVariables = {
    COMPOSER_HOME = "$XDG_STATE_HOME/composer";
  };
}
