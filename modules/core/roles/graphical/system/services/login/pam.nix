{
  # unlock GPG keyring on login
  security.pam.services = let
    gnupg = {
      enable = true;
      noAutostart = true;
      storeOnly = true;
    };
  in {
    login = {
      enableGnomeKeyring = true;
      inherit gnupg;
    };
  };
}
