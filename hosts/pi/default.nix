{
  imports =
    [
      ../../modules/common
      ../../modules/networking
      ../../modules/user
    ];

  desktopEnv.enable = false;
  homeNetwork.enable = true;
  hostname = "pi";
}

