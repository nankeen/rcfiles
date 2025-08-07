{
  description = "Example nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-24.11-darwin";
    nix-darwin.url = "github:LnL7/nix-darwin/nix-darwin-24.11";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    pwndbg.url = "github:pwndbg/pwndbg";

    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    # Optional: Declarative tap management
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    homebrew-cask-fonts = {
      url = "github:homebrew/homebrew-cask-fonts";
      flake = false;
    };
    homebrew-cross-avr = {
      url = "github:osx-cross/homebrew-avr";
      flake = false;
    };
    homebrew-cross-arm = {
      url = "github:osx-cross/homebrew-arm";
      flake = false;
    };
    homebrew-apple = {
      url = "github:apple/homebrew-apple";
      flake = false;
    };
  };

  outputs = inputs@{
    self, nix-darwin, nixpkgs, pwndbg, nix-homebrew,
    homebrew-core, homebrew-cask, homebrew-cask-fonts,
    homebrew-cross-avr, homebrew-cross-arm, homebrew-apple }:
  let
    configuration = { pkgs, ... }: {
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages =
        with pkgs;
        [ vim git tmux zsh emacs oh-my-zsh
          lldb docker pwndbg
          python3 python3.pkgs.pwntools python3.pkgs.ropper
          imagemagick
        ];

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Enable alternative shell support in nix-darwin.
      # programs.fish.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 5;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";

      homebrew = {
        enable = pkgs.stdenv.isDarwin;
        onActivation = {
          autoUpdate = false;
          upgrade = false;
        };

        taps = [
          "homebrew/cask-fonts"
          "osx-cross/arm"
          "osx-cross/avr"
        ];
      };

    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#acrobat
    darwinConfigurations."acrobat" = nix-darwin.lib.darwinSystem {
      modules = [
        # Migrate homebrew
        nix-homebrew.darwinModules.nix-homebrew {
          nix-homebrew = {
            # Install Homebrew under the default prefix
            enable = true;

            # Apple Silicon Only: Also install Homebrew under the default Intel prefix for Rosetta 2
            enableRosetta = true;

            # User owning the Homebrew prefix
            user = "nankeen";

            autoMigrate = true;
          };
        }

        configuration
      ];
    };
  };
}
