# Den Patterns

How the [den](https://github.com/denful/den) dendritic framework is used in SNROS to compose NixOS and home-manager configurations from reusable aspects.

## Aspects

An aspect is a reusable unit of configuration. Each aspect can define config for multiple scopes (homeManager, nixos) and include other aspects.

```nix
den.aspects.my-feature = {
  homeManager = { pkgs, ... }: {
    home.packages = [ pkgs.my-tool ];
  };
  nixos = {
    services.my-service.enable = true;
  };
};
```

Aspects are applied globally by including them in `den.default`:

```nix
den.default.includes = [ den.aspects.my-feature ];
```

## Composition

Aspects compose through `includes` and `provides`:

```nix
den.aspects.shell-ecosystem = {
  includes = [
    den.aspects.zsh
    den.aspects.starship
    den.aspects.atuin
  ];
};
```

Each included aspect is resolved independently and merged. This keeps individual aspects focused while allowing higher-level groupings.

`provides` declares reusable sub-aspects within an aspect, which can then be selectively included:

```nix
den.aspects.nvf = {
  provides.keys.vim.keymaps = [ /* ... */ ];
  provides.leader.vim.globals.mapleader = " ";
  includes = with den.aspects.nvf.provides; [
    keys
    leader
  ];
};
```

This lets consumers of an aspect opt in to only the sub-aspects they need, rather than pulling in everything.

## Standalone Evaluation with `den.homes`

Aspects applied via `den.default` are evaluated when a host or home is declared. To test home-manager config without a full NixOS host, use `den.homes`:

```nix
den.homes.x86_64-linux.test = {};
```

This creates a `homeConfigurations.test` flake output that includes all `den.default.homeManager` config. Evaluate it with:

```bash
nix build .#homeConfigurations.test.activationPackage
```

This catches config errors at evaluation time without needing a running system.

## Aspect Tests

Den aspects support a `tests` key whose values route to `flake.checks`:

```nix
den.aspects.my-feature = {
  homeManager = { pkgs, ... }: { ... };
  tests = { my-feature, ... }: {
    has-home-manager = {
      expr = my-feature ? homeManager;
      expected = true;
    };
  };
};
```

Tests are evaluation-time checks — they verify aspect structure and configuration values. Run them with:

```bash
nix flake check
```

## Module Files

Every `.nix` file in the `modules/` directory is auto-imported as a flake-parts module via [import-tree](https://github.com/vic/import-tree). No manual import lists needed — just create a file and it's picked up.

Each module file typically defines one aspect and includes it globally:

```nix
# modules/my-feature.nix
{
  den.aspects.my-feature = {
    homeManager = { ... }: { ... };
    nixos = { ... }: { ... };
    tests = { ... }: { ... };
  };

  den.default.includes = [ den.aspects.my-feature ];
}
```

## Key Concepts

| Concept | Description |
|---------|-------------|
| `den.aspects.<name>` | Reusable configuration unit with homeManager, nixos, and tests scopes |
| `den.default.includes` | Apply aspects globally to all hosts and users |
| `den.default.homeManager` | Direct home-manager config applied to all users (alternative to aspects for simple values) |
| `den.default.nixos` | Direct NixOS config applied to all hosts |
| `den.homes` | Standalone home-manager configurations for testing without hosts |
| `den.hosts` | Host declarations binding hardware to configuration |
| `den.schema.user.classes` | User classification (e.g., `homeManager`) |
