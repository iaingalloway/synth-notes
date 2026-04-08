{
  description = "working-notes dev environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      devShells.${system}.default = pkgs.mkShell {
        packages = [
          pkgs.just
          pkgs.findutils
          pkgs.gnugrep
          pkgs.coreutils
          pkgs.vale
          pkgs.markdownlint-cli2
        ];
      };
    };
}
