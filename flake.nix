{
  description = "Aerobreaker's Glove80 ZMK firmware";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs =
    { nixpkgs, ... }:
    let
      supportedSystems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;

      pkgsFor =
        system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
          overlays = [ ];
        };

      zmkPackagesFor = system: import ./default.nix { pkgs = pkgsFor system; };
    in
    {
      legacyPackages = forAllSystems zmkPackagesFor;

      packages = forAllSystems (
        system:
        let
          zmk = zmkPackagesFor system;
        in
        {
          default = zmk.glove80_combined;

          glove80-combined = zmk.glove80_combined;
          glove80-debug = zmk.glove80_debug_combined;
          glove80-left = zmk.glove80_left;
          glove80-right = zmk.glove80_right;

          go60-combined = zmk.go60_combined;
          go60-left = zmk.go60_left;
          go60-right = zmk.go60_right;

          glove80-v0-left = zmk.glove80_v0_left;
          glove80-v0-right = zmk.glove80_v0_right;
          settings-reset = zmk.zmk_settings_reset;
        }
      );

      checks = forAllSystems (system: {
        default = (zmkPackagesFor system).glove80_combined;
      });

      devShells = forAllSystems (
        system:
        let
          pkgs = pkgsFor system;
        in
        {
          default = import ./nix/cmake-shell.nix { inherit pkgs; };
          west = import ./nix/west-shell.nix { inherit pkgs; };
        }
      );

      formatter = forAllSystems (system: (pkgsFor system).nixfmt);
    };
}
