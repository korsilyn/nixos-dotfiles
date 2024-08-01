{
  callPackage,
  clang-tools,
  gnumake,
  cmake,
  bear,
  libcxx,
  cppcheck,
  llvm,
  gdb,
}: let
  mainPkg = callPackage ./default.nix {};
in
  mainPkg.overrideAttrs (oa: {
    nativeBuildInputs =
      [
        clang-tools # fix headers not found
        gnumake # builder
        cmake # another builder
        bear # bear.
        libcxx # stdlib for cpp
        cppcheck # static analysis
        llvm.lldb # debugger
        gdb # another debugger
        llvm.libstdcxxClang # LSP and compiler
        llvm.libcxx # stdlib for C++
      ]
      ++ (oa.nativeBuildInputs or []);
  })
