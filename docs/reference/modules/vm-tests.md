# VM Tests

> NixOS integration tests that validate host configurations boot and converge correctly.

## What it does

NixOS VM tests use `testers.runNixOSTest` to build a QEMU virtual machine from a NixOS configuration and run Python test scripts against it. They answer "does this config boot?" — catching evaluation errors, missing modules, service failures, and boot issues before deploying to real hardware.

## Testing flow

```
nix flake check → NixOS VM test → nixos-rebuild switch → testinfra
  "evaluates?"     "boots?"          "deploy"            "works?"
```

## How to run

### All checks (includes VM tests)

```bash
nix flake check
```

### Single VM test

```bash
nix build .#checks.x86_64-linux.vm-minimal-boot
```

## Current tests

| Check | What it verifies |
|-------|-----------------|
| `vm-minimal-boot` | Minimal NixOS boots, `default.target` reached, `nixos-rebuild` available |

## Adding a new VM test

Add a new entry to the `checks` attrset in `modules/vm-tests.nix`:

```nix
checks = {
  vm-minimal-boot = /* existing */;
  vm-my-feature = pkgs.testers.runNixOSTest {
    name = "my-feature";
    nodes.machine = {
      # NixOS configuration for the test VM
      services.my-service.enable = true;
    };
    testScript = ''
      machine.wait_for_unit("default.target")
      machine.wait_for_unit("my-service.service")
      machine.succeed("my-command --version")
    '';
  };
};
```

### Naming convention

VM test checks use the `vm-` prefix: `vm-minimal-boot`, `vm-dell-xps-9640`, etc.

### Common test script commands

| Command | Purpose |
|---------|---------|
| `machine.wait_for_unit("service")` | Wait for a systemd unit to start |
| `machine.succeed("command")` | Run a command, assert exit code 0 |
| `machine.fail("command")` | Run a command, assert non-zero exit |
| `machine.wait_for_open_port(port)` | Wait for a TCP port to open |
| `machine.screenshot("name")` | Take a screenshot (useful for GUI tests) |

### Testing a host configuration (when #22 lands)

```nix
vm-dell-xps-9640 = pkgs.testers.runNixOSTest {
  name = "dell-xps-9640";
  nodes.machine = {
    imports = [ config.flake.nixosConfigurations.dell-xps-9640.config ];
  };
  testScript = ''
    machine.wait_for_unit("default.target")
    # Host-specific assertions
  '';
};
```

## CI considerations

GitHub Actions free tier lacks KVM. VM tests run locally via pre-push hook (`nix flake check`) where KVM is available. If CI fails on VM tests, the fix is either `--option system-features ''` or skipping VM checks in CI.

## References

- [NixOS VM tests tutorial](https://nix.dev/tutorials/nixos/integration-testing-using-virtual-machines)
- [testers.runNixOSTest](https://ryantm.github.io/nixpkgs/builders/testers/)
