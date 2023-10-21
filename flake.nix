{
  description = "My systems and homes";
  
  inputs = {

    # Principle inputs
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1.0.tar.gz";
    nixos-hardware.url = "https://flakehub.com/f/NixOS/nixos-hardware/0.1.*.tar.gz";
    home-manager = {
      url = "https://flakehub.com/f/nix-community/home-manager/0.1.*.tar.gz";
    };
    disko = {
      url = "https://flakehub.com/f/nix-community/disko/1.*.tar.gz";
    };

    flake-parts.url = "github:hercules-ci/flake-parts";
    nixos-flake.url = "github:srid/nixos-flake";
    nix-darwin.url = "github:lnl7/nix-darwin";

    # secret mgmt
    sops-nix.url = "https://flakehub.com/f/Mic92/sops-nix/0.1.*.tar.gz";

    # Software
    nixos-shell.url = "https://flakehub.com/f/Mic92/nixos-shell/1.*.tar.gz";
    emanote.url = "github:srid/emanote";
    nuenv.url = "https://flakehub.com/f/DeterminateSystems/nuenv/0.1.*.tar.gz";

    treefmt-nix.url = "github:numtide/treefmt-nix";
  };
  
  outputs = inputs@{ self, ... }:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-darwin" ];
      imports = [
        inputs.treefmt-nix.flakeModule
        inputs.nixos-flake.flakeModule
        ./users
        ./home
        ./nixos
        #./nix-darwin
      ];
      flake = {
        # Configurations for Linux (NixOS) systems
        nixosConfigurations = {
          hodgepodge = self.nixos-flake.lib.mkLinuxSystem {
            imports = [
              self.nixosModules.default # Defined in nixos/default.nix
              inputs.sops-nix.nixosModules.sops
              ./systems/hodgepodge
              #./nixos/server/harden.nix
              ./nixos/docker.nix
              #./nixos/lxd.nix
              #./nixos/jenkins.nix
            ];
            services.tailscale.enable = true;
            sops.defaultSopsFile = ./secrets.json;
            sops.defaultSopsFormat = "json";
          };
        };
     perSystem = { self', system, pkgs, lib, config, inputs', ... }: {
        # NOTE: These overlays apply to the Nix shell only. See `nix.nix` for
        # system overlays.
        _module.args.pkgs = import inputs.nixpkgs {
          inherit system;
          overlays = [
            inputs.jenkins-nix-ci.overlay
          ];
        };

        nixos-flake.primary-inputs = [ "nixpkgs" "home-manager" "nix-darwin" "nixos-flake" ];

        treefmt.config = {
          projectRootFile = "flake.nix";
          programs.nixpkgs-fmt.enable = true;
          settings.formatter.nixpkgs-fmt.excludes =
            let
              nixosConfig = self.nixosConfigurations.hodgepodge;
              jenkinsPluginsFile = nixosConfig.config.jenkins-nix-ci.plugins-file;
            in
            [ jenkinsPluginsFile ];
        };

        packages.default = self'.packages.activate;
        devShells.default = pkgs.mkShell {
          buildInputs = [
            pkgs.nixpkgs-fmt
            pkgs.sops
            pkgs.ssh-to-age
            (
              let nixosConfig = self.nixosConfigurations.hodgepodge;
              in nixosConfig.config.jenkins-nix-ci.nix-prefetch-jenkins-plugins pkgs
            )
          ];
        };
        formatter = config.treefmt.build.wrapper;
      };
    };
  };
}
