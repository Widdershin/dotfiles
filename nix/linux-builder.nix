{  system, ... }: {
  nix.linux-builder.enable = true;
  nix.linux-builder.maxJobs = 4;
}
