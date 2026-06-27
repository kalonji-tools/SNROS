# VM Integration Tests (Disko + Preservation)

> VM tests that validate destructive disk operations and ephemeral root behavior before deploying to real hardware.

## Tests

| Check | What it validates |
|-------|------------------|
| `vm-disko-format` | Disko formatting: LUKS container, ZFS pool with root/nix/persistent datasets, blank snapshot, FAT32 ESP |
| `vm-ephemeral-reboot` | Preservation bind mounts survive reboot: machine-id stability, /var/lib/nixos persistence |

## How to run

### All checks

```bash
nix flake check
```

### Individual tests

```bash
nix build .#checks.x86_64-linux.vm-disko-format
nix build .#checks.x86_64-linux.vm-ephemeral-reboot
```

## Shared disko layout

Both the VM test and real host configs use `mkDiskoConfig` from `modules/disko-layout.nix`:

```nix
# Real host
disko.devices = mkDiskoConfig {
  device = "/dev/nvme0n1";
  luksAuth = "passphrase";
};

# VM test
mkDiskoConfig {
  device = "/dev/vdb";
  luksAuth = "keyfile";
  espSize = "256M";
};
```

Parameters:

| Param | Default | Description |
|-------|---------|-------------|
| `device` | (required) | Block device path |
| `luksAuth` | `"passphrase"` | `"passphrase"` for interactive, `"keyfile"` for `/tmp/luks-pass` |
| `espSize` | `"512M"` | ESP partition size |

## When to run

Run these tests after any change to:
- `modules/disko-layout.nix` (shared layout function)
- `modules/ephemeral-root.nix` (rollback service, ZFS support)
- `modules/preservation-base.nix` (preserved paths)
- `modules/dell-xps-9640.nix` (host disko config)
