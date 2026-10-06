{ config, pkgs, mail, username ... }:

{
  programs.ssh.startAgent = true; 
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
        name = ${username};
        email = ${mail};
      };
      alias = {
        c = "commit";
        s = "status";
        p = "push";
      };
    };
  };

}