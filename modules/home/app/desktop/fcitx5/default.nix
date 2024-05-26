{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
with lib.capybara; let
  cfg = config.capybara.app.desktop.fcitx5;
in {
  options.capybara.app.desktop.fcitx5 = {
    enable = mkBoolOpt false "Whether to enable the fcitx5 mozc";
  };

  config = mkIf cfg.enable {
    i18n.inputMethod = {
      enabled = "fcitx5";
      fcitx5.addons = with pkgs; [
        fcitx5-mozc
        fcitx5-gtk
      ];
    };

    xdg.configFile."fcitx5" = {
      source = ./config;
      recursive = true;
    };
  };
}
