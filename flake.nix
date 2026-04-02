{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    deploy-rs.url = "github:serokell/deploy-rs";
  };

  outputs =
    {
      self,
      nixpkgs,
      deploy-rs,
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

      deploy = {
        sshUser = "madeline";
        user = "root";
        sudo = "sudo -u";
        remoteBuild = true;

        nodes.madoka = with self.nixosConfigurations; {
          hostname = with madoka.config.networking; "${hostName}.${domain}";
          profiles.system.path = deploy-rs.lib.x86_64-linux.activate.nixos madoka;
        };
      };

      checks = builtins.mapAttrs (system: deployLib: deployLib.deployChecks self.deploy) deploy-rs.lib;
    };
}
