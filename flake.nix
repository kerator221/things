{
  description = "NixOS lenovo config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nixpkgs, home-manager }: 
    let 
      system = "x86_64-linux";
      username = "ghosty";
      mail = "ggmail04@mail.ru";
    in 
    {
      nixosConfigurations = nixpkgs.lib.genAttrs ["nixos"] (hostName: nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs username mail; };
        modules = [
          { networking.hostName = hostName; }
          ./hosts/${hostName}/configuration.nix
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit username mail; };
            home-manager.users.${username} = import ./hosts/${hostName}/home.nix;
          }
        ];
      });
    };
}
