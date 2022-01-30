{ pkgs ? import <nixpkgs> {} }:
let
  openapi-generator-cli-jar = pkgs.fetchurl {
    url = https://repo1.maven.org/maven2/org/openapitools/openapi-generator-cli/5.3.1/openapi-generator-cli-5.3.1.jar;
    sha256 = "sha256-gdwbP7EQK0O+zS9GCYz9hh6cToT767U0rWfXxrDu/3c=";
  };
  groovy = pkgs.groovy.override {
    jdk = pkgs.openjdk8;
  };
in
  pkgs.stdenv.mkDerivation {
    name = "openapi-generator-cli";
    nativeBuildInputs = [ pkgs.makeWrapper ];
    src = ./.;
    buildPhase = "true";
    installPhase = ''
    mkdir -p $out/bin
    cp MyCodegen.groovy $out/
    makeWrapper ${groovy}/bin/groovy $out/bin/openapi-generator-cli \
      --add-flags "-cp ${openapi-generator-cli-jar} $out/MyCodegen.groovy"
    '';
  }
