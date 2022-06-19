{
  config,
  lib,
  pkgs,
  hmUsers,
  primaryUser,
  profiles,
  suites,
  ...
}: {
  imports =
    (with suites; tangible ++ workstation)
    ++ (with profiles; [
      hidpi
      office
      #nvidia
    ])
    ++ [
      ./hardware-configuration.nix
    ];

  # Use systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Disable deprecated systemd wide useDHCP
  networking.useDHCP = false;

  services.printing.enable = true;

  users.mutableUsers = false;
  users.users.ekan = {
    isNormalUser = true;
    uid = 1000;
    initialHashedPassword = "$6$1zvEALSSA1d.QjQG$86jzLyuUWN/mluagHMH2xgC/mbuJt.rEcbzxkgT/0OnWYecRIkDo5iGd8WvK0SqR1qG1kyPkF9C1XnjkLldxN0";
    hashedPassword = "$6$1zvEALSSA1d.QjQG$86jzLyuUWN/mluagHMH2xgC/mbuJt.rEcbzxkgT/0OnWYecRIkDo5iGd8WvK0SqR1qG1kyPkF9C1XnjkLldxN0";
    extraGroups = [
      "wheel"
      "secrets"
      "video"
      "networkmanager"
    ];
    openssh.authorizedKeys.keys = primaryUser.authorizedKeys;
    shell = pkgs.zsh;
  };

  home-manager.users.ekan = hmArgs: {
    imports =
      [hmUsers.ekan]
      ++ (with hmArgs.suites; workstation);
  };

  programs.htop.enable = true;

  networking.firewall.enable = false;
  system.stateVersion = "22.05";
  nixpkgs.config.allowUnfree = true;
}
