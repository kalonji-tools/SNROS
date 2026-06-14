_: {
  perSystem =
    { pkgs, ... }:
    {
      checks = {
        vm-minimal-boot = pkgs.testers.runNixOSTest {
          name = "minimal-boot";
          nodes.machine = {
            system.stateVersion = "25.11";
          };
          testScript = ''
            machine.wait_for_unit("default.target")
            machine.succeed("nixos-rebuild --help")
          '';
        };
      };
    };
}
