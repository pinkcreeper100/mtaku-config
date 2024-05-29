{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";

    snowfall-lib = {
      url = "github:snowfallorg/lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence.url = "github:nix-community/impermanence";

    agenix.url = "github:ryantm/agenix";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = inputs: let
    lib = inputs.snowfall-lib.mkLib {
      inherit inputs;
      src = ./.;
      snowfall.namespace = "capybara";

      outputs-builder = channels: {
        formatter = channels.nixpkgs.alejandra;
      };
    };
  in lib.mkFlake {
    channels-config = {
      allowUnfree = true;
    };

    systems.modules.nixos = with inputs; [
      impermanence.nixosModules.impermanence
      agenix.nixosModules.default
    ];
  };
}
