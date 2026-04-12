{ ... }:
{
  security.acme = {
    acceptTerms = true;
    defaults.email = "madeline@gpg.pet";
    defaults.server = "https://acme-v02.api.letsencrypt.org/directory";
  };
}
