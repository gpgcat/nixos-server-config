{ config, lib, ... }:
let
  version = "1.0.2";
  theme = fetchTarball {
    url = "https://github.com/catppuccin/gitea/releases/download/v${version}/catppuccin-gitea.tar.gz";
    sha256 = "sha256:02zf207swfncfsd58hfdsg0r9gyfdclgg2hyf02z4l8b3hwwp4dd";
  };
in
{
  services.forgejo = {
    enable = true;
    database.type = "postgres";
    settings = {
      server = {
        DOMAIN = "git.gpg.pet";
        ROOT_URL = "https://git.gpg.pet/";
        HTTP_PORT = 3000;
        SSH_PORT = 22;
      };
      service.DISABLE_REGISTRATION = true;
      ui = {
        DEFAULT_THEME = "catppuccin-mocha-pink";
        THEMES = builtins.concatStringsSep "," (
          map (name: lib.removePrefix "theme-" (lib.removeSuffix ".css" name))
              (builtins.attrNames (builtins.readDir theme))
        );
      };
    };
  };

  systemd.tmpfiles.rules = [
    "d '${config.services.forgejo.customDir}/public' 0755 forgejo forgejo - -"
    "d '${config.services.forgejo.customDir}/public/assets' 0755 forgejo forgejo - -"
    "d '${config.services.forgejo.customDir}/public/assets/css' 0755 forgejo forgejo - -"
  ] ++ map (file:
    "C+ '${config.services.forgejo.customDir}/public/assets/css/${file}' 0644 forgejo forgejo - ${theme}/${file}"
  ) (builtins.attrNames (builtins.readDir theme));

  services.nginx.virtualHosts."git.gpg.pet" = {
    forceSSL = true;
    enableACME = true;
    locations."/" = {
      proxyPass = "http://localhost:3000";
    };
  };
}
