{ stdenv, fetchFromGitHub, fetchFromGitLab }:
stdenv.mkDerivation rec {
  pname = "sddm-eucalyptus-drop";
  version = "0b82ca46";
  dontBuild = true;
  configOverride = builtins.readFile ./sddm-theme.conf;
  installPhase = ''
    mkdir -p $out/share/sddm/themes/eucalyptus-drop
    echo "${configOverride}" > $out/share/sddm/themes/eucalyptus-drop/theme.conf
    mkdir -p $out/share/sddm/themes/eucalyptus-drop/Backgrounds
    cp -R $wallpapers/* $out/share/sddm/themes/eucalyptus-drop/Backgrounds
    cp -Rn $src/* $out/share/sddm/themes/eucalyptus-drop
  '';
  src = fetchFromGitLab {
    owner = "Matt.Jolly";
    repo = "sddm-eucalyptus-drop";
    rev = "0b82ca465b7dac6d7ff15ebaf1b2f26daba5d126";
    sha256 = "SUOqcK7fGb5OnWmB4Wenqr9PPiagYUoEHjLd5CM6fyk=";
  };
  wallpapers = fetchFromGitHub {
    owner = "christopherlam888";
    repo = "wallpapers";
    rev = "c9a99decfea53f33ed68784ac8cd512032bfec49";
    sha256 = "ndqQ7dNbQamnH7t5B2MXvsTTaOgIpAIaurNXj+BirG4=";
  };
}
