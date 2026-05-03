# my NixOS server config!!
maybe someday i'll buy a dedicated one...
## services
- [gpg.pet](https://gpg.pet) running my personal website
- [git.gpg.pet](https://git.gpg.pet/gpgcat) running forgejo with catppuccin theme
- [vault.gpg.pet](https://vault.gpg.pet) running vaultwarden
## install
```
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko hosts/[host]/disko.nix
sudo nixos-rebuild switch --flake .#[host]
```
## deploy
```
nix run github:serokell/deploy-rs
```
