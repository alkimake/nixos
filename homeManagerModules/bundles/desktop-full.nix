{
  pkgs,
  lib,
  ...
}: {
  myHomeManager.bundles.desktop.enable = lib.mkDefault true;
  home.packages = with pkgs; [
  ];
}

