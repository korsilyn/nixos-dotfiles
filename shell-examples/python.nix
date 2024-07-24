let
  pkgs = import <nixpkgs> {};
  python = pkgs.python312;
  pythonPackages = python.withPackages (pythonPkgs: with pythonPkgs; [
    pip
    setuptools
    wheel
  ]);
in with pkgs; mkShell {
  buildInputs = [
    pythonPackages
  ];

  shellHook = ''
    VENV=venv
    SOURCE_DATE_EPOCH=$(date +%s)

    if test ! -d $VENV; then
      python -m venv $VENV
    fi
    source ./$VENV/bin/activate
    export PYTHONPATH=`pwd`/$VENV/${python.sitePackages}/:$PYTHONPATH
    pip install -r requirements.txt -q

    ln -sf `pwd`/../my_package `pwd`/$VENV/${python.sitePackages}/
  '';
}
