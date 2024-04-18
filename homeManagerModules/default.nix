{ inputs, ...}: {
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    useGlobalPkgs = true;
    useUserPackages = true;
    users = {
      "canal90" = import ./home.nix;
    };
  };
}
