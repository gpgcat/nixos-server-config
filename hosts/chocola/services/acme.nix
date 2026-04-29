{ config, ... }:
{
  security.acme = {
    acceptTerms = true;
    defaults = {
      email = "gpgcat@proton.me";
      dnsProvider = "porkbun";
      credentialFiles = {
        PORKBUN_API_KEY_FILE = config.sops.secrets.porkbun_api_key.path;
        PORKBUN_SECRET_API_KEY_FILE = config.sops.secrets.porkbun_secret_key.path;
      };
    };
  };
}
