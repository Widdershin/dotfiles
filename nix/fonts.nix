{ pkgs, ... }:
{
  fonts.fontDir.enable = true;
  fonts.fonts = [ pkgs.hack-font ];
}

