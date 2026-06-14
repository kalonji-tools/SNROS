import pytest


def pytest_addoption(parser):
    parser.addoption(
        "--host",
        action="store",
        default="local://",
        help="testinfra connection string (e.g., ssh://dell-xps-9640)",
    )


@pytest.fixture(scope="session")
def host(request, testinfra_backend=None):
    import testinfra

    connection = request.config.getoption("--host")
    return testinfra.get_host(connection)
