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

  tasks = {
    "snros:uv-sync" = {
      exec = ''
        uv sync --all-groups -q 2>/dev/null
      '';
      before = [ "devenv:enterShell" ];
    };
  };

  enterShell = ''
    export PATH="$PWD/.venv/bin:$PATH"
  '';
}
