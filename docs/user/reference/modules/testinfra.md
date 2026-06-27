# Testinfra

> Post-deploy validation framework for verifying SNROS host state.

## What it does

- **pytest-testinfra** — pytest plugin that validates a running system's state: services running, packages installed, users exist, ports open
- **paramiko** — SSH backend for testing remote hosts

Testinfra complements NixOS VM tests (issue #9) by testing against real deployed hardware rather than QEMU VMs.

## How to run

### Local (on the machine itself)

```bash
devenv shell -- pytest tests/
```

### Remote (SSH to a host)

```bash
devenv shell -- pytest tests/ --host=ssh://dell-xps-9640
```

### Specific test file

```bash
devenv shell -- pytest tests/hosts/test_common.py -v
```

## Test structure

```
tests/
├── conftest.py           # Connection fixtures (--host option)
└── hosts/
    └── test_common.py    # Tests for any SNROS host
```

### Adding a new test

Tests use the `host` fixture from `conftest.py`:

```python
def test_my_service_running(host):
    service = host.service("my-service")
    assert service.is_running
```

Common testinfra modules:

| Module | Usage |
|--------|-------|
| `host.user("name")` | Check user exists, groups, shell |
| `host.service("name")` | Check service is running/enabled |
| `host.package("name")` | Check package is installed |
| `host.file("/path")` | Check file exists, permissions, content |
| `host.run("command")` | Run a command and check return code/output |
| `host.socket("tcp://port")` | Check port is listening |

### Adding host-specific tests

Create `tests/hosts/test_<hostname>.py` for tests that only apply to a specific machine:

```python
# tests/hosts/test_dell_xps_9640.py
"""Tests specific to the dell-xps-9640 host."""


def test_wifi_interface_exists(host):
    cmd = host.run("ip link show wlp0s20f3")
    assert cmd.rc == 0
```

## Python dependencies

All Python dependencies are managed in `pyproject.toml` at the repo root:

```toml
[dependency-groups]
test = ["pytest", "pytest-testinfra", "paramiko"]
```

Installed via `uv sync --all-groups` (runs automatically on `devenv shell` entry).
