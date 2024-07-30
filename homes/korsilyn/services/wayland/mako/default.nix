_: {
  services.mako = {
    enable = true;

    backgroundColor = "#1e1e2e";
    textColor = "#cdd6f4";
    borderColor = "#cba6f7";
    progressColor = "over #313244"
    defaultTimeout = 5000;
    ignoreTimeout = true;
    borderSize = 1;
    borderRadius = 5;
    font = "sans-serif 10";

    extraConfig = ''
      [urgency=high]
      border-color=#fab387
    '';
  };
}
