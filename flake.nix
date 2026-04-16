{
  description = "Cross build rsyslog for aarch64 ";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
  }: let
    crossPkgs = import nixpkgs {
      system = "x86_64-linux";
      config.allowUnfree = true;
      crossSystem = {config = "aarch64-unknown-linux-gnu";};
    };
  in {
    packages.x86_64-linux = {
      cross_rsyslog = crossPkgs.callPackage ./rsyslog.nix {};
      cross_rsyslog_sin_Gcrpyt = crossPkgs.callPackage ./rsyslog.nix {
        withGcrypt = false;
      };
      cross_Gcrypt = crossPkgs.libgcrypt;
    };
  };
}
