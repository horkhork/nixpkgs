 {config, pkgs, lib, ...}:
 
 let
   cfg = config.services.dnscrypt-proxy2-blacklist-updater;
 in
 
 with lib;
 
 {
   options = {
     services.dnscrypt-proxy2-blacklist-updater = {
       enable = mkOption {
         default = false;
         type = with types; bool;
         description = ''
           Enable a blacklist updater for dnscrypt-proxy2
         '';
       };
 
       user = mkOption {
         default = "root";
         type = with types; uniq string;
         description = ''
           Name of the user.
         '';
       };
     };
   };
 
   config = mkIf cfg.enable {
     #systemd.services.ircSession = {
     #  wantedBy = [ "multi-user.target" ]; 
     #  after = [ "network.target" ];
     #  description = "Start the irc client of username.";
     #  serviceConfig = {
     #    Type = "forking";
     #    User = "${cfg.user}";
     #    ExecStart = ''${pkgs.screen}/bin/screen -dmS irc ${pkgs.irssi}/bin/irssi'';         
     #    ExecStop = ''${pkgs.screen}/bin/screen -S irc -X quit'';
     #  };
     #};

     services.cron = {
       enable = true;
       systemCronJobs = [
         "0 0 * * *      ${cfg.user}    ${pkgs.dnscrypt-proxy2-blacklist-updater}/bin/generate-domains-blacklist.py -i -c ${pkgs.dnscrypt-proxy2-blacklist-updater}/domains-blacklist.conf -r ${pkgs.dnscrypt-proxy2-blacklist-updater}/domains-time-restricted.txt -w ${pkgs.dnscrypt-proxy2-blacklist-updater}/domains-whitelist.txt > /var/lib/dnscrypt-proxy2/dnscrypt-proxy-blacklist.txt"
       ];
     };
 
     environment.systemPackages = [ pkgs.dnscrypt-proxy2 pkgs.dnscrypt-proxy2-blacklist-updater ];
   };
 }
