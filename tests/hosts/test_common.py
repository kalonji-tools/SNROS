"""Tests that should pass on any SNROS host."""


def test_user_snregales_exists(host):
    user = host.user("snregales")
    assert user.exists


def test_nix_daemon_running(host):
    service = host.service("nix-daemon")
    assert service.is_running
    assert service.is_enabled


def test_nixos_rebuild_available(host):
    cmd = host.run("which nixos-rebuild")
    assert cmd.rc == 0


def test_nix_flake_enabled(host):
    cmd = host.run("nix flake --help")
    assert cmd.rc == 0
