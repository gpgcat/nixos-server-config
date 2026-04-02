{ config, lib, pkgs, ... }:

{
  imports =
    [
    ];

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";

  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
      trusted-users = [
        "root"
        "@wheel"
      ];
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };

  networking = {
    networkmanager.enable = true;
    firewall.allowedTCPPorts = [ 22 ];
  };

  time.timeZone = "Europe/Amsterdam";

  users.users.madeline = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILR5/w+gVjwspJzU5qMRDqU4fGyH8iatsfYLgfoBm3Ix angel@qualia"
    ];
  };

  environment.systemPackages = with pkgs; [
    neovim
    curl
    wget
    htop
    git
  ];

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
    };
  };

  security.sudo.wheelNeedsPassword = false;
  system.stateVersion = "26.05";
}
