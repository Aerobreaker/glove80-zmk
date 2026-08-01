# Aerobreaker's custom ZMK repo

Forked from MoErgo's fork of ZMK.  It's got the latest changes from stock ZMK with a few notable changes:
- Generic Desktop page support courtesy of [Angweekiat](https://github.com/angweekiat/zmk-strip-kit46) (feat/add-generic-desktop-hid branch)
- Added ZMK_SPLIT_ROLE_CENTRAL to glove80 left hand for mouse move purposes
- Added an indicator for an additional BT profile, so that up to 5 BT profiles can be used with the glove80

Github workflows have been customized to suit my needs.  Releases are built from my custom configuration, available in the custom-config branch

## Building with Nix

This repository is a flake pinned to `nixpkgs-unstable`. To build the combined Glove80 firmware:

```sh
nix build
```

The result is available at `result/glove80.uf2`. Named outputs are also available for individual
halves and other supported boards, for example:

```sh
nix build .#glove80-left
nix build .#glove80-right
nix build .#go60-combined
```

Use `nix develop` for the CMake-based development shell, or `nix develop .#west` for the West
workspace shell. The legacy `nix-build -A glove80_combined` interface remains available and uses
the same revision from `flake.lock`. With direnv and nix-direnv installed, run `direnv allow` once
per worktree to have `.envrc` enter the default development shell automatically.

# Zephyr™ Mechanical Keyboard (ZMK) Firmware

[![Discord](https://img.shields.io/discord/719497620560543766)](https://zmk.dev/community/discord/invite)
[![Build](https://github.com/zmkfirmware/zmk/workflows/Build/badge.svg)](https://github.com/zmkfirmware/zmk/actions)
[![Contributor Covenant](https://img.shields.io/badge/Contributor%20Covenant-v2.0%20adopted-ff69b4.svg)](CODE_OF_CONDUCT.md)

[ZMK Firmware](https://zmk.dev/) is an open source ([MIT](LICENSE)) keyboard firmware built on the [Zephyr™ Project](https://www.zephyrproject.org/) Real Time Operating System (RTOS). ZMK's goal is to provide a modern, wireless, and powerful firmware free of licensing issues.

Check out the website to learn more: https://zmk.dev/.

You can also come join our [ZMK Discord Server](https://zmk.dev/community/discord/invite).

To review features, check out the [feature overview](https://zmk.dev/docs/). ZMK is under active development, and new features are listed with the [enhancement label](https://github.com/zmkfirmware/zmk/issues?q=is%3Aissue+is%3Aopen+label%3Aenhancement) in GitHub. Please feel free to add 👍 to the issue description of any requests to upvote the feature.
