# Installation instructions

Download and use the [nixOS minimal ISO image](https://nixos.org/download/#nixos-iso) and create a USB boot disk for the installation.
Boot the installation media and execute the following:

```
cd /tmp
nix-shell -p git
git clone https://github.com/canal90/nixos
exit
cd nixos/
sudo nix run 'github:nix-community/disko#disko-install' --experimental-features 'nix-command flakes' -- --write-efi-boot-entries --flake '/tmp/nixos#audioproc1' --disk nvme0n1 /dev/nvme0n1
sudo reboot
```
