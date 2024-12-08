{
  description = "NixOS System Configuration with Home Manager user";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nix-colors.url = "github:Misterio77/nix-colors";
    home-manager.url = "github:nix-community/home-manager";
    nixvim.url = "github:nix-community/nixvim";
    nixneovimplugins.url = "github:jooooscha/nixpkgs-vim-extra-plugins";
  };

  outputs = inputs @ { nixpkgs, nix-colors, home-manager, ... }: {
    nixosConfigurations = {
      nixos-laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ({ ... }: { nixpkgs.overlays = [ inputs.nixneovimplugins.overlays.default ]; })
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
                inputs.nixvim.homeManagerModules.nixvim
              ];
            };
          }
        ];
      };
    };

  };
}
