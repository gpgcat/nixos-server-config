{ lib, inputs, pkgs, ... }:
{
  nix = {
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;
    
    settings = {
      auto-optimise-store = true;
      trusted-users = [ "root" "@wheel" ];
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };
  
  nixpkgs.config.allowUnfree = true;

  networking.firewall = {
    allowedTCPPorts = [ 22 80 ];
    allowedUDPPorts = [ 53 ];
  };

  time.timeZone = "Europe/Moscow";
  i18n.defaultLocale = "en_US.UTF-8";
  security.sudo.wheelNeedsPassword = false;

  environment.systemPackages = with pkgs; [
    git
    helix
    wget
    pciutils
    dnsutils
    tmux
  ];

  users.users.madeline = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILR5/w+gVjwspJzU5qMRDqU4fGyH8iatsfYLgfoBm3Ix"
    ];
  };

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
    };
  };

  system.stateVersion = "26.05";
}
