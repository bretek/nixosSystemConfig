{
  description = "NixOS System Configuration with Home Manager user";

  inputs = {
    nixpkgs.url = "github:bretek/nixpkgs/libfprint-goodix5117";
    nix-colors.url = "github:Misterio77/nix-colors";
    home-manager.url = "github:nix-community/home-manager";
    nixvim.url = "github:nix-community/nixvim";
  };

  outputs = { nixpkgs, home-manager, nix-colors, nixvim, ... }: {
    nixosConfigurations = {
      nixos-laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit nix-colors; };
        modules = [
          ./nixos
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit nix-colors; };
            home-manager.users.joseph = {
              imports = [
                ./home
                nix-colors.homeManagerModules.default
                nixvim.homeManagerModules.nixvim
                nix-colors.homeManagerModules.default
              ];
            };
          }
        ];
      };
    };

  };
}
