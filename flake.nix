{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs =
    {
      self,
      nixpkgs,
      ...
    }@inputs:
    {
      nixosConfigurations = {
        madoka = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            ./system
            ./system/madoka

            ./services

            (
              { ... }:
              {
                networking = {
                  hostName = "madoka";
                  domain = "gpg.pet";
                };
              }
            )
          ];
        };
      };
    };
}
