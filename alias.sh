## -----------------------------------------------------------------------------------------
## Created by Vivek Gite <vivek@nixcraft.com>
## See for more info: http://www.cyberciti.biz/tips/linux-unix-osx-bash-shell-aliases.html
## Note: I work a lot with Amazon EC2/CDN/Akamai/Server Backups etc so source code of those 
## scripts not included in this file. YMMV.
## -----------------------------------------------------------------------------------------
alias ls='ls --color=auto'
alias ll='ls -la'
alias l.='ls -d .* --color=auto'
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../../../'
alias ....='cd ../../../../'
alias .....='cd ../../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../..'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias bc='bc -l'
alias sha1='openssl sha1'
alias mkdir='mkdir -pv'
alias diff='colordiff'
alias mount='mount |column -t'
alias h='history'
alias j='jobs -l'
alias path='echo -e ${PATH//:/\\n}'
alias now='date +"%T'
alias nowtime=now
alias nowdate='date +"%d-%m-%Y"'
alias vi=vim
alias svi='sudo vi'
alias vis='vim "+set si"'
alias edit='vim'
alias ping='ping -c 5'
alias fastping='ping -c 100 -s.2'
alias ports='netstat -tulanp'
alias wakeupnas01='/usr/bin/wakeonlan 00:11:32:11:15:FC'
alias wakeupnas02='/usr/bin/wakeonlan 00:11:32:11:15:FD'
alias wakeupnas03='/usr/bin/wakeonlan 00:11:32:11:15:FE'
alias ipt='sudo /sbin/iptables'
alias iptlist='sudo /sbin/iptables -L -n -v --line-numbers'
alias iptlistin='sudo /sbin/iptables -L INPUT -n -v --line-numbers'
alias iptlistout='sudo /sbin/iptables -L OUTPUT -n -v --line-numbers'
alias iptlistfw='sudo /sbin/iptables -L FORWORD -n -v --line-numbers'
alias firewall=iptlist
alias header='curl -I'
alias headerc='curl -I --compress'
alias rm='rm -I --preserve-root'
alias mv='mv -i'
alias cp='cp -i'
alias ln='ln -i'
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'
alias apt-get="sudo apt-get"
alias updatey="sudo apt-get --yes"
alias update='sudo apt-get upgrade && sudo apt-get update'
#alias update='yum update'
#alias updatey='yum -y update'
alias root='sudo -i'
alias su='sudo -i'
alias reboot='sudo /sbin/reboot'
alias poweroff='sudo /sbin/poweroff'
alias halt='sudo /sbin/halt'
alias shutdown='sudo /sbin/shutdown'
alias nginxreload='sudo /usr/local/nginx/sbin/nginx -s reload'
alias nginxtest='sudo /usr/local/nginx/sbin/nginx -t'
alias lightyload='sudo /etc/init.d/lighttpd reload'
alias lightytest='sudo /usr/sbin/lighttpd -f /etc/lighttpd/lighttpd.conf -t'
alias httpdreload='sudo /usr/sbin/apachectl -k graceful'
alias httpdtest='sudo /usr/sbin/apachectl -t && /usr/sbin/apachectl -t -D DUMP_VHOSTS'
alias backup='sudo /home/scripts/admin/scripts/backup/wrapper.backup.sh --type local --taget /raid1/backups'
alias nasbackup='sudo /home/scripts/admin/scripts/backup/wrapper.backup.sh --type nas --target nas01'
alias s3backup='sudo /home/scripts/admin/scripts/backup/wrapper.backup.sh --type nas --target nas01 --auth /home/scripts/admin/.authdata/amazon.keys'
alias rsnapshothourly='sudo /home/scripts/admin/scripts/backup/wrapper.rsnapshot.sh --type remote --target nas03 --auth /home/scripts/admin/.authdata/ssh.keys --config /home/scripts/admin/scripts/backup/config/adsl.conf'
alias rsnapshotdaily='sudo  /home/scripts/admin/scripts/backup/wrapper.rsnapshot.sh --type remote --target nas03 --auth /home/scripts/admin/.authdata/ssh.keys  --config /home/scripts/admin/scripts/backup/config/adsl.conf'
alias rsnapshotweekly='sudo /home/scripts/admin/scripts/backup/wrapper.rsnapshot.sh --type remote --target nas03 --auth /home/scripts/admin/.authdata/ssh.keys  --config /home/scripts/admin/scripts/backup/config/adsl.conf'
alias rsnapshotmonthly='sudo /home/scripts/admin/scripts/backup/wrapper.rsnapshot.sh --type remote --target nas03 --auth /home/scripts/admin/.authdata/ssh.keys  --config /home/scripts/admin/scripts/backup/config/adsl.conf'
alias amazonbackup=s3backup
alias playavi='mplayer *.avi'
alias vlc='vlc *.avi'
alias playwave='for i in *.wav; do mplayer "$i"; done'
alias playogg='for i in *.ogg; do mplayer "$i"; done'
alias playmp3='for i in *.mp3; do mplayer "$i"; done'
alias nplaywave='for i in /nas/multimedia/wave/*.wav; do mplayer "$i"; done'
alias nplayogg='for i in /nas/multimedia/ogg/*.ogg; do mplayer "$i"; done'
alias nplaymp3='for i in /nas/multimedia/mp3/*.mp3; do mplayer "$i"; done'
alias music='mplayer --shuffle *'
alias dnstop='dnstop -l 5  eth1'
alias vnstat='vnstat -i eth1'
alias iftop='iftop -i eth1'
alias tcpdump='tcpdump -i eth1'
alias ethtool='ethtool eth1'
alias iwconfig='iwconfig wlan0'
alias meminfo='free -m -l -t'
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'
alias pscpu='ps auxf | sort -nr -k 3'
alias pscpu10='ps auxf | sort -nr -k 3 | head -10'
alias cpuinfo='lscpu'
alias gpumeminfo='grep -i --color memory /var/log/Xorg.0.log'
alias rebootlinksys="curl -u 'admin:my-super-password' 'http://192.168.1.2/setup.cgi?todo=reboot'"
alias reboottomato="ssh admin@192.168.1.1 /sbin/reboot"
alias wget='wget -c'
alias ff4='/opt/firefox4/firefox'
alias ff13='/opt/firefox13/firefox'
alias chrome='/opt/google/chrome/chrome'
alias opera='/opt/opera/opera'
alias ff=ff13
alias browser=chrome 
alias df='df -H'
alias du='du -ch'
alias top='atop'
alias nfsrestart='sync && sleep 2 && /etc/init.d/httpd stop && umount netapp2:/exports/http && sleep 2 && mount -o rw,sync,rsize=32768,wsize=32768,intr,hard,proto=tcp,fsc natapp2:/exports /http/var/www/html &&  /etc/init.d/httpd start'
alias mcdstats='/usr/bin/memcached-tool 10.10.27.11:11211 stats'
alias mcdshow='/usr/bin/memcached-tool 10.10.27.11:11211 display'
alias flushmcd='echo "flush_all" | nc 10.10.27.11 11211'
alias cdndel='/home/scripts/admin/cdn/purge_cdn_cache --profile akamai'
alias amzcdndel='/home/scripts/admin/cdn/purge_cdn_cache --profile amazon'
alias cdnmdel='/home/scripts/admin/cdn/purge_cdn_cache --profile akamai --stdin'
alias amzcdnmdel='/home/scripts/admin/cdn/purge_cdn_cache --profile amazon --stdin'
