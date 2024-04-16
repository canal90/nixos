{

  description = "Canal 90 NixOS Systems";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable }@inputs: 
  let
    system = "x86_64-linux";
    specialArgs = inputs // { inherit system; };
  in
  {
    nixosConfigurations = {
      audioproc1 = nixpkgs.lib.nixosSystem {
        specialArgs = specialArgs;
        system = system;
        modules = [ 
          ./hosts/audioproc1/configuration.nix
          ./nixosModules
          #./packages
          #{ packages.${system}.stereo_tool_gui_jack_64 = nixpkgs.legacyPackages.${system}.callPackage ./packages/stereo_tool_gui_jack_64.nix {}; }
        ];
      };
    };
    packages.${system}.stereo_tool_gui_jack_64 = nixpkgs.legacyPackages.${system}.callPackage ./packages/stereo_tool_gui_jack_64.nix {};
  };

}
