# ADR 0002: Preservation over Impermanence

## Status

Accepted

## Context

SNROS uses ZFS with an ephemeral root — the root filesystem is wiped on every boot and all persistent state must be explicitly declared. Two NixOS modules provide this pattern:

- **impermanence** — the established solution, widely used, extensive community documentation and known workarounds for edge cases.
- **preservation** — a newer module inspired by impermanence, offering a cleaner API and tighter NixOS integration, but with less community adoption and fewer battle-tested examples.

Both modules solve the same problem: declaratively specifying which paths survive a reboot on an ephemeral root system.

## Decision

Use preservation instead of impermanence.

## Consequences

- Cleaner, more idiomatic NixOS configuration for persistence declarations.
- Fewer community examples to draw from when debugging edge cases.
- The underlying ZFS dataset layout is the same for both modules — switching to impermanence later would only require changing the NixOS module configuration, not the disk layout.
- Risk is low for a personal system: breakage is a learning opportunity, not a production incident.
