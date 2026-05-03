{ inputs, ... }:
{
  services.nginx.virtualHosts."gpg.pet" = {
    enableACME = true;
    forceSSL = true;
    root = "${inputs.gpg-pet.packages.x86_64-linux.default}";
    locations."/" = {
      tryFiles = "$uri $uri/ $uri.html =404";
    };
  };
}
