{pkgs}: let
  image = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/siddrs/tokyo-night-sddm/main/Backgrounds/shacks.png";
    sha256 = "sha256-lWwBcbczNkThAHPze1juJJ1LAI8lUoMNqbm99rD+K0k=";
  };
in
  pkgs.stdenv.mkDerivation {
    name = "sddm-theme";

    src = pkgs.fetchFromGitHub {
      owner = "siddrs";
      repo = "tokyo-night-sddm";
      rev = "320c8e74ade1e94f640708eee0b9a75a395697c6";
      sha256 = "JRVVzyefqR2L3UrEK2iWyhUKfPMUNUnfRZmwdz05wL0=";
    };
    installPhase = ''
      mkdir -p $out
      cp -R ./* $out/
      cd $out/
      rm Backgrounds/win11.png
      cp -r ${image} $out/Backgrounds/win11.png
    '';
  }

