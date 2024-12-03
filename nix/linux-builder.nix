{  system, ... }: {
  nix.linux-builder.enable = true;
  nix.linux-builder.maxJobs = 4;
  launchd.daemons.linux-builder = {
    serviceConfig = {
      StandardOutPath = "/var/log/darwin-builder.log";
      StandardErrorPath = "/var/log/darwin-builder.log";
    };
  };
}

