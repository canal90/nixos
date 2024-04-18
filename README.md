# Installation instructions

## Filesystem setup
....


# Boot up
```
nix-shell -p git
git clone https://github.com/canal90/nixos
cd nixos
sudo nixos-rebuild switch --flake .#audioproc1
```
