# NixOS Helpers

> Comma, nh, and manix — workflow tools for NixOS package discovery, system rebuilds, and documentation search.

## What it does

- **Comma** — run any program from nixpkgs without installing it. Uses nix-index to locate packages, then runs them in a temporary shell. Replaces the default command-not-found handler.
- **nh** — NixOS helper for ergonomic system rebuilds (`nh os switch`), package search (`nh search`), and garbage collection (`nh clean`).
- **manix** — fast offline search for NixOS options, Nix builtins, and library function documentation.
- **nix-index** — indexes nixpkgs to provide a database mapping executables to packages. Powers comma and the command-not-found replacement shell hook.

## Den configuration

| Scope | What's set |
|-------|-----------|
| `den.aspects.nix-helpers.homeManager` | `programs.nix-index` (enabled, zsh integration), `home.packages` (comma, manix) |
| `den.aspects.nix-helpers.nixos` | `programs.command-not-found.enable = false`, `environment.systemPackages` (nh), preservation for nix-index cache |

The aspect is included globally via `den.default.includes`.

## Preservation

| Path | Reason |
|------|--------|
| `~/.cache/nix-index` | nix-index database — rebuilt with `nix-index` command, slow to regenerate |

Guarded with `lib.mkIf (config ? preservation)` until issue #22 adds the preservation module.

## Standalone evaluation

The aspect is testable via den's built-in test infrastructure:

- `nix flake check` runs the aspect tests (verifies homeManager and nixos scopes exist)
- For deeper evaluation, declare a standalone home via `den.homes.x86_64-linux.test = {}` to resolve all `den.default` config (including this aspect) against a real home-manager evaluation

## Post-deploy verification

After a host boots (requires #22):

```bash
# Verify tools are available
which comma && which nh && which manix

# Build nix-index database (first time only, takes a few minutes)
nix-index

# Test comma — run a program without installing it
, cowsay hello

# Test nh — search for a package
nh search hello

# Test manix — search NixOS options
manix programs.nix-index
```
