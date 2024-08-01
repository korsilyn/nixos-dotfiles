let
  # Users
  users = {
    korsilyn = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHRIUG+mNwg1MKLfPdje6a3hv0q9lbL4tnCqxOZvv2SH";
  };
in {
  inherit (users) korsilyn;
}
