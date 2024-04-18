{config, pkgs, userSettings, ...}: {

  home.username = userSettings.username;
  home.homeDirectory = "/home/${userSettings.username}";

  programs.git = {
    enable = true;
    userName = userSettings.name;
    userEmail = userSettings.email;
  };

  home.packages = with pkgs; [
    neofetch
  ];

  home.file."stereo_tool.qpwgraph".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.homeDirectory}/nixos/dotfiles/stereo_tool.qpwgraph";
  home.file.".buttrc".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.homeDirectory}/nixos/dotfiles/.buttrc";



  home.stateVersion = "23.11";

  programs.home-manager.enable = true;
}
