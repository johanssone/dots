{pkgs, ...}:
{
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
      ms-python.python
      ms-azuretools.vscode-docker
      ms-vscode-remote.remote-ssh
      github.copilot
      ms-vscode-remote.remote-containers      
    ];
    userSettings = {
      "files.autoSave" = "off";
      "[nix]"."editor.tabSize" = 2;
      "terminal.integrated.defaultProfile.linux" = "zsh";
    };
  };
}
