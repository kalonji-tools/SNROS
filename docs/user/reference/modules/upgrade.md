# Upgrade Service

> Self-upgrade systemd service that pulls the latest config from GitHub and validates with testinfra.

## What it does

- **snros-upgrade** — a systemd oneshot service that:
  1. Runs `nixos-rebuild switch --flake github:kalonji-tools/SNROS` to apply the latest config
  2. Runs pytest-testinfra to validate the deployed system
  3. Logs everything to systemd journal

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

A zero exit code means both the rebuild and testinfra passed. Non-zero means either the rebuild failed or testinfra found issues.

## Failure behavior

| Scenario | What happens |
|----------|-------------|
| `nixos-rebuild switch` fails | Service fails immediately, testinfra doesn't run. System stays on previous config. |
| testinfra fails | Service exits non-zero. System is already switched — tests show what's wrong. |
| Network unavailable | `nixos-rebuild` can't fetch flake, service fails. System unchanged. |

## Den configuration

| Scope | What's set |
|-------|-----------|
| `den.aspects.upgrade.nixos` | `systemd.services.snros-upgrade` (oneshot, ExecStart = upgrade + testinfra script) |

The aspect is included globally via `den.default.includes`.

## How it works internally

The service uses:
- `nixos-rebuild switch --flake github:kalonji-tools/SNROS` — fetches the flake directly from GitHub (no local clone needed)
- `python3.withPackages` — bundles pytest + testinfra into a self-contained environment (independent of devenv)
- `tests/` directory is copied into the nix store at build time

## No automatic polling

The service has no timer. It only runs when you explicitly trigger it. This is intentional — upgrades should be conscious decisions on personal machines.
