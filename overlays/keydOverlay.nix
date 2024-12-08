final: prev: {
  keyd = prev.keyd.overrideAttrs (old: rec {
    version = "2.5.0";
    src = prev.fetchFromGitHub {
      owner = "rvaiya";
      repo = "keyd";
      rev = "v" + version;
      hash = "sha256-pylfQjTnXiSzKPRJh9Jli1hhin/MIGIkZxLKxqlReVo=";
    };

    postPatch = ''
      substituteInPlace Makefile \
        --replace /usr ""
    '';

    postInstall = ''
      rm -rf $out/etc
      mv $out/local/* $out/
      rm -rf $out/local
    '';

  });
}
