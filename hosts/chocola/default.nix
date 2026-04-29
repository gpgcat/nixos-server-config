{ ... }:
{
  imports = [
    ./disko.nix
    ./hardware-configuration.nix

    ./services/forgejo.nix
    ./services/nginx.nix
    ./services/acme.nix
    ./services/vaultwarden.nix
  ];
  
  boot.loader.grub.enable = true;

  sops = {
    defaultSopsFile = ../../secrets/chocola.yaml;
    age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
    secrets = {
      porkbun_api_key = {};
      porkbun_secret_key = {};
    };
  };

  networking.firewall = {
    allowedTCPPorts = [ 22 80 443 1234 ];
    allowedUDPPorts = [ 53 ];
  };
  
  networking = {
    useDHCP = false;
    interfaces.ens18 = {
      ipv4.addresses = [{
        address = "157.173.16.143";
        prefixLength = 24;
      }];
    };
    defaultGateway = "157.173.16.1";
    nameservers = [ "8.8.8.8" "1.1.1.1" ];
  };
}
