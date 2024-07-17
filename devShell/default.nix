{
  shellCommands = [
    {
      help = "Rebuild the system via nh os switch";
      name = "sw";
      command = "nh os switch";
      category = "build";
    }
    {
      help = "Rebuild the system via nh os boot";
      name = "boot";
      command = "nh os boot";
      category = "build";
    }
    {
      help = "Format the source tree with treefmt";
      name = "fmt";
      command = "treefmt";
      category = "formatter";
    }
    {
      help = "Format nix files with alejandra";
      name = "alejandra";
      command = "alejandra";
      category = "formatter";
    }
    {
      help = "Pull changes from origin";
      name = "pull";
      command = "git pull";
      category = "source control";
    }
    {
      help = "Format source tree and push commited changes to origin";
      name = "push";
      command = "git push";
      category = "source control";
    }
    {
      help = "Update flake.lock and commit changes";
      name = "update";
      command = ''nix flake update && git commit flake.lock -m "flake: bump inputs"'';
      category = "utils";
    }
  ];

  shellEnv = [
    {
      # stop direnv spam
      name = "DIRENV_LOG_FORMAT";
      value = "";
    }
  ];
}
