final: prev: {
  roslyn-ls = prev.roslyn-ls.overrideAttrs (old: rec {
    vsVersion = "2.23.2";
    src = prev.fetchFromGitHub
      {
        owner = "dotnet";
        repo = "roslyn";
        rev = "VSCode-CSharp-${vsVersion}";
        sha256 = "sha256-j7PXgYjISlPBbhUEEIxkDlOx7TMYPHtC3KH2DViWxJ8=";
      };
  });
}
