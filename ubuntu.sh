#!/bin/bash
#Ubuntu:

function _ubuntu_devpkg {
   	supass apt-get install -y nano git geany thunderbird  zsh fish curl aria2 augeas-tools libaugeas-dev subversion mercurial expect ppa-purge
	supass apt-get install -y build-essential 
	#groupinstall "Development Tools" "Development Libraries"
}

function _ubuntu_optimimat {
    #/etc/gdm/custom.conf file:
    # GDM configuration storage
    #[daemon]
    # Uncoment the line below to force the login screen to use Xorg
    #WaylandEnable=false
    #[security]
    echo ""
}

function _ubuntu_regrup {
    echo "" 
}


#intall oracle java
function _ubuntu_itjava  {
	jdk_version=$1
	supass add-apt-repository ppa:webupd8team/java
	#supass apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C2518248EEA14886
    supass apt-get -y  update
    supass apt-get -y  install oracle-java${jdk_version}-installer
    supass ln -s /usr/lib/jvm/java-8-oracle /usr/lib/jvm/latest
}
 
function _ubuntu_itchrome {
	if read -t 10 -q "choice?Is it installed from File [Y|N]:"  ; then 
       if  [ ! -f /tmp/VirtualBox-${version}.deb ]; then
               echo ""
               echo -n "Enter virutualbox download url and press [ENTER]: "
               read vbdownloadurl
               echo ""
               aria2c -c -x 10 -j 10  -d/tmp -o VirtualBox-${version}.deb  $vbdownloadurl               
        fi
        supass apt install -y /tmp/VirtualBox-${version}.deb
    else
      chrome_file="/etc/apt/sources.list.d/google-chrome.list"
      [[ -a  $chrome_file ]] && supass rm -f $chrome_file
   
      supass cp $MAX_SHELL/google-chrome.list  /etc/apt/sources.list.d/google-chrome.list

      wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | supass apt-key add - 
      supass apt-get -y update 
      supass apt-get -y install google-chrome-stable
   fi
}


#itdocker or itdocker fix [first|all]
function _ubuntu_itdocker {	
	supass  apt-get update
    supass apt-get install -y --no-install-recommends  linux-image-extra-$(uname -r)  linux-image-extra-virtual
    supass apt-get install -y --no-install-recommends  apt-transport-https   ca-certificates   curl   software-properties-common
    
    curl -fsSL https://apt.dockerproject.org/gpg | supass apt-key add -   
    apt-key fingerprint 58118E89F3A912897C070ADBF76221572C52609D
    supass add-apt-repository \
       "deb https://apt.dockerproject.org/repo/ \
       ubuntu-$(lsb_release -cs) \
       main"
    supass apt-get update
    supass apt-get -y install docker-engine
}



function _ubuntu_itrkt {	
	#supass apt-get install rkt
    gpg --recv-key 18AD5014C99EF7E3BA5F6CE950BDD3E0FC8A365E
    wget https://github.com/coreos/rkt/releases/download/v1.25.0/rkt_1.25.0-1_amd64.deb
    wget https://github.com/coreos/rkt/releases/download/v1.25.0/rkt_1.25.0-1_amd64.deb.asc
    gpg --verify rkt_1.25.0-1_amd64.deb.asc
    supass dpkg -i rkt_1.25.0-1_amd64.deb	
}

function _ubuntu_itvirtualBox {	
	version=$1
	[ -a  /etc/apt/sources.list.d/virtualbox.list ] && supass rm -rf  /etc/apt/sources.list.d/virtualbox.list	  
    
    echo 'deb http://download.virtualbox.org/virtualbox/debian xenial contrib' | supass tee  /etc/apt/sources.list.d/virtualbox.list
    wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc  -O /tmp/oracle_vbox_2016.asc
    supass apt-key add /tmp/oracle_vbox_2016.asc
    
    supass apt-get update
	supass apt-get install -y dkms VirtualBox-${version}
}



function _ubuntu_itvagrant {
	version=$1
	 
	if [ ! -f /tmp/vagrant_${version}_x86_64.deb  ]
	then
	  echo https://releases.hashicorp.com/vagrant/${version}/vagrant_${version}_x86_64.deb
	  aria2c -c -x 10 -j 10  -d/tmp -o vagrant_${version}_x86_64.deb  https://releases.hashicorp.com/vagrant/${version}/vagrant_${version}_x86_64.deb && 
	fi
    
	supass apt-get install /tmp/vagrant_${version}_x86_64.deb 		
}


function _ubuntu_itfileserver {
	#/etc/exports
	#/ubuntu  *(ro,sync,no_root_squash)
    #/home    *(rw,sync,no_root_squash)
    #client (supass apt install nfs-common)
    #supass mount example.hostname.com:/ubuntu /local/ubuntu
    # /etc/fstab
    # example.hostname.com:/ubuntu /local/ubuntu nfs rsize=8192,wsize=8192,timeo=14,intr
	supass apt install -y nfs-kernel-server
	supass systemctl start nfs-kernel-server.service
	
	supass apt install -y samba
	supass apt install libpam-winbind
	supass augtool <<-EOF
set /files/etc/samba/smb.conf/target[*][.="global"]/workgroup maxkerrer
set /files/etc/samba/smb.conf/target[*][.="global"]/security user
set /files/etc/samba/smb.conf/target[301] share
set /files/etc/samba/smb.conf/target[301]/comment "Ubuntu File Server Share"
set /files/etc/samba/smb.conf/target[301]/path    /srv/samba/share
set /files/etc/samba/smb.conf/target[301]/browsable  yes
set "/files/etc/samba/smb.conf/target[301]/guest ok"  yes
set "/files/etc/samba/smb.conf/target[301]/read only"  no
set "/files/etc/samba/smb.conf/target[301]/create mask" 0755
save
quit
EOF
    supass mkdir -p /srv/samba/share
    supass chown nobody:nogroup /srv/samba/share/
    supass systemctl restart smbd.service nmbd.service
}
