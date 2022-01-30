{
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = github:NixOS/nixpkgs/master;
  };
  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
        openapi-generator-cli = import ./openapi-generator-cli { inherit pkgs; };
      in
        {
          packages = {
            inherit openapi-generator-cli;
          };
          devShell = 
            pkgs.mkShell {
              buildInputs = [
                openapi-generator-cli
              ];
            };
        }
    );
}
