#!/usr/bin/bash

#Fedora:
function _fedora_devpkg {
	supass  dnf install -y nano git geany thunderbird  zsh fish curl aria2 p7zip augeas augeas-devel subversion mercurial expect dnf-plugins-core util-linux-user
	supass  dnf install -y make automake gcc gcc-c++ kernel-devel  
	#groupinstall "Development Tools" "Development Libraries"
}

function _fedora_optimimat {
     #/etc/gdm/custom.conf file:

    # GDM configuration storage

    #[daemon]
# Uncoment the line below to force the login screen to use Xorg
#WaylandEnable=false

#[security]
 echo ""
}

function _fedora_regrup {
    sudo dnf reinstall grub2-efi grub2-efi-modules shim
    sudo grub2-mkconfig -o /boot/efi/EFI/fedora/grub.cfg
    ###for ubutnu  change uuid in /etc/fstab 
}

#intall oracle java
function _fedora_itjava  {
	jdk_version=$1
	jdk_file=/tmp/jdk-$jdk_version-linux-x64.rpm

    if [ ! -f $jdk_file  ]
	then
          read jdk_url
	  echo get JDK: $jdk_url
	  wget --header='Cookie: oraclelicense=accept-securebackup-cookie' $jdk_url -O $jdk_file
	fi        
        
	echo install Oracle JDK: jdk-$jdk_version-linux-x64.rpm
	supass rpm -Uvh $jdk_file
	supass alternatives --install /usr/bin/java java /usr/java/latest/jre/bin/java 200000
	supass alternatives --install /usr/bin/javaws javaws /usr/java/latest/jre/bin/javaws 200000
	supass alternatives --install /usr/lib64/mozilla/plugins/libjavaplugin.so libjavaplugin.so.x86_64 /usr/java/latest/jre/lib/amd64/libnpjp2.so 200000
	supass alternatives --install /usr/bin/javac javac /usr/java/latest/bin/javac 200000
	supass alternatives --install /usr/bin/jar jar /usr/java/latest/bin/jar 200000

    supass alternatives --config java
    supass alternatives --config javaws
    supass alternatives --config ibjavaplugin.so.x86_64    
    supass alternatives --config javac  
}
 
function _fedora_itchrome {
   if read -t 10 -q "choice?Is it installed from File [Y|N]:"  ; then 
            if  [ ! -f /tmp/VirtualBox-${version}.rpm ]; then
               echo ""
               echo -n "Enter virutualbox download url and press [ENTER]: "
               read vbdownloadurl
               echo ""
               aria2c -c -x 10 -j 10  -d/tmp -o VirtualBox-${version}.rpm  $vbdownloadurl               
            fi
            supass dnf install -y /tmp/VirtualBox-${version}.rpm
   else
      chrome_file="/etc/yum.repos.d/google-chrome.repo"
      [[ -a  $chrome_file ]] && supass rm -f $chrome_file
   
      supass cp $MAX_SHELL/google-chrome.repo  /etc/yum.repos.d/google-chrome.repo

      supass dnf install -y google-chrome-stable
      #supass dnf install google-chrome-beta
      #supass dnf install google-chrome-unstable
   fi   
}


#itdocker or itdocker fix [first|all]
function _fedora_itdocker {
	supass dnf remove docker docker-common container-selinux  docker-selinux  docker-engine    
    supass dnf config-manager --add-repo  https://download.docker.com/linux/fedora/docker-ce.repo
    supass dnf makecache fast
    supass dnf install -y docker-ce
}

function _fedora_itrkt {	
  #supass dnf install rkt
  gpg --recv-key 18AD5014C99EF7E3BA5F6CE950BDD3E0FC8A365E
  wget https://github.com/coreos/rkt/releases/download/v1.25.0/rkt-1.25.0-1.x86_64.rpm
  wget https://github.com/coreos/rkt/releases/download/v1.25.0/rkt-1.25.0-1.x86_64.rpm.asc
  gpg --verify rkt-1.25.0-1.x86_64.rpm.asc
  supass rpm -Uvh rkt-1.25.0-1.x86_64.rpm	
  supass setenforce Permissive
  supass firewall-cmd --add-source=172.16.28.0/24 --zone=trusted
}

function _fedora_itvirtualBox {	
	version=$1
	
	[[ -a  /etc/yum.repos.d/virtualbox.repo ]] && supass rm -rf  /etc/yum.repos.d/virtualbox.repo
 
    supass wget -q  http://download.virtualbox.org/virtualbox/rpm/fedora/virtualbox.repo -O /etc/yum.repos.d/virtualbox.repo
    supass wget -q  https://www.virtualbox.org/download/oracle_vbox.asc  -O /tmp/oracle_vbox.asc
    supass rpm --import  /tmp/oracle_vbox.asc    
    supass dnf update
	supass dnf install -y dkms VirtualBox-${version}
}

function _fedora_itvagrant {
	version=$1
      
	if [ ! -f /tmp/vagrant_${version}_x86_64.rpm  ]
	then
	  echo get https://releases.hashicorp.com/vagrant/${version}/vagrant_${version}_x86_64.rpm
	  aria2c -c -x 10 -j 10  -d/tmp -o vagrant_${version}_x86_64.rpm  https://releases.hashicorp.com/vagrant/${version}/vagrant_${version}_x86_64.rpm
	fi

	supass dnf install -y /tmp/vagrant_${version}_x86_64.rpm 	
}

function _fedora_itfileserver {
	#/etc/exports
	#/ubuntu  *(ro,sync,no_root_squash)
    #/home    *(rw,sync,no_root_squash)
    #client (dnf -y install nfs-utils)
    #vi /etc/idmapd.conf
    # line 5: uncomment and change to your domain name
    #Domain = srv.world
    #systemctl start(enable) rpcbind 
    #mount -t nfs dlp.srv.world:/home /home 
    # /etc/fstab
    # dlp.srv.world:/home /home     nfs     defaults        0 0
    
        supass dnf -y install nfs-utils
        #vi /etc/idmapd.conf
        #Domain = srv.world
	supass systemctl start rpcbind nfs-server 
	supass systemctl enable rpcbind nfs-server 
	supass  firewall-cmd --add-service=nfs --permanent 
	supass firewall-cmd --reload 
	
	supass dnf -y install samba samba-client
	supass  mkdir /home/share
	supass  chmod 777 /home/share
	sudo augtool <<-EOF
set "/files/etc/samba/smb.conf/target[*][.='global']/unix charset" UTF-8
set /files/etc/samba/smb.conf/target[*][.="global"]/workgroup maxkerrer
set "/files/etc/samba/smb.conf/target[*][.='global']/map to guest" "Bad User"
set "/files/etc/samba/smb.conf/target[*][.='global']/hosts allow" "127.10.0.0"
set /files/etc/samba/smb.conf/target[last()+1] share
set /files/etc/samba/smb.conf/target[last()]/comment "Ubuntu File Server Share"
set /files/etc/samba/smb.conf/target[last()]/path    /srv/samba/share
set /files/etc/samba/smb.conf/target[last()]/browsable  yes
set "/files/etc/samba/smb.conf/target[last()]/guest ok"  yes
set "/files/etc/samba/smb.conf/target[last()]/read only"  no
set "/files/etc/samba/smb.conf/target[last()]/create mask" 0755
save
quit
EOF
    supass systemctl start smb nmb 
    supass  systemctl enable smb nmb 
    supass  firewall-cmd --add-service=samba --permanent 
    supass  firewall-cmd --reload 
    
    #selunux on
    supass  setsebool -P samba_enable_home_dirs on
    supass restorecon -R /home/share 
}
