{ pkgs, ... }:

{
  services.tailscale.enable = true;
  services.tailscale.package = pkgs.tailscale;

  environment.systemPackages = [pkgs.tailscale];
}
