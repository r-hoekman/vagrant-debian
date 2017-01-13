elasticsearch:
  # The exact version of elastic search to install.
  version: 2.3.*

  # The version for the apt repository.
  repo_version: 2.x

  config:
    cluster:
      name: "The crypt of clogs"
    network:
      host: '["_local_", "_site_"]'
    discovery:
      zen_ping_multicast_enabled: "false"
