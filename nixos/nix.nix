{ flake, pkgs, lib, ... }:

{
  nixpkgs = {
    config = {
      allowBroken = true;
      allowUnsupportedSystem = true;
      allowUnfree = true;
    };
    #overlays = [
    #  flake.inputs.jenkins-nix-ci.overlay
    #  flake.inputs.nuenv.overlays.nuenv
    #  flake.inputs.nixd.overlays.default
    #  flake.inputs.nuenv.overlays.default
    #  (import ../packages/overlay.nix)
    #];
  };

  nix = {
    package = pkgs.nixUnstable;
    nixPath = [ "nixpkgs=${flake.inputs.nixpkgs}" ]; # Enables use of `nix-shell -p ...` etc
    registry.nixpkgs.flake = flake.inputs.nixpkgs; # Make `nix shell` etc use pinned nixpkgs
    settings = {
      max-jobs = "auto";
      experimental-features = "nix-command flakes repl-flake";
      # I don't have an Intel mac.
      extra-platforms = lib.mkIf pkgs.stdenv.isDarwin "aarch64-darwin x86_64-darwin";
      # Nullify the registry for purity.
      flake-registry = builtins.toFile "empty-flake-registry.json" ''{"flakes":[],"version":2}'';
      trusted-users = [ "root" flake.config.people.myself ];
    };
  };
}


