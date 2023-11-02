{ homebrew, ...}: {
  homebrew.enable = true;
  homebrew.brewPrefix = "/opt/homebrew/bin";

  homebrew.brews = [];
  homebrew.casks = [];
  homebrew.masApps = {};

  homebrew.extraConfig = ''
    brew "postgresql@12", restart_service: true, link: true
    brew "redis", restart_service: true, link: true
  '';
}

