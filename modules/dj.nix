{pkgs, ...}:
{
    environment.systemPackages = with pkgs; [
        mixxx
        spotdl
        yt-dlp
  ];
}
