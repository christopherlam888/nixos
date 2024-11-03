{ config, pkgs, ... }:
let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";
in
{
  imports = [
    (import "${home-manager}/nixos")
  ];

  home-manager.backupFileExtension = "backup";

  home-manager.users.cc = {
    /* The home.stateVersion option does not have a default and must be set */
    home.stateVersion = "24.11";
    /* Here goes the rest of your home-manager config, e.g. home.packages = [ pkgs.foo ]; */
    home.packages = with pkgs; [
    ];

    programs.home-manager.enable = true;

    programs.bash.enable = true;
    programs.bash.shellAliases = {
      ls="eza";
      config="sudo lvim /etc/nixos/configuration.nix";
      rebuild="sudo nixos-rebuild switch";
      update="sudo nix-channel --update";
      clean="sudo nix store gc";
      delete="sudo nix-collect-garbage -d";
      chat="llama-server -m ~/models/Mistral-7B-Instruct-v0.3-Q4_K_M.gguf";
      chatc="llama-server -m ~/models/Nxcode-CQ-7B-orpo-Q4_K_M.gguf";
    };

    programs.starship = {
      enable = true;
      settings = pkgs.lib.importTOML ./starship.toml;
    };

    programs.zoxide.enable = true;

    programs.git.enable = true;
    programs.git.userName = "Christopher Lam";
    programs.git.userEmail = "christopher.peter.lam@gmail.com";

    home.sessionVariables = {
      EDITOR = "lvim";
    };

    xdg.mimeApps = {
      enable = true;
      
      defaultApplications = {
        "text/html" = "brave-browser.desktop";
        "x-scheme-handler/http" = "brave-browser.desktop";
        "x-scheme-handler/https" = "brave-browser.desktop";
        "x-scheme-handler/about" = "brave-browser.desktop";
        "x-scheme-handler/unknown" = "brave-browser.desktop";
        "application/pdf" = ["org.pwmt.zathura.desktop"];
      };
    };
    # https://discourse.nixos.org/t/set-default-application-for-mime-type-with-home-manager/17190/4

    home.pointerCursor = {
      gtk.enable = true;
      # x11.enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 16;
    };

    gtk = {
      enable = true;

      theme = {
        package = pkgs.flat-remix-gtk;
        name = "Flat-Remix-GTK-Grey-Darkest";
      };

      iconTheme = {
        package = pkgs.gnome.adwaita-icon-theme;
        name = "Adwaita";
      };

      font = {
        name = "Sans";
        size = 11;
      };
    };
  };
}
