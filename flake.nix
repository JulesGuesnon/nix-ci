{
  description = "Minimal dev terminal flake";

  inputs = {
    nixpkgs.url = "ithub:NixOS/nixpkgs/nixos-25.05";
  };

  outputs = { self, nixpkgs }:
    let
      supportedSystems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      forEachSupportedSystem = f:
        nixpkgs.lib.genAttrs supportedSystems (system: f {
          pkgs = import nixpkgs { inherit system; };
        });
    in
    {
      devShells = forEachSupportedSystem ({ pkgs }: {
        default = pkgs.mkShell {
          buildInputs = [
            pkgs.git
            pkgs.gh
            pkgs.node_22
            pkgs.yarn-berry
            pkgs.python312
            pkgs.uv
            pkgs.zulu
          ];
        };
      });
    };
}
