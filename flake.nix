{

  description = "Canal 90 NixOS Systems";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager }@inputs:
  let
    systemSettings = {
      system = "x86_64-linux";
      hostname = "audioproc1";
    };

    userSettings = { 
      username = "canal90";
      homeDirectory = "/home/${userSettings.username}"; 
    };

    specialArgs = inputs // { inherit systemSettings; inherit userSettings; };
  in
  {
    nixosConfigurations = {
      audioproc1 = nixpkgs.lib.nixosSystem {
        specialArgs = specialArgs;
        system = systemSettings.system;
        modules = [ 
          ./hosts/${systemSettings.hostname}/configuration.nix
          ./nixosModules

          home-manager.nixosModules.home-manager {
            home-manager = {
              extraSpecialArgs = specialArgs;
              useGlobalPkgs = true;
              useUserPackages = true;
              users.${userSettings.username} = import ./homeManagerModules/home.nix;
            };
          }
        ];
      };
    };
  };
}
