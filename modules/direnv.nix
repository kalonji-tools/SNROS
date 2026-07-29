{ den, ... }:
{
  den.aspects.direnv = {
    homeManager =
      { config, ... }:
      let
        # Bound here rather than read inline: `programs.direnv.config` and the
        # module argument `config` are both in scope below, and referencing
        # `config.home.homeDirectory` from inside that attrset resolves
        # correctly but reads as a trap.
        projects = "${config.home.homeDirectory}/Projects";
      in
      {
        programs.direnv = {
          enable = true;
          # Explicit even though it defaults true: bash is the login shell and
          # no module states that anywhere, so leaving it implicit hides the
          # dependency.
          enableBashIntegration = true;

          # Whitelist rather than `direnv allow`, because the root is
          # ephemeral. direnv records approvals in ~/.local/share/direnv/allow
          # keyed by .envrc content hash; the ZFS rollback in ephemeral-root
          # wipes that on every boot, so an approval workflow would need
          # re-running in every project after every reboot. A whitelist is
          # config in the nix store, so it survives — it is not state.
          #
          # The trade: any .envrc under this prefix runs unreviewed, including
          # one arriving in a branch you check out. Kept to the projects
          # directory rather than $HOME to bound that.
          config.whitelist.prefix = [ projects ];
        };
      };

    nixos = {
      # Approvals for directories *outside* the whitelist still live here, so
      # preserve them across the rollback — same treatment as .cache/nix-index
      # in the nix-helpers aspect.
      preservation.preserveAt."/persistent" = {
        users.snregales.directories = [
          ".local/share/direnv"
        ];
      };
    };

    tests =
      { direnv, ... }:
      {
        direnv-has-homeManager = {
          expr = direnv ? homeManager;
          expected = true;
        };
        direnv-has-nixos = {
          expr = direnv ? nixos;
          expected = true;
        };
      };
  };

  den.default.includes = [ den.aspects.direnv ];
}
