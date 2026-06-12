{ pkgs, ... }:

{
  packages = with pkgs; [
    prek
    nixfmt
    uv

    # Nix tooling
    deadnix
    statix
    nil
  ];

  tasks."snros:install-hooks" = {
    exec = ''
      if git rev-parse --git-dir > /dev/null 2>&1; then
        git config --unset core.hooksPath 2>/dev/null || true
        prek install --quiet
        HOOKS_DIR="$(git rev-parse --git-common-dir)/hooks"
        git config core.hooksPath "$HOOKS_DIR"
      fi
    '';
    before = [ "devenv:enterShell" ];
  };

  tasks."snros:install-graphify" = {
    exec = ''
      uv tool install graphifyy -q 2>/dev/null
      export PATH="$HOME/.local/bin:$PATH"
      if git rev-parse --git-dir > /dev/null 2>&1; then
        graphify hook install 2>/dev/null || true
      fi
    '';
    before = [ "devenv:enterShell" ];
  };

  enterShell = ''
    export PATH="$HOME/.local/bin:$PATH"
  '';
}
