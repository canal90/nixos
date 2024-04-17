{

  description = "Canal 90 NixOS Systems";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    #nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }@inputs: 
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
        ];
      };
    };
  };
}
