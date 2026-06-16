# Oxitest

> Post-deploy validation framework for verifying SNROS host state.

## What it does

- **oxitest** — fast, typed Python test framework backed by a Rust runner
- **oxi-nixinfra** — NixOS-specific infrastructure testing library (oxitest plugin)

Oxitest + oxi-nixinfra complement NixOS VM tests (issue #9) by testing against real deployed hardware rather than QEMU VMs.

## How to run

### Local (on the machine itself)

```bash
devenv shell -- oxitest tests/
```

### Remote (SSH to a host)

```bash
OXITEST_HOST=ssh://dell-xps-9640 devenv shell -- oxitest tests/
```

### Specific test file

```bash
devenv shell -- oxitest tests/hosts/test_common.py -v
```

## Test structure

```
tests/
└── hosts/
    └── test_common.py    # Tests for any SNROS host
```

### Adding a new test

Tests receive `Host` via oxitest's `Fixture[Host]` annotation. The host is injected automatically by the oxi-nixinfra plugin:

```python
from oxi_nixinfra import Host
from oxitest import Fixture


def test_my_service_running(host: Fixture[Host]) -> None:
    service = host.service("my-service")
    assert service.is_running()
```

Common oxi-nixinfra modules:

| Module | Usage |
|--------|-------|
| `host.user("name")` | Check user exists, groups, shell |
| `host.service("name")` | Check service is running/enabled |
| `host.nix_package("name")` | Check Nix package is installed, get version |
| `host.nix_option("path")` | Check NixOS option value |
| `host.file("/path")` | Check file exists, permissions, content |
| `host.run("cmd", "arg")` | Run a command and check result |
| `host.system_info()` | Get OS type, distribution, release, arch |

### Adding host-specific tests

Create `tests/hosts/test_<hostname>.py` for tests that only apply to a specific machine:

```python
# tests/hosts/test_dell_xps_9640.py
"""Tests specific to the dell-xps-9640 host."""

from oxi_nixinfra import Host
from oxitest import Fixture


def test_wifi_interface_exists(host: Fixture[Host]) -> None:
    cmd = host.run("ip", "link", "show", "wlp0s20f3")
    assert cmd.succeeded()
```

## Python dependencies

All Python dependencies are managed in `pyproject.toml` at the repo root:

```toml
[dependency-groups]
test = ["oxitest", "oxi-nixinfra"]
```

Installed via `uv sync --all-groups` (runs automatically on `devenv shell` entry).

## Host selection

The target host for tests is resolved in order:

1. `OXITEST_HOST` env var (highest priority)
2. `[tool.oxitest.plugin_settings.oxi_nixinfra._plugin]` in pyproject.toml
3. `"local://"` (default — tests run on the local machine)
