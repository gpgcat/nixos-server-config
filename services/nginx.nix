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

  services.nginx.virtualHosts."fedi.gpg.pet" = {
    forceSSL = true;
    enableACME = true;
    locations."/" = {
      proxyPass = "http://127.0.0.1:3000";
      proxyWebsockets = true;
    };
  };
}
