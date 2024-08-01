let
  # Users
  users = {
    korsilyn = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJK9f7fIESvYBJ596n8YmANLcykndoX8u4s4+DwVc38v korsilyn@alhena";
  };
in {
  inherit (users) korsilyn;
}
