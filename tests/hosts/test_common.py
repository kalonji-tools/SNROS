"""Tests that should pass on any SNROS host."""

from oxi_nixinfra import Host
from oxitest import Fixture


def test_user_snregales_exists(host: Fixture[Host]) -> None:
    user = host.user("snregales")
    assert user.exists(), "user snregales should exist"


def test_nix_daemon_running(host: Fixture[Host]) -> None:
    service = host.service("nix-daemon")
    assert service.is_running(), "nix-daemon should be running"
    assert service.is_managed(), "nix-daemon should be managed by NixOS"


def test_nixos_rebuild_available(host: Fixture[Host]) -> None:
    cmd = host.run("which", "nixos-rebuild")
    assert cmd.succeeded(), "nixos-rebuild should be available"


def test_nix_flake_enabled(host: Fixture[Host]) -> None:
    cmd = host.run("nix", "flake", "--help")
    assert cmd.succeeded(), "nix flake should be enabled"
