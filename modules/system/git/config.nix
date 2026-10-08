{ config, pkgs, mail, username, ... }:

{
  services.ssh-agent.enable = true; 
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "github.com" = {
        hostname = "ssh.github.com";
        port = 443;
        user = "git";
	identityFile = "~/.ssh/id_ed25519";
      };
      "gitlab.com" = {
        hostname = "altssh.gitlab.com";
        port = 443;
        user = "git";
        identityFile = "~/.ssh/id_ed25519";
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
