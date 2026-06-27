# Ephemeral Root

> Shared aspect for ZFS ephemeral root with blank snapshot rollback on every boot.

## What it does

- **systemd-boot** as the UEFI bootloader
- **ZFS filesystem support** in kernel and initrd
- **Blank snapshot rollback** — initrd service rolls back `zroot/root@blank` before root is mounted
- **Preservation module** enabled (declarations are in preservation-base and per-module)

## Boot sequence

1. UEFI loads systemd-boot from ESP
2. systemd-boot prompts for LUKS passphrase
3. initrd unlocks LUKS, imports ZFS pool
4. `rollback-root` service runs `zfs rollback -r zroot/root@blank`
5. Root and other datasets mounted
6. Preservation bind-mounts persistent paths
7. System boots

## Den configuration

| Scope | What's set |
|-------|-----------|
| `den.aspects.ephemeral-root.nixos` | systemd-boot, ZFS support, initrd rollback service, preservation enable, networking.hostId |

Applied globally via `den.default.includes`.

## Shared across hosts

This aspect is identical for all SNROS hosts. Host-specific config (disko layout, facter report) lives in per-host modules.
