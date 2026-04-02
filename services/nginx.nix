{ ... }:
{
  services.nginx.enable = true;
  services.nginx.virtualHosts."gpg.pet" = {
    forceSSL = true;
    enableACME = true;

    locations."~ ^/git/(.+)$" = {
      extraConfig = ''
        rewrite ^/git/(.+)$ https://github.com/gpgcat/$1 redirect;
      '';
    };
  };
}
