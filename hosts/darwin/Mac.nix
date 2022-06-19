{
  config,
  pkgs,
  suites,
  ...
}: {
  imports = with suites; basic;
}
