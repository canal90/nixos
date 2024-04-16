let
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-23.11";
  pkgs = import nixpkgs { config = {}; overlays = []; };
in
{
  stereo_tool_gui_jack_64 = pkgs.callPackage ./stereo_tool_gui_jack_64.nix {};
}
