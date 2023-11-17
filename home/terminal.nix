{ pkgs, lib, ... }:

# Platform-independent terminal setup
{
  home.packages = with pkgs; [
    # Unixy tools
    ripgrep
    fd
    sd
    comma

    # Publishing
    asciinema
    # dev
    devbox
    virt-manager
    byobu
    lens
  ];

  home.shellAliases = rec {
    e = "nvim";
    g = "git";
    lg = "lazygit";
    #l = lib.getExe pkgs.lsd;
    #t = tree;
    #tree = "${lib.getExe pkgs.lsd} --tree";
  };

  programs = {
    bat.enable = true;
    autojump.enable = false;
    zoxide.enable = true;
    fzf.enable = true;
    jq.enable = true;
    nix-index.enable = true;
    htop.enable = true;
    # rio.enable = true;
  };
}
