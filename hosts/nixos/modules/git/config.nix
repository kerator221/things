{ config, pkgs, mail, username ... }:

{
  programs.ssh.startAgent = true; 
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