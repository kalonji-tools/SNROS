# SNROS

Personal NixOS configurations built with the dendritic pattern.

![CI](https://github.com/kalonji-tools/SNROS/actions/workflows/check.yaml/badge.svg)
![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)

## Overview

SNROS structures NixOS system configuration as composable aspects using the [den](https://github.com/denful/den) framework's dendritic pattern. Each aspect encapsulates a concern (a host, a user, a service) that can be mixed and matched across machines.

The flake itself is generated — [flake-file](https://github.com/denful/flake-file) produces `flake.nix` from the module tree, so you never edit it by hand (`nix run .#write-flake` to regenerate). The development workflow is handled by [devenv.sh](https://devenv.sh), which sets up the shell, tooling, and [prek](https://github.com/j178/prek) git hooks in one step. A [graphify](https://github.com/safishamsi/graphify) knowledge graph is kept in sync automatically through post-commit hooks.

## Getting Started

### Prerequisites

**Already on NixOS:**

- Nix with flakes enabled
- [devenv](https://devenv.sh/getting-started/) installed

**Starting from scratch:**

1. [Install NixOS](https://nixos.org/manual/nixos/stable/#sec-installation)
2. Enable flakes by adding the following to your NixOS configuration:

   ```nix
   nix.settings.experimental-features = [ "nix-command" "flakes" ];
   ```

### Setup

```bash
git clone https://github.com/kalonji-tools/SNROS.git
cd SNROS
devenv shell
nix flake check
```

### Applying a Host Configuration

```bash
sudo nixos-rebuild switch --flake .#hostname
```

Replace `hostname` with one defined under `modules/hosts/`.

## Development

All development happens inside `devenv shell`, which provides all required tooling and installs git hooks automatically.

### Hooks

**Pre-commit:** nixfmt (RFC 166), deadnix, statix

**Pre-push:** `nix flake check`

### Workflow

- **Conventional commits:** `feat:`, `fix:`, `chore:`, `docs:`, `ci:`, `style:`
- **Branching:** feature branches + PRs with rebase (no merge commits)
- **Worktrees:** always work in a worktree — `wt switch --create <branch>` ([worktrunk](https://github.com/max-sixty/worktrunk))
- **Flake regeneration:** `nix run .#write-flake` (never edit `flake.nix` directly)
- **Graphify:** knowledge graph rebuilds automatically via git hooks

## License

[MIT](LICENSE)
