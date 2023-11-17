# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.efi.canTouchEfiVariables = true;
  # Configuring Nvidia PRIME
  hardware.nvidia.nvidiaSettings = true;
  services.xserver.videoDrivers = ["nvidia"];
  hardware.opengl.enable = true;
  hardware.nvidia.modesetting.enable = true;
  #hardware.nvidia.prime = {
  # offload.enable = true;
  #};  
  hardware.opengl.driSupport32Bit = true;
  #hardware.nvidia.powerManagement.enable = true;
  
  # Optionally, you may need to select the appropriate driver version for your specific GPU.
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;

  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  # Enable swap on luks
  boot.initrd.luks.devices."luks-2190de5b-e347-4475-9f94-4f1d0e3f5d89".device = "/dev/disk/by-uuid/2190de5b-e347-4475-9f94-4f1d0e3f5d89";
  boot.initrd.luks.devices."luks-2190de5b-e347-4475-9f94-4f1d0e3f5d89".keyFile = "/crypto_keyfile.bin";
  
  networking.hostName = "hodgepodge"; # Define your hostname.
  networking.nameservers = [ "1.1.1.1" "9.9.9.9" ];
  networking.extraHosts = "91.106.199.3 kna1-ipa-server01.id.ekan.dev";
  #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  #virtualisation.libvirtd.enable = true;
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  systemd.services.NetworkManager-wait-online.enable = false;
  # Set your time zone.

  # Enable the X11 windowing system.
  #services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  #services.xserver.displayManager.gdm.enable = true;
  #services.xserver.desktopManager.gnome.enable = true;

  # Enable CUPS to print documents.
  #services.printing.enable = true;

  # Enable sound with pipewire.
  #sound.enable = true;
  #hardware.pulseaudio.enable = false;
  #security.rtkit.enable = true;
  #services.pipewire = {
  #  enable = true;
  #  alsa.enable = true;
  #  alsa.support32Bit = true;
  #  pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  #};

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  #users.users.ekan = {
  #  isNormalUser = true;
  #  description = "Erik Johansson";
  #  extraGroups = [ "networkmanager" "wheel" ];
  #  packages = with pkgs; [
  #    firefox
  #    gcc-unwrapped
  #  #  thunderbird
  #  ];
  #};

  #hardware.bluetooth.enable = true; # enables support for Bluetooth
  #hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot

  # Allow unfree packages
  #nixpkgs.config.allowUnfree = true;

  ## List packages installed in system profile. To search, run:
  ## $ nix search wget
  #environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
  #  git
  #  direnv
  #  helix
  #  #(vscode-with-extensions.override {
  #  #  vscodeExtensions = with vscode-extensions; [
  #  #    bbenoist.nix
  #  #    ms-python.python
  #  #    ms-azuretools.vscode-docker
  #  #    ms-vscode-remote.remote-ssh
  #  #    github.copilot
  #  #    ms-vscode-remote.remote-containers
  #  #  ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
  #  #    {
  #  #      name = "remote-ssh-edit";
  #  #      publisher = "ms-vscode-remote";
  #  #      version = "0.47.2";
  #  #      sha256 = "1hp6gjh4xp2m1xlm1jsdzxw9d8frkiidhph6nvl24d0h8z34w49g";
  #  #    }
  #  #  ];
  #  #})
  #];

  system.stateVersion = "23.05"; # Did you read the comment?
}
