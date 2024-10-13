{
    description = "my cool flake!";

    inputs = {
        nixpkgs.url = "nixpkgs/nixos-24.05";

        # ref: https://nixos-and-flakes.thiscute.world/nixos-with-flakes/downgrade-or-upgrade-packages
        nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    };

    outputs = { self, nixpkgs, nixpkgs-unstable, ... }:
    let
        lib = nixpkgs.lib;
        system = "x86_64-linux";
    in {
        nixosConfigurations = {
            frankenstein = lib.nixosSystem {
                inherit system;
                specialArgs = {
                    pkgs-unstable = import nixpkgs-unstable {
                        inherit system;
                        config.allowUnfree = true;
                    };
                };

                modules = [ ./configuration.nix ];
            };
        };
    };
}
