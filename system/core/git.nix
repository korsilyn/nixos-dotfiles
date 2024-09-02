{...}: {
  programs.git = {
    enable = true;
    lfs.enable = true;
    config = {
      user = {
        name = "Eugene Gladkov";
        email = "jenya.love72@gmail.com";
      };
      init = {
        defaultBranch = "main";
      };
      branch.autosetupmerge = "true";
      push.default = "current";
      merge.stat = "true";
      core.whitespace = "fix,-indent-with-non-tab,trailing-space,ct-at-eol";
      repack.usedeltabaseoffset = "true";
      pull.ff = "only";
      rebase = {
        autoSquash = "true";
        autoStash = "true";
      };
      rerere = {
        enabled = true;
        autoupdate = true;
      };
    };
  };
}
