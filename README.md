# Aerobreaker's custom Glove80 config

This can be managed alongside the main branch using something like this:
```
 git clone --bare git@github.com:Aerobreaker/glove80-zmk.git
 cd glove80-zmk
 git worktree add trees/main main
 git worktree add trees/custom-config custom-config
```

Based on the wonderful Glorious Engrammer layout (v36), by [Sunaku](https://github.com/sunaku/glove80-keymaps/)

# Under consideration

The following branches were previously merged, but have been removed.  They are under consideration for re-merging.
- https://github.com/voidyourwarranty2/zmk/tree/devel-adaptive

# Aerobreaker's custom ZMK repo

Forked from MoErgo's fork of ZMK.  It's got the latest changes from stock ZMK with a few notable changes:
- Generic Desktop page support courtesy of [Angweekiat](https://github.com/angweekiat/zmk-strip-kit46) (feat/add-generic-desktop-hid branch)
- Added ZMK_SPLIT_ROLE_CENTRAL to glove80 left hand for mouse move purposes
- Added an indicator for an additional BT profile, so that up to 5 BT profiles can be used with the glove80

Github workflows have been customized to suit my needs.  Releases are built from my custom configuration, available in the custom-config branch

## Split Studio, power management, and status

Glove80 firmware defaults `CONFIG_ZMK_STUDIO_SPLIT=y`. This generic split option
enables Studio on the central half and device power management on every half.
Other split keyboards can opt in through their shared configuration; all halves
must be built with the same value. Setting `CONFIG_PM_DEVICE=y` directly in a
shared configuration likewise enables power management on every half.

The Glove80 devicetree provides complementary status layouts on both halves.
Both show their local battery and lock state. The left half shows layers 1-6 and
13-18 plus Bluetooth/USB output state, while the right half shows layers 7-12
and 19-24 without duplicating the output-state indicators.

Status display is activated explicitly with the zero-parameter `&rgb_stat`
behavior, which is available to keymaps and ZMK Studio. The stock Glove80 and
Go60 keymaps use this behavior. The legacy `&rgb_ug RGB_STATUS` command remains
available for compatibility with existing MoErgo keymaps.

## Custom firmware mode

This branch explicitly sets `CONFIG_ZMK_STUDIO_SPLIT=y` in the shared
`config/glove80.conf`, enables the Studio USB transport on the left, and uses
`&rgb_stat` for dual-half status. The right half gets the paired device power
management support but does not compile Studio itself. ZMK Studio is included
in the default development shell on supported platforms, so launch it after
entering the shell with:

```sh
zmk-studio
```

Studio saves changes in the keyboard's persistent settings. Those changes normally survive firmware
updates and override the compiled keymap, but Studio does not currently write them back to
`config/glove80.keymap`; upstream lists keymap import and export as planned functionality. Manually
mirror any Studio change that should become part of the source-controlled stock keymap. Conversely,
changes made to the compiled keymap will not take effect at positions already overridden by Studio
until **Restore Stock Settings** is used in Studio, which removes the runtime keymap overrides.

## USB debug logging

USB logging and the retained USB Studio transport both use CDC ACM serial devices. The dedicated
debug output substitutes USB logging for the left half's Studio transport and applies the additional
Kconfig settings from `config/glove80-debug.conf` only to that half. Build it separately so it does
not replace the normal `result` link:

```sh
nix build .#glove80-debug --out-link result-debug
```

After flashing it, read the left half's log at 115200 baud through its stable device link under
`/dev/serial/by-id/`. This diagnostic firmware retains dual-half status but disables split Studio
and its paired power management on both halves.

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
