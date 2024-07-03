{
    description = "my cool flake!";

    inputs = {
        nixpkgs.url = "nixpkgs/nixos-24.05";

        # ref: https://nixos-and-flakes.thiscute.world/nixos-with-flakes/downgrade-or-upgrade-packages
        nixpkgs-a3c8d6.url = "github:nixos/nixpkgs/a3c8d64ba846725f040582b2d3b875466d2115bd";
    };

    outputs = { self, nixpkgs, nixpkgs-a3c8d6, ... }:
    let
        lib = nixpkgs.lib;
        system = "x86_64-linux";
    in {
        nixosConfigurations = {
            frankenstein = lib.nixosSystem {
                inherit system;
                specialArgs = {
                    pkgs-a3c8d6 = import nixpkgs-a3c8d6 {
                        inherit system;
                        config.allowUnfree = true;
                    };
                };

                modules = [ ./configuration.nix ];
            };
        };
    };
}
