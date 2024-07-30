{
  lib,
  stdenv,
  fetchFromGitHub,
  pack ? 1,
  theme ? "colorful_loop",
  ...
}:
stdenv.mkDerivation rec {
  pname = "plymouth-themes";
  version = "1.0.0";

  strictDeps = true;

  src = fetchFromGitHub {
    owner = "adi1090x";
    repo = "plymouth-themes";
    rev = "5d8817458d764bff4ff9daae94cf1bbaabf16ede";
    sha256 = "sha256-sYQTI0AYskTusDUO6R8x0edZIOIpEPifX+Z5MXoOTkQ=";
  };

  configurePhase = ''
    runHook preConfigure
    mkdir -p $out/share/plymouth/themes
    runHook postConfigure
  '';

  installPhase = ''
    runHook preInstall
    cp -r ./pack_${toString pack}/${theme} $out/share/plymouth/themes
    sed -i 's;/usr/share;${placeholder "out"}/share;g' \
      $out/share/plymouth/themes/${theme}/${theme}.plymouth
    runHook postInstall
  '';

  meta = {
    description = "A collection of plymouth themes ported from Android.";
    inherit (src.meta) homepage;
    license = lib.licenses.gpl3;
    platforms = lib.platforms.linux;
  };
}
