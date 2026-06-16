# Upgrade Service

> Self-upgrade systemd service that pulls the latest config from GitHub.

## What it does

- **snros-upgrade** — a systemd oneshot service that:
  1. Runs `nixos-rebuild switch --flake github:kalonji-tools/SNROS` to apply the latest config
  2. Logs everything to systemd journal

> **Note:** Post-deploy validation is temporarily removed. It will be restored once oxitest + oxi-nixinfra are available in nixpkgs (see issue #55).

## How to use

### Trigger an upgrade

```bash
sudo systemctl start snros-upgrade
```

### Watch progress

```bash
journalctl -u snros-upgrade -f
```

### Check last result

```bash
systemctl status snros-upgrade
```

A zero exit code means the rebuild succeeded. Non-zero means the rebuild failed.

## Failure behavior

| Scenario | What happens |
|----------|-------------|
| `nixos-rebuild switch` fails | Service fails immediately. System stays on previous config. |
| Network unavailable | `nixos-rebuild` can't fetch flake, service fails. System unchanged. |

## Den configuration

| Scope | What's set |
|-------|-----------|
| `den.aspects.upgrade.nixos` | `systemd.services.snros-upgrade` (oneshot, ExecStart = upgrade + testinfra script) |

The aspect is included globally via `den.default.includes`.

## How it works internally

The service uses:
- `nixos-rebuild switch --flake github:kalonji-tools/SNROS` — fetches the flake directly from GitHub (no local clone needed)

## No automatic polling

The service has no timer. It only runs when you explicitly trigger it. This is intentional — upgrades should be conscious decisions on personal machines.
