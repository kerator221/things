{ config, pkgs, mail, username, ... }:

{
  services.ssh-agent.enable = true; 
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "github.com" = {
        hostname = "://github.com";
        port = 443;
        user = "git";
      };
    };
  };
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "${username}";
        email = "${mail}";
      };
      alias = {
        c = "commit";
        s = "status";
        p = "push";
      };
    };
  };

}