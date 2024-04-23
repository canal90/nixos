# Installation instructions

Download and use the [nixOS minimal ISO image](https://nixos.org/download/#nixos-iso) and create a USB boot disk for the installation.
Boot the installation media and execute the following:

```
nix-shell -p git
cd /tmp
git clone https://github.com/canal90/nixos
cd nixos/
sudo nix run 'github:nix-community/disko#disko-install' --experimental-features 'nix-command flakes' -- --write-efi-boot-entries --flake '/tmp/nixos#audioproc1' --disk nvme0n1 /dev/nvme0n1
sudo reboot
```
