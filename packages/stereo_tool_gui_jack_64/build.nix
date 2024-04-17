{config, pkgs, lib, ...}:
{
  nixpkgs.overlays = [
    (self: super: {
      stereo_tool_gui_jack_64 = pkgs.callPackage ./stereo_tool_gui_jack_64.nix {};
    })
  ];
}
