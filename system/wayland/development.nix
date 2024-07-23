{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    python
    gcc
  ];
}
