let
  machines = {
    hodgepodge = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAyf11lgJo/CVqXfE7OoyW9HV/64+UBf623It/LJPfGm";
  };

  trustedUsers = import ./authorized-keys.nix;

  servers = with machines; [];
  workstations = with machines; [
    hodgepodge
  ];
  allMachines = servers ++ workstations;
in {
  "wireless.env.age".publicKeys = allMachines ++ trustedUsers;
}
