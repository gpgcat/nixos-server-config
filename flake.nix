{
  description = "madeline's server nixos config :3";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    
    deploy-rs = {
      url = "github:serokell/deploy-rs";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      deploy-rs,
      disko,
      ...
    }@inputs:
    {
      nixosConfigurations =
        let
          mkNixosSystem =
            name: domain: modules:
            nixpkgs.lib.nixosSystem {
              system = "x86_64-linux";
              specialArgs = { inherit inputs; };
              modules = [
                (
                  { ... }:
                  {
                    networking = {
                      hostName = name;
                      domain = domain;
                    };
                  }
                )

                ./hosts
              ] ++ modules;
            };
        in
        {
          chocola = mkNixosSystem "chocola" "gpg.pet" [
            ./hosts/chocola

            disko.nixosModules.disko
          ];
        };

      deploy =
        let
          mkNixosDeploy =
            name:
            {
              hostname =
                let cfg = self.nixosConfigurations.${name}.config.networking;
                in "${cfg.hostName}.${cfg.domain}";
              profiles.system.path = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.${name};
            };
        in
        {
          sshUser = "madeline";
          user = "root";
          remoteBuild = true;

          nodes.chocola = mkNixosDeploy "chocola";
        };

      checks = builtins.mapAttrs (system: deployLib: deployLib.deployChecks self.deploy) deploy-rs.lib;
    };
}
