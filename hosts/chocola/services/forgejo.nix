{ ... }:
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
      service.DISABLE_REGISTRATION = false;
    };
  };
}
