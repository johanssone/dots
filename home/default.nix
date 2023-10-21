{ self, ... }:
{
  flake = {
    homeModules = {
      common = {
        home.stateVersion = "23.05";
        imports = [
          ./tmux.nix
          ./zsh.nix
          #./neovim.nix
          ./starship.nix
          ./terminal.nix
          ./git.nix
          ./direnv.nix
          #./zellij.nix
          #./kitty
          #./nushell.nix
          #./just.nix
          # ./powershell.nix
        ];
      };
      common-linux = {
        imports = [
          self.homeModules.common
          ./bash.nix
          #./vscode-server.nix
        ];
      };
      common-darwin = {
        imports = [
          self.homeModules.common
          ./zsh.nix
          ./bash.nix
          ./kitty.nix
          ./emacs.nix
        ];
      };
    };
  };
}
