{ pkgs, home-manager, username, ... }:
{
  imports = [ 
    ./1password
    ./browser
    ./vscode
  ];
  home-manager.users.${username} = { pkgs, ... }: {
    home.packages = with pkgs; [
      obsidian
      discord
     ];
  };
}