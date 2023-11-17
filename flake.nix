{
  description = "Machine specific configuration flake.";
  # Defining package channels
  inputs = {
    nixpkgs.url = "https://api.flakehub.com/f/NixOS/nixpkgs/0.1.0.tar.gz";

    # # flakehub cli
    fh.url = "https://api.flakehub.com/f/DeterminateSystems/fh/0.1.*.tar.gz";

    flake-utils.url = "https://api.flakehub.com/f/numtide/flake-utils/0.1.*.tar.gz";
    flake-parts.url = "github:hercules-ci/flake-parts";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "https://flakehub.com/f/hyprwm/Hyprland/*.tar.gz";
      #url = "github:hyprwm/hyprland";
    };

  };
  
  # Defining flake import structure for packages
  outputs = { self, nixpkgs, ... } @ attrs: { 
    
    # Hyprland Desktop - 3 monitors 
    nixosConfigurations.hodgepodge = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        username = "ekan";
        hostname = "hodgepodge";
        displayConfig = "desktop";
        nvidia_bool = "enabled";
      } // attrs;        
      modules = [
            ./.
            ./modules/toys
            ./modules/virt
          ];
    };#hodgepodge
  };
}
