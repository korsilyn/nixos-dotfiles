{
  stdenv,
  lib,
  fetchFromGitHub,
  kernel,
  kmod,
}:
stdenv.mkDerivation rec {
  name = "leetmouse-${version}-${kernel.version}";
  version = "0.10.1";

  src = fetchFromGitHub {
    owner = "korsilyn";
    repo = "leetmouse";
    rev = "2163cd3bdb68d7b3a5ccede45337ceef499731be";
    sha256 = "sha256-iITiTVe6RP2NN/FQj7WG1/iSG0jI+kS6c4H4zYEoj+w=";
  };

  sourceRoot = "source/driver";
  hardeningDisable = ["pic" "format"];
  nativeBuildInputs = kernel.moduleBuildDependencies;

  makeFlags = [
    "KERNELRELEASE=${kernel.modDirVersion}"
    "KERNEL_DIR=${kernel.dev}/lib/modules/${kernel.modDirVersion}/build"
    "INSTALL_MOD_PATH=$(out)"
  ];

  meta = with lib; {
    description = "A fork of fork of fork of kernel mouse driver with acceleration";
    homepage = "https://github.com/korsilyn/leetmouse";
    license = licenses.gpl2;
    maintainers = [maintainers.makefu];
    platforms = platforms.linux;
  };
}
