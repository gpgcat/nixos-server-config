{ config, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot.loader.grub = {
    enable = true;
    device = "/dev/sda";
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
