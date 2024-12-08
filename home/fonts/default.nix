{pkgs, config, ...}:
{
home.packages = [
pkgs.fontconfig
    (pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; })
];
fonts.fontconfig.enable = true;
}
