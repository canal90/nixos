{config, pkgs, userSettings, ...}: {

  home.username = userSettings.username;
  home.homeDirectory = "/home/${userSettings.username}";

  home.packages = with pkgs; [
    neofetch
  ];

  home.file."stereo_tool.qpwgraph".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.homeDirectory}/nixos/dotfiles/stereo_tool.qpwgraph";
  home.file.".buttrc".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.homeDirectory}/nixos/dotfiles/.buttrc";

  # Everytime a change is made in the software, it overwrites the file and destroys the symlink, which then causes nixos rebuild to fail.
  #home.file.".stereo_tool.rc".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.homeDirectory}/nixos/dotfiles/.stereo_tool.rc";


  home.stateVersion = "23.11";

  programs.home-manager.enable = true;
}
