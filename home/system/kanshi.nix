{ ... }:
{
  services.kanshi = {
    enable = true;
    settings = [
      {
        profile.name = "home_office";
        profile.outputs = [
          {
            criteria = "DP-1";
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
