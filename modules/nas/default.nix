{
  dotfileFolder,
  ...
}:

{
  services.copyparty = {
    enable = true;
    user = "copyparty";
    group = "copyparty";
    # directly maps to values in the [global] section of the copyparty config.
    # see `copyparty --help` for available options
    settings = {
      i = "0.0.0.0";
      # use lists to set multiple values
      p = [
        3210
        3211
      ];
      # use booleans to set binary flags
      no-reload = true;
      # using 'false' will do nothing and omit the value when generating a config
      ignored-flag = false;
    };

    # create users
    accounts = {
      fantomitechno = {
        passwordFile = "${dotfileFolder}/modules/nas/pswd/copyparty-fantom";
      };
    };
  };
}
