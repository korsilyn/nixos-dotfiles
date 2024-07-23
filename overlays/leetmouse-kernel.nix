{ stdenv, lib, fetchFromGitHub, kernel, kmod }:

stdenv.mkDerivation rec {
  name = "leetmouse-${version}-${kernel.version}";
  version = "0.10.1";

  src = fetchFromGitHub {
    owner = "korsilyn";
    repo = "leetmouse";
    rev = "a5b202765d18a28ec02eb9379d8f2ec983516937";
    sha256 = "";
  };

  sourceRoot = "source/driver";
  hardeningDisable = [ "pic" "format" ];
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
    maintainers = [ maintainers.makefu ];
    platforms = platforms.linux;
  };
}
