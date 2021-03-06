{
  self,
  config,
  lib,
  pkgs,
  ...
}: {
  nix = {
    autoOptimiseStore = true;
    nixPath = ["nixos-config=${../../lib/compat/nixos}"];
    optimise.automatic = true;
    systemFeatures = ["nixos-test" "benchmark" "big-parallel" "kvm"];
  };

  boot.loader.systemd-boot.consoleMode = "auto";

  environment.shellAliases = {
    # Fix `nixos-option` for flake compatibility
    nixos-option = "nixos-option -I nixpkgs=${self}/lib/compat";
  };

  environment.systemPackages = with pkgs; [
    dosfstools
    efibootmgr
    gptfdisk
    inetutils
    iputils
    mtr
    pciutils
    sysstat
    usbutils
    utillinux
  ];

  users.groups.secrets.members = ["root" "seadoom" "xtallos"];

  services.openssh = {
    # For rage encryption, all hosts need a ssh key pair
    enable = lib.mkForce true;

    openFirewall = true;
    passwordAuthentication = false;
    permitRootLogin = "prohibit-password";
  };
}
