# Add a New Module

How to add a new tool or service to SNROS as a den aspect with tests and documentation.

## 1. Create the module file

Create `modules/<name>.nix`. Each module defines a den aspect and includes it globally:

```nix
# modules/my-tool.nix
{
  den.aspects.my-tool = {
    homeManager = { pkgs, ... }: {
      home.packages = [ pkgs.my-tool ];
    };
  };

  den.default.includes = [ den.aspects.my-tool ];
}
```

### Choosing the right scope

| Scope | Use for |
|-------|---------|
| `homeManager` | User-level programs, shell config, dotfiles |
| `nixos` | System services, system packages, kernel modules |

Use `homeManager` for tools the user runs directly (editors, CLI tools, shell plugins). Use `nixos` for system-level services or packages that need root access.

### Adding preservation

If your tool stores state that should survive reboots (ephemeral root — see [ADR 0002](https://github.com/kalonji-tools/SNROS/blob/main/docs/adr/0002-preservation-over-impermanence.md)), add a preservation declaration:

```nix
nixos = { pkgs, config, lib, ... }: {
  environment.systemPackages = [ pkgs.my-tool ];
  preservation.preserveAt."/persistent" = lib.mkIf (config ? preservation) {
    users.snregales.directories = [
      ".config/my-tool"
    ];
  };
};
```

!!! note
    The `lib.mkIf (config ? preservation)` guard is needed until issue #22 adds the preservation module. Once it lands, the guard activates automatically.

## 2. Add aspect tests

Den aspects support a `tests` key that routes to `flake.checks`:

```nix
den.aspects.my-tool = {
  homeManager = { pkgs, ... }: { ... };
  tests = { my-tool, ... }: {
    has-homeManager = {
      expr = my-tool ? homeManager;
      expected = true;
    };
  };
};
```

Run tests with:

```bash
nix flake check
```

## 3. Format and lint

```bash
devenv shell -- nixfmt modules/my-tool.nix
devenv shell -- deadnix modules/my-tool.nix
devenv shell -- statix check modules/my-tool.nix
```

## 4. Write the reference page

Create `docs/reference/modules/<name>.md` using this template:

````markdown
# Module Name

> Brief one-line description of what this module configures.

## What it does

- Tool/program 1 — what it is, why it's included
- Tool/program 2 — ...

## Den configuration

| Scope | What's set |
|-------|-----------|
| `den.aspects.<name>.homeManager` | programs, packages |
| `den.aspects.<name>.nixos` | system packages, service config |

## Preservation

| Path | Reason |
|------|--------|
| `~/.cache/example` | Reason for preserving |

_(Omit this section if the module has no preservation declarations.)_

## Standalone evaluation

The aspect is testable via den's built-in test infrastructure:

```bash
nix flake check
```

For deeper evaluation, declare a standalone home:

```nix
den.homes.x86_64-linux.test = {};
```

Then build:

```bash
nix build .#homeConfigurations.test.activationPackage
```

## Post-deploy verification

```bash
# Commands to verify the module works on a live system
which my-tool
my-tool --version
```
````

If this is the first reference page, also add the reference directory to `docs/.pages`:

```yaml
nav:
  - Home: index.md
  - Reference: reference
  - Explanation: explanation
  - How-To Guides: how-to
```

And create `docs/reference/.pages`:

```yaml
title: Reference
```

And create `docs/reference/modules/.pages`:

```yaml
title: Modules
```

## 5. Run all checks

```bash
devenv shell -- prek run --all-files
nix flake check
devenv shell -- mkdocs build --strict
```

## 6. Commit everything together

The module code, tests, and documentation ship in the same PR.
