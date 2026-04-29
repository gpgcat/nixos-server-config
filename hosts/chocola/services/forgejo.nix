{ config, ... }:
{
  services.forgejo = {
    enable = true;
    database.type = "postgres";
    settings = {
      server = {
        DOMAIN = "git.gpg.pet";
        ROOT_URL = "https://git.gpg.pet/";
        HTTP_PORT = 3000;
        SSH_PORT = 1234;
      };
      service.DISABLE_REGISTRATION = true;
      ui = {
        DEFAULT_THEME = "committed-violet";
        THEMES = "committed-violet,terminal,forgejo-auto,forgejo-light,forgejo-dark";
      };
    };
  };

  systemd.tmpfiles.rules = [
    "d '${config.services.forgejo.customDir}/public' 0755 forgejo forgejo - -"
    "d '${config.services.forgejo.customDir}/public/assets' 0755 forgejo forgejo - -"
    "d '${config.services.forgejo.customDir}/public/assets/css' 0755 forgejo forgejo - -"
    "C+ '${config.services.forgejo.customDir}/public/assets/css/theme-committed-violet.css' 0644 forgejo forgejo - ${../static/forgejo-committed-violet.css}" # https://sc.cryxtal.org/crystal/committed-violet
    "C+ '${config.services.forgejo.customDir}/public/assets/css/theme-terminal.css' 0644 forgejo forgejo - ${../static/forgejo-terminal.css}" # https://codeberg.org/ivanhercaz/forgejo-terminal-theme
  ];
}
