{
  config = {
    boot.kernelParams = [
      "i915.enable_fbc=1"
      "i915.enable_psr=2"
    ];

    system.stateVersion = "24.05";
  };
}
