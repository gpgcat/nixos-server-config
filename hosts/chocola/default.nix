{ ... }:
{
  imports = [
    ./disko.nix
    ./hardware-configuration.nix
  ];
  
  boot.loader.grub.enable = true;
  
  networking = {
    useDHCP = false;
    interfaces.enp0s18 = {
      ipv4.addresses = [{
        address = "157.173.16.143";
        prefixLength = 24;
      }];
    };
    defaultGateway = "157.173.16.1";
    nameservers = [ "8.8.8.8" "1.1.1.1" ];
  };
}
