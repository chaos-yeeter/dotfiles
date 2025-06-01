{
  description = "system configuration";

  inputs = {
    # ref: https://nixos-and-flakes.thiscute.world/nixos-with-flakes/downgrade-or-upgrade-packages
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # TODO: remove this after zen browser is added to nixpkgs
    # ref: https://github.com/0xc000022070/zen-browser-flake?tab=readme-ov-file#installation
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
  };

  outputs = {
    nixpkgs-unstable,
    zen-browser,
    ...
  } @ inputs: let
    lib = nixpkgs-unstable.lib;
    system = "x86_64-linux";
  in {
    nixosConfigurations = {
      frankenstein = lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs;

          pkgs-unstable = import nixpkgs-unstable {
            inherit system;
            config.allowUnfree = true;
          };

          pkgs-zen-browser = import zen-browser {inherit system;};
        };

        modules = [./configuration.nix];
      };
    };
  };
}
