{

  description = "Canal 90 NixOS Systems";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    #musnix.url = "github:musnix/musnix";
  };

  outputs = { self, nixpkgs, home-manager, disko }@inputs:
  let
    systemSettings = {
      system = "x86_64-linux";
      hostname = "audioproc1";
    };

    userSettings = { 
      username = "canal90";
      name = "Canal 90";
      homeDirectory = "/home/${userSettings.username}"; 
    };

    specialArgs = inputs // { inherit systemSettings; inherit userSettings; };
  in
  {
    nixosConfigurations = {
      ${systemSettings.hostname} = nixpkgs.lib.nixosSystem {
        specialArgs = specialArgs;
        system = systemSettings.system;
        modules = [ 
          ./hosts/${systemSettings.hostname}/configuration.nix

          disko.nixosModules.disko
          ./hosts/${systemSettings.hostname}/disk-configuration.nix

          #inputs.musnix.nixosModules.musnix

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
