# ADR 0001: devenv over flake-native dev shell

## Status

Accepted

## Context

The project initially used a flake-native `mkShellNoCC` dev shell (`modules/flake/shell.nix`) for the development environment. This was a bootstrap choice.

All kalonji-tools projects use devenv.sh as the standard dev environment tool. devenv is language-agnostic and provides a consistent developer experience across projects (e.g. oxitest uses devenv with Rust + Python).

## Decision

Replace the flake-native dev shell with devenv.sh. devenv owns the development environment (packages, hooks, services). The flake remains for NixOS host configurations via den + flake-parts.

Two entry points coexist:
- `devenv.nix` — dev environment
- `flake.nix` — NixOS host configs

## Consequences

- Consistent dev workflow across all kalonji-tools repos
- CI uses cachix/devenv-action with kalonji-tools cache for caching
- `nix develop` no longer provides a dev shell — use `devenv shell` instead
- Formatting is prek's responsibility, not the flake's formatter option
- Developers need devenv installed (`nix profile install nixpkgs#devenv`)
