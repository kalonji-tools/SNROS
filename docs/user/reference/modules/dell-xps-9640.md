# Dell XPS 9640

> Host configuration for the dell-xps-9640 laptop.

## Hardware

- 512GB Micron NVMe SSD (`/dev/nvme0n1`)
- Hardware auto-detected via nixos-facter report at `hosts/dell-xps-9640/facter.json`

## Disk layout (disko)

```
/dev/nvme0n1
└── GPT
    ├── p1: FAT32 ESP (512MB, /boot)
    └── p2: LUKS (cryptroot)
        └── ZFS pool (zroot)
            ├── root → / (ephemeral)
            ├── nix → /nix
            └── persistent → /persistent
```

## User preservation

| Path | Why |
|------|-----|
| `~/Projects` | Working repositories |

## Den configuration

| Scope | What's set |
|-------|-----------|
| `den.hosts.x86_64-linux.dell-xps-9640` | Host entry with user snregales |
| `den.aspects.dell-xps-9640.nixos` | Disko layout, facter report, TTY auto-login, user preservation |

## HITL provisioning

To provision this host from a NixOS ISO:

```bash
# 1. Boot NixOS ISO on the laptop
# 2. Format and install (disko handles everything)
sudo nix run github:nix-community/disko -- --mode disko --flake github:kalonji-tools/SNROS#dell-xps-9640
sudo nixos-install --flake github:kalonji-tools/SNROS#dell-xps-9640 --no-root-password
# 3. Reboot and enter LUKS passphrase
```

## Regenerating facter report

If hardware changes:

```bash
sudo nix run nixpkgs#nixos-facter -- -o hosts/dell-xps-9640/facter.json
sudo chown snregales:users hosts/dell-xps-9640/facter.json
git add hosts/dell-xps-9640/facter.json && git commit -m "chore: update facter report"
```
