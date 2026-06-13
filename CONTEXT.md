# SNROS Domain Glossary

## System-Defining Layer

The hardware-facing infrastructure that the machine cannot function without.

- **Host**: A specific physical machine identified by its hardware model name (e.g., `dell-xps-9640`). Each host has its own nixos-facter report, ZFS pool layout, and NixOS configuration. New hardware means a new host, never a migration.
- **Ephemeral Root**: The root filesystem is wiped on every boot. All state must be explicitly opted into persistence via Preservation.
- **Preservation**: A NixOS module for declarative opt-in persistence on an ephemeral root system. Successor to impermanence with a cleaner API.

## Tool Categories

- **Standalone Tool**: A tool with no runtime dependency on or configuration coupling with other tools (e.g., bat, bottom, dust).
- **Tandem Tools**: Tools that either have hard runtime dependencies on each other or whose configurations are coupled enough that they must be designed together (e.g., foot + zellij, zsh + starship + atuin).
- **Cross-Cutting Concern**: A tool or module that touches the configuration of many other tools across categories. Stylix is the primary example — it owns theming globally.

## Theming

- **Stylix**: The single source of truth for colors and fonts across the entire system. Individual tools receive their theme from stylix. Per-tool overrides are permitted only when stylix's output is insufficient.
- **Noctalia Theme Engine**: Subordinate to stylix. Stylix colors are mapped into Noctalia's configuration to maintain a single source of truth.

## Shell

- **Primary Shell**: Zsh — the current daily driver.
- **Migration Target**: Nushell — the intended future daily driver. Both are configured; zsh is active.
- **Zsh-Only Tools**: Tools that will not migrate to nushell (e.g., thefuck). Their nushell gap is covered by other tools (navi, atuin).

## Terminal

- **Terminal Emulator**: Foot — lightweight, Wayland-native. Chosen because the multiplexer provides the pane/tab layer.
- **Multiplexer**: Zellij — the portable multiplexing layer that decouples workflow from terminal emulator choice.
