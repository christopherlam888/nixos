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
  };
}