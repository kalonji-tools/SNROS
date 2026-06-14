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
    "snros:install-hooks" = {
      exec = ''
                if git rev-parse --git-dir > /dev/null 2>&1; then
                  git config --unset core.hooksPath 2>/dev/null || true
                  prek install --quiet
                  HOOKS_DIR="$(git rev-parse --git-common-dir)/hooks"
                  git config core.hooksPath "$HOOKS_DIR"

                  # Inject graphify-out dirty check before prek in pre-push hook.
                  # prek stashes unstaged changes before running hooks, so a prek-based
                  # check can't see dirty graphify-out/. This guard runs before prek.
                  PREPUSH="$HOOKS_DIR/pre-push"
                  if [ -f "$PREPUSH" ] && ! grep -q "graphify-out guard" "$PREPUSH"; then
                    sed -i '/^exec "\$PREK"/i \
        # graphify-out guard: block push if graphify-out has uncommitted changes\
        if git diff --name-only | grep -q "^graphify-out/" || git diff --cached --name-only | grep -q "^graphify-out/"; then\
          echo "ERROR: graphify-out/ has uncommitted changes."\
          echo "Run: git add graphify-out/ \\&\\& GRAPHIFY_SKIP_HOOK=1 git commit -m '"'"'chore: update graphify'"'"'"\
          exit 1\
        fi' "$PREPUSH"
                  fi
                fi
      '';
      before = [ "devenv:enterShell" ];
    };

    "snros:uv-sync" = {
      exec = ''
        uv sync --all-groups -q 2>/dev/null
        if git rev-parse --git-dir > /dev/null 2>&1; then
          uv run graphify hook install 2>/dev/null || true
        fi
      '';
      before = [ "devenv:enterShell" ];
    };
  };

  enterShell = ''
    export PATH="$PWD/.venv/bin:$PATH"
  '';
}
