# Preservation Base

> Shared aspect declaring system-level paths that survive ephemeral root reboots.

## What it preserves

| Path | Why |
|------|-----|
| `/etc/machine-id` | Systemd machine identity |
| `/var/lib/nixos` | NixOS UID/GID map |
| `/var/lib/systemd` | Systemd persistent state (timers, journal cursor) |
| `/var/log/journal` | Persistent journal logs |
| `/var/lib/NetworkManager` | WiFi passwords, connection profiles |
| `/var/lib/bluetooth` | Bluetooth pairings |
| `/var/lib/fwupd` | Firmware update state |

## Preservation philosophy

Fine-grained throughout. Each module declares what it needs:
- System paths here (shared across hosts)
- Tool paths in the tool's module (e.g., `~/.cache/nix-index` in nix-helpers)
- User paths in the host module (e.g., `~/Projects` in dell-xps-9640)

## Den configuration

| Scope | What's set |
|-------|-----------|
| `den.aspects.preservation-base.nixos` | `preservation.preserveAt."/persistent"` with system directories and files |

Applied globally via `den.default.includes`.
