{metadata, ...}: {
  networking.hostName = metadata.hostName;

  networking.firewall = {
    enable = true;
    allowPing = false;
  };
}
