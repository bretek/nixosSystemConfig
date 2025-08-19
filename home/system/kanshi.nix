{ ... }:
{
  services.kanshi = {
    enable = true;
    settings = [
      #{
      #  profile.name = "home_office";
      #  profile.outputs = [
      #    {
      #      criteria = "DP-1";
      #      status = "enable";
      #    }
      #    {
      #      criteria = "eDP-1";
      #      status = "disable";
      #    }
      #  ];
      #}
      {
        profile.name = "home_office";
        profile.outputs = [
          {
            criteria = "DP-1";
            status = "enable";
            adaptiveSync = false;
            mode = "1920x1080@60Hz";
          }
          {
            criteria = "eDP-1";
            status = "disable";
          }
        ];
      }
      {
        profile.name = "home_office_displaylink";
        profile.outputs = [
          {
            #criteria = "DP-1";
            criteria = "DVI-I-1";
            status = "enable";
          }
          {
            criteria = "eDP-1";
            status = "disable";
          }
        ];
      }
      {
        profile.name = "undocked";
        profile.outputs = [
          {
            criteria = "eDP-1";
            status = "enable";
          }
        ];
      }
    ];
  };
}
