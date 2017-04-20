#!/bin/bash
#Ubuntu:
#prep:
# 1. install zsh and chsh zsh
# 2. conf cpan "o conf urllist  unshift http://mirrors.aliyun.com/CPAN/"
#1. install geany nano git mercurial 
#2. install build essential(build tool dev) 
#3. install java (openjdk/oracle jdk)http://www.if-not-true-then-false.com/2010/install-sun-oracle-java-jdk-jre-7-on-fedora-centos-red-hat-rhel/
#4. install virtualbox
#5. install vagant
#6. install docker
#7. pull vagran images  ubuntu centos
#8. pull docker container  drupal,joomla,wordpress,mongdb,jenkins,redmine,registry,sonatype/nexus3,odoo.vimagick/opencart,alexcheng/magento,zeromq/zeromq,webcenter/activemq,rakudo-star,golang,java,ruby,perl,python
#9. rbenv,pyenv,nvm,gvm,sdk

echo "Hello World!"
MAX_HOME="/home/max"
MAX_SHELL="/work/max"

export JAVA_HOME=/usr/lib/jvm/latest
export GOROOT_BOOTSTRAP=$MAX_HOME/bin/go1.4
export PATH=$PATH:$JAVA_HOME/bin

LOGINPASSWD="mmmm"

LOG_FILE="$MAX_HOME/install_log"


alias supass="echo $LOGINPASSWD | sudo -S "
echo progress-bar >> $MAX_HOME/.curlrc
########################################################################
#colors for echo
########################################################################
# Reset
Color_Off='\033[0m'       # Text Reset
Color_End='\x1B[0m'
# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

# Bold
BBlack='\033[1;30m'       # Black
BRed='\033[1;31m'         # Red
BGreen='\033[1;32m'       # Green
BYellow='\033[1;33m'      # Yellow
BBlue='\033[1;34m'        # Blue
BPurple='\033[1;35m'      # Purple
BCyan='\033[1;36m'        # Cyan
BWhite='\033[1;37m'       # White

# Underline
UBlack='\033[4;30m'       # Black
URed='\033[4;31m'         # Red
UGreen='\033[4;32m'       # Green
UYellow='\033[4;33m'      # Yellow
UBlue='\033[4;34m'        # Blue
UPurple='\033[4;35m'      # Purple
UCyan='\033[4;36m'        # Cyan
UWhite='\033[4;37m'       # White

# Background
On_Black='\033[40m'       # Black
On_Red='\033[41m'         # Red
On_Green='\033[42m'       # Green
On_Yellow='\033[43m'      # Yellow
On_Blue='\033[44m'        # Blue
On_Purple='\033[45m'      # Purple
On_Cyan='\033[46m'        # Cyan
On_White='\033[47m'       # White

# High Intensity
IBlack='\033[0;90m'       # Black
IRed='\033[0;91m'         # Red
IGreen='\033[0;92m'       # Green
IYellow='\033[0;93m'      # Yellow
IBlue='\033[0;94m'        # Blue
IPurple='\033[0;95m'      # Purple
ICyan='\033[0;96m'        # Cyan
IWhite='\033[0;97m'       # White

# Bold High Intensity
BIBlack='\033[1;90m'      # Black
BIRed='\033[1;91m'        # Red
BIGreen='\033[1;92m'      # Green
BIYellow='\033[1;93m'     # Yellow
BIBlue='\033[1;94m'       # Blue
BIPurple='\033[1;95m'     # Purple
BICyan='\033[1;96m'       # Cyan
BIWhite='\033[1;97m'      # White

# High Intensity backgrounds
On_IBlack='\033[0;100m'   # Black
On_IRed='\033[0;101m'     # Red
On_IGreen='\033[0;102m'   # Green
On_IYellow='\033[0;103m'  # Yellow
On_IBlue='\033[0;104m'    # Blue
On_IPurple='\033[0;105m'  # Purple
On_ICyan='\033[0;106m'    # Cyan
On_IWhite='\033[0;107m'   # White

########################################################################
#docker and rkt images for kubernetes
########################################################################
 #flannel version from coreos
 #/usr/lib/systemd/system/flannel-docker-opts.service
 #/usr/lib/systemd/system/flanneld.service
VAR=$(cat <<'END_HEREDOC'
rkt     quay.io/coreos/flannel:v0.7.0
docker  quay.io/coreos/flannel:v0.7.0
rkt     quay.io/coreos/flannel:v0.6.2
rkt     quay.io/coreos/hyperkube:v1.5.3_coreos.0
docker  quay.io/coreos/hyperkube:v1.5.3_coreos.0
docker  gcr.io/google_containers/kubedns-amd64:1.9
docker  gcr.io/google_containers/kube-dnsmasq-amd64:1.4
docker  gcr.io/google_containers/dnsmasq-metrics-amd64:1.0
docker  gcr.io/google_containers/exechealthz-amd64:1.2
docker  gcr.io/google_containers/cluster-proportional-autoscaler-amd64:1.0.0 
docker  gcr.io/google_containers/heapster:v1.2.0
docker  gcr.io/google_containers/addon-resizer:1.6 
docker  gcr.io/google_containers/kubernetes-dashboard-amd64:v1.5.0
docker  quay.io/calico/node:v0.23.0
docker  quay.io/calico/cni:v1.5.2 
docker  calico/kube-policy-controller:v0.4.0

docker  gcr.io/google_containers/kube-proxy-amd64:v1.5.3         
docker  gcr.io/google_containers/kube-controller-manager-amd64:v1.5.3         
docker  gcr.io/google_containers/kube-scheduler-amd64:v1.5.3         
docker  gcr.io/google_containers/kube-apiserver-amd64:v1.5.3         
docker  gcr.io/google_containers/etcd-amd64:3.0.14-kubeadm 
docker  gcr.io/google_containers/kube-discovery-amd64:1.0            
docker  gcr.io/google_containers/pause-amd64:3.0

docker  gcr.io/google-samples/gb-frontend:v4
docker  gcr.io/google_containers/redis:e2e
docker  gcr.io/google_samples/gb-redisslave:v1
END_HEREDOC
)	

########################################################################


#if [[ ! -d $MAX_HOME/.oobash ]]; then
#	git clone https://github.com/niieani/bash-oo-framework.git $MAX_HOME/.oobash
#fi 	
#source "/home/max/.oobash/lib/oo-bootstrap.sh"

#exec 3>&1 1>>${LOG_FILE} 2>&1
#echo "This is stdout"
#echo "This is stderr" 1>&2
#echo "This is the console (fd 3)" 1>&3
#echo "This is both the log and the console" | tee /dev/fd/3

devpkg (){
	supass apt-get install -y nano git geany thunderbird  zsh fish curl aria2 augeas-tools libaugeas-dev subversion mercurial expect ppa-purge
	supass apt-get install -y build-essential 
	#groupinstall "Development Tools" "Development Libraries"
}

itwork(){
	if [[ $# < 2 ]]; then
	   echo ""
	   echo "  Usage: itwork [sdX for work] [sdx for job]"
	   echo ""
	   echo "       Exmaple: itwork sdb1 db2 "
	   echo ""
	   echo ""
	   return 1
	fi
	
	WORK_DEV=$1
	JOB_DEV=$2
	if [[ ! -d /work ]]; then
	  supass mkdir /work
	fi
	
	if [[ ! -d /job ]]; then
	  supass mkdir /job
	fi
	
    supass chown -R max:max /work /job
    workuuid=$(supass blkid /dev/$WORK_DEV | awk  '{print $3}')
    jobuuid=$(supass blkid /dev/$JOB_DEV | awk  '{print $3}')
    echo "mount $WORK_DEV for $workuuid"
    supass mount $workuuid /work
    echo "mount $JOB_DEV for $jobuuid"
    supass mount $jobuuid /job
    
    echo "add  /work /job to /etc/fstab"
    supass augtool <<-EOF
set /files/etc/fstab/100/spec $workuuid
set /files/etc/fstab/100/file /work
set /files/etc/fstab/100/vfstype ext4
set /files/etc/fstab/100/opt defaults
set /files/etc/fstab/100/dump 1
set /files/etc/fstab/100/passno 1
save
quit
EOF
     supass augtool <<-EOF
set /files/etc/fstab/101/spec $jobuuid
set /files/etc/fstab/101/file /job
set /files/etc/fstab/101/vfstype ext4
set /files/etc/fstab/101/opt defaults
set /files/etc/fstab/101/dump 1
set /files/etc/fstab/101/passno 1
save
quit
EOF
  supass mount -a

}

function ithost {
    echo "change hosts from here"
    supass augtool <<-EOF
set /files/etc/hosts/201/ipaddr 127.0.0.1
set /files/etc/hosts/201/canonical proxy.tdocker.com
save
quit
EOF

supass augtool <<-EOF
set /files/etc/hosts/202/ipaddr 127.0.0.1
set /files/etc/hosts/202/canonical repo.tdocker.com
save
quit
EOF
}

_install_zsh(){
	if [[ -d $MAX_HOME/.oh-my-zsh ]]; then
	  echo oh-my-zsh exist. Remove it firstly!
	  tar zcf $MAX_HOME/oh-my-zsh-backup_$(date +%F-%kh%M).tar.gz -C  $MAX_HOME/.oh-my-zsh
	  rm -rf $MAX_HOME/.oh-my-zsh
	fi 
	
	git clone git://github.com/robbyrussell/oh-my-zsh.git $MAX_HOME/.oh-my-zsh
	 
	if [[ -a  $MAX_HOME/.zshrc ]]; then
     echo zshrc: $chrome_file exist. Remove it firstly!
     mv $MAX_HOME/.zshrc $MAX_HOME/.zshrc.$(date +%F-%kh%M).ori
    fi
	
	cp $MAX_HOME/.oh-my-zsh/templates/zshrc.zsh-template $MAX_HOME/.zshrc
	sed -i  -e 's/^ZSH_THEME=.*/ZSH_THEME="candy"/' -e 's/^plugins=.*/plugins=(rails git ruby Composer coffee cpanm docker gem github lein mercurial node npm perl pip vagrant)/' $MAX_HOME/.zshrc
	echo 'source /work/max/ubuntu.sh' >> $MAX_HOME/.zshrc
}

_install_fish(){
	if [[ -d $MAX_HOME/.oh-my-fish ]]; then
	  echo oh-my-fish exist. Remove it firstly!
	  tar zcf $MAX_HOME/oh-my-fish-backup_$(date +%F-%kh%M).tar.gz -C $MAX_HOME/.oh-my-fish
	  rm -rf $MAX_HOME/.oh-my-fish
	fi 
	
	git clone https://github.com/oh-my-fish/oh-my-fish $MAX_HOME/.oh-my-fish
	cd $MAX_HOME/.oh-my-fish
	bin/install --offline
	cd ~
}

_sh_alias(){
   alias a2c="aria2c -c -x 10 -j 10"	
   source ./max/.alias.sh
}
#zsh/fish
itshtheme () {	
	_install_zsh  || { 
	   echo "install zsh fail"
	   exit 1	
	}
	
	_install_fish  || { 
	   echo "install fish fail"
	   exit 1	
	}
}

itlang(){
	#supass apt-get install -y ibus-pinyin
	#ibus restart
	
	#supass add-apt-repository ppa:fcitx-team/nightly
	#supass apt-get update
	
	
	supass apt-get install fcitx fcitx-pinyin fcitx-sunpinyin fcitx-googlepinyin fcitx-anthy fcitx-mozc
	wget http://http.us.debian.org/debian/pool/main/o/open-gram/sunpinyin-data_0.1.22+20131212-1_amd64.deb -O /tmp/sunpinyin-data_0.1.22+20131212-1_amd64.deb
	supass dpkg -i  /tmp/sunpinyin-data_0.1.22+20131212-1_amd64.deb
    im-config
}

#/home/max/bin
itbin(){
	ACT="new"
	if [ ! -z "$1" ] && [[ "$1" = "fix" ]]; then
	  ACT="fix"
	fi	
	
	INSTALL_LOG="$MAX_HOME/bin/.installed"
	
	[ -d "$MAX_HOME/bin" ] ||  mkdir $MAX_HOME/bin
	[ -f "$INSTALL_LOG" ] ||  touch $INSTALL_LOG	 
	
	declare -A hashmap
    hashmap[lein]="https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein"
    hashmap[phpunit]="https://phar.phpunit.de/phpunit.phar"
    hashmap[composer]="https://getcomposer.org/composer.phar"
    hashmap[symfony]="https://symfony.com/installer"
    hashmap[drush]="http://files.drush.org/drush.phar"
    array=( lein phpunit composer symfony drush)# Reset

    for it in "${array[@]}"
    do
	   EXCUTOR=$it
       GETURL=${hashmap[$it]}
       if [ "$ACT" = "new" ] || ( [ "$ACT" = "fix" ] && ! grep -q $EXCUTOR $INSTALL_LOG ) ; then
         if [ "$ACT" = "new" ] && [ -e "$MAX_HOME/bin/$EXCUTOR" ] ; then
             rm -rf "$MAX_HOME/bin/$EXCUTOR"
         fi
         
	     echo "Installing $EXCUTOR..."
	     wget $GETURL -O $MAX_HOME/bin/$EXCUTOR
         chmod +x  $MAX_HOME/bin/$EXCUTOR
	     echo "$EXCUTOR"  >> $INSTALL_LOG
	   else
	     echo "Installed $EXCUTOR" 
	   fi
    done	

    
    wget https://releases.hashicorp.com/packer/0.12.2/packer_0.12.2_linux_amd64.zip -O /tmp/packer_0.12.2_linux_amd64.zip
    cd  /tmp && unzip packer_0.12.2_linux_amd64.zip && mv packer $MAX_HOME/bin/
    chmod +x  $MAX_HOME/bin/packer
    
    wget http://www.rarlab.com/rar/rarlinux-5.4.0.tar.gz -O /tmp/rarlinux-5.4.0.tar.gz
    cd /tmp && tar xvzf rarlinux-5.4.0.tar.gz  && mv rar $MAX_HOME/bin/
    chmod -R $MAX_HOME/bin/rar/
    
    wget https://github.com/containers/build/releases/download/v0.4.0/acbuild-v0.4.0.tar.gz -O  /tmp/acbuild-v0.4.0.tar.gz
    cd /tmp && tar xvzf acbuild-v0.4.0.tar.gz 
    

}

#intall oracle java
itjava () {
	if [ -z "$1" ]
	then
	   echo ""
	   echo "     Usage: itjava [java version: 7 8 0]"
	   echo ""
	   echo ""
	   return 1
	fi
	
	jdk_version=$1
	supass add-apt-repository ppa:webupd8team/java
	#supass apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C2518248EEA14886
    supass apt-get -y  update
    supass apt-get -y  install oracle-java${jdk_version}-installer
    supass ln -s /usr/lib/jvm/java-8-oracle /usr/lib/jvm/latest
}
 
itchrome(){
   chrome_file="/etc/apt/sources.list.d/google-chrome.list"
   if [[ -a  $chrome_file ]]; then
     echo File: $chrome_file exist. Remove it firstly!
     supass rm -f $chrome_file
   fi
   
   supass sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
   wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | supass apt-key add - 
   supass apt-get -y update 
   supass apt-get -y install google-chrome-stable
}

#jenv for java (http://www.jenv.be/)


#rbenv for ruby rails puppet
itrbenv(){
	ruby_version=""
	if [ ! -z "$1" ]; then
	   if [ "$1" = "help" ]; then
	      echo ""
	      echo "     Usage: itrbenv [$ruby version]"
	      echo ""
	      echo ""
	      return 0
	   else
	      ruby_version=$1
	   fi	   
	fi
	
	if [[ -d $MAX_HOME/.rbenv ]]; then
	  echo rbenv exist. Remove it firstly!
	  tar zcf $MAX_HOME/rbenv-backup_$(date +%F-%kh%M).tar.gz -C $MAX_HOME/ .rbenv
	  rm -rf $MAX_HOME/.rbenv
	fi 
	
	git clone https://github.com/rbenv/rbenv.git $MAX_HOME/.rbenv
	git clone https://github.com/rbenv/ruby-build.git $MAX_HOME/.rbenv/plugins/ruby-build
	
	if [ ! -z  $ruby_version ]; then
	   ldrbenv
	   rbenv install $ruby_version
	   rbenv local $ruby_version
	fi
	
}

itrvm(){	
	if [[ -d $MAX_HOME/.rvm ]]; then
	  echo rvm exist. Remove it firstly!
	  #tar zcvf $MAX_HOME/rvm-backup_$(date +%F-%kh%M).tar.gz -C $MAX_HOME/ .rvm
	  rm -rf $MAX_HOME/.rvm
	fi 	
	#gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
	curl -SL https://rvm.io/mpapis.asc | gpg2 --import -
	curl -SL https://get.rvm.io | bash -s stable --ruby=jruby --gems=rails,puma,hirb  --ignore-dotfiles
	source $HOME/.rvm/scripts/rvm
    rvm list
}

ittest(){
 	
}


#sdk and scala maven ant gradle activator
_itsdk_fix(){
	echo "Installing sdk candidates,Waitting......."
	ldsdk
	candidates=( ant gradle grails  griffon groovy groovyserv jbossforge leiningen maven sbt scala springboot vertx)
	for i in "${candidates[@]}"
    do
	    sdk current | grep $i || sdk install $i
    done
}

itsdk(){
	if [ ! -z "$1" ] && [[ "$1" = "fix" ]]; then
	   echo "You had choosed to fix sdk  candidates"
	   _itsdk_fix
	   return 0
	fi
    
    echo "Installing new sdkman..............."
    if [[ -d $MAX_HOME/.sdkman ]]; then
	  echo sdkman exist. Remove it firstly!
	  tar zcvf $MAX_HOME/sdkman-backup_$(date +%F-%kh%M).tar.gz -C $MAX_HOME/ .sdkman
	  rm -rf $MAX_HOME/.sdkman
	fi 
	curl -s "https://get.sdkman.io" | bash
	sed -i "s/sdkman_disable_gvm_alias=false/sdkman_disable_gvm_alias=true/" $MAX_HOME/.sdkman/etc/config
	sed -i '/sdkman/d' $MAX_HOME/.zshrc
	sdk version
	_itsdk_fix
}

#nvm for nodejs
itnvm(){
	node_version=""
	if [ ! -z "$1" ]; then
	   if [ "$1" = "help" ]; then
	      echo ""
	      echo "     Usage: itnvm [$node version]"
	      echo ""
	      echo ""
	      return 0
	   else
	      node_version=$1
	      echo "use node vesion: ${node_version}"
	   fi	   
	fi
	
	
	
    if [[ -d $MAX_HOME/.nvm ]]; then
	  echo "nvm exist. Remove it firstly!"
	  #tar zcvf $MAX_HOME/nvm-backup_$(date +%F-%kh%M).tar.gz -C $MAX_HOME/ .nvm
	  rm -rf $MAX_HOME/.nvm
	fi 
    export NVM_DIR="$HOME/.nvm" && (
     git clone https://github.com/creationix/nvm.git "$NVM_DIR"
     cd "$NVM_DIR"
     git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" origin`
    ) && . "$NVM_DIR/nvm.sh"
  
   command -v nvm  
    echo "use node vesion: ${node_version}"
   if [ ! -z  $node_version ]; then
       echo "intalling node ${node_version} ......."
	   nvm install $node_version
	   nvm use $node_version
	   nvm current
	fi

}

upnvm(){
   (
     cd "$NVM_DIR"
     git fetch origin
     git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" origin`
   ) && . "$NVM_DIR/nvm.sh"	
}

#gvm for golang
itgvm(){
  if [[ -d $MAX_HOME/.gvm ]]; then
	  echo oh-my-fish exist. Remove it firstly!
	  tar zcf $MAX_HOME/gvm-backup_$(date +%F-%kh%M).tar.gz -C $MAX_HOME/.gvm
	  rm -rf $MAX_HOME/.gvm
  fi 
	
  supass apt install -y bison
  bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)	
}

#perlbrew for perl 5
_itperl_fix(){
  #o conf  urllist unshift http://mirrors.aliyun.com/CPAN/
  #o conf commit
  supass  perl -MCPAN -e 'install App::cpanminus'
  supass  cpanm  Capture::Tiny 
  supass  cpanm Dancer2  Catalyst::Devel Mojolicious
}


itperl(){
   if [ ! -z "$1" ] && [[ "$1" = "fix" ]]; then
	  echo "You had choosed to fix perl modules"
	  _itperl_fix
	  return 0
   fi
	
    curl -L https://install.perlbrew.pl | bash	
}
#rakudobrew for perl 6

itvala(){
   supass add-apt-repository ppa:vala-team
   supass apt-get update
   supass apt-get install val	
}

#docker and pull docker images
_itdocker_fix(){
	echo "\e[1;31m Installing docker images,Waiting ........................  \e[0m"
	action="all"
	if [ ! -z "$1" ]; then
	   action="$1"
	fi
	
	images_file=""
	if [ "$action" = "first" ]; then
	   images_file="$MAX_SHELL/docker_images_first"
	elif [ "$action" = "all" ]; then
	   images_file="$MAX_SHELL/docker_images"
	fi
	
	if [ ! -z  $images_file ]; then
	   while read line
       do     
          name=`echo $line | awk -F ' ' '{print $1}'`
          if [[ "$name" = "REPOSITORY" ]] ; then
             continue
          fi
          tag=`echo $line | awk -F ' ' '{print $2}'`
      
          supass docker images | grep "$name.*$tag" ||  supass docker pull $name:$tag         
      
          #sed -e "s/\__FULLNAME\__:/\ $n $l :/g;s/\__Project__/\ $p /g" Reminder.email > sendnow.txt
       done < $images_file
	fi	
}


#itdocker or itdocker fix [first|all]
itdocker(){
	if [ ! -z "$1" ] && [[ $# -ge 2 ]] && [[ "$1" = "fix" ]]; then
	   echo "You had choosed to fix docker images"
	   _itdocker_fix $2
	   return 0
	fi
	
	echo "\e[1;31m  Installing new docker ........................  \e[0m"
	supass  apt-get update
    supass apt-get install -y --no-install-recommends  linux-image-extra-$(uname -r)  linux-image-extra-virtual
    supass apt-get install -y --no-install-recommends \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common
    
    curl -fsSL https://apt.dockerproject.org/gpg | supass apt-key add -   
    apt-key fingerprint 58118E89F3A912897C070ADBF76221572C52609D
    supass add-apt-repository \
       "deb https://apt.dockerproject.org/repo/ \
       ubuntu-$(lsb_release -cs) \
       main"
    supass apt-get update
    supass apt-get -y install docker-engine
    
    grep -i "^docker" /etc/group ||  supass groupadd docker 
	id -Gn "max" | grep -qc "docker" || supass usermod -a -G docker max
	supass service enable docker
	supass service start docker
	supass docker run hello-world

    _itdocker_fix first
    
    _itdocker_box
}



_itdocker_box(){
	supass docker run -d --restart=always -p 5000:5000 \
         --name docker-proxy \
         -h proxy.tdocker.com  \
         -v /job/cache/docker/proxy:/var/lib/registry \
         registry:2 /var/lib/registry/config.yml 
     
     
    sduo docker run -d --restart=always -p 5001:5000 \
         --name docker-repo \
         -h repo.tdocker.com \
         -v /job/cache/docker/repo:/var/lib/registry  \
         registry:2 /var/lib/registry/config.yml
      
    supass docker run --name apt-cacher-ng -d --restart=always \
         --publish 3142:3142  \
         --volume /job/cache/apt:/var/cache/apt-cacher-ng  \
         sameersbn/apt-cacher-ng

    supass docker run --name squid -d --restart=always \
         --publish 3128:3128 \
         --volume /job/cache/squid/squid.conf:/etc/squid3/squid.conf \
         --volume /job/cache/squid/cache:/var/spool/squid3 \
         sameersbn/squid
  
    supass docker run --name nginx -d -p 8082:80 \
         -v /job/cache/nginx/html:/usr/share/nginx/html \
         nginx

    supass docker run -d --restart=always -p 2525:8081 --name nexus \
         -v /job/cache/nexus:/nexus-data \
         sonatype/nexus3

    supass docker run -d --restart=always --name jenkins -p 3131:8080 -p 50000:50000 \
         -v /job/cache/jenkins/home:/var/jenkins_home \
         jenkins

}
#virtualbox vagrant and pull vagrant boxes

itrkt(){
	
	#supass apt-get install rkt
  gpg --recv-key 18AD5014C99EF7E3BA5F6CE950BDD3E0FC8A365E
wget https://github.com/coreos/rkt/releases/download/v1.25.0/rkt_1.25.0-1_amd64.deb
wget https://github.com/coreos/rkt/releases/download/v1.25.0/rkt_1.25.0-1_amd64.deb.asc
gpg --verify rkt_1.25.0-1_amd64.deb.asc
supass dpkg -i rkt_1.25.0-1_amd64.deb	
}

itbox(){
	if [ -z "$1" ]
	then
	   echo ""
	   echo "     Usage: itbox [VirtualBox Version]"
	   echo ""
	   echo ""
	   return 1
	fi
	
	version=$1
	
	if [[ -a  /etc/apt/sources.list.d/virtualbox.list ]]; then
	  echo virtualbox repo exist. Remove it firstly!
	  supass rm -rf  /etc/apt/sources.list.d/virtualbox.list
	fi 
	
	if dpkg -l | grep -qw VirtualBox-${version}; then
       supass apt-get autoremove -y VirtualBox-${version}
    fi   
    
    echo 'deb http://download.virtualbox.org/virtualbox/debian xenial contrib' | supass tee  /etc/apt/sources.list.d/virtualbox.list
    wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc  -O /tmp/oracle_vbox_2016.asc
    supass apt-key add /tmp/oracle_vbox_2016.asc
    
    supass apt-get update
	supass apt-get install -y dkms VirtualBox-${version}

	grep -i "^vboxusers" /etc/group ||  supass groupadd vboxusers 
	id -Gn "max" | grep -qc "vboxusers" || supass usermod -a -G vboxusers max
	
	#VBoxManage list extpacks
	#supass VBoxManage extpack install Oracle_VM_VirtualBox_Extension_Pack-4.3.12-93733.vbox-extpack
	#supass VBoxManage extpack uninstall "Oracle VM VirtualBox Extension Pack"
	
	#rpm -qa | grep -qw glibc-static || yum install glibc-static
	#debian:dpkg -l | grep -qw package || apt-get install package
	#arch:pacman -Qq | grep -qw package || pasman -S package
}

_itvagrant_fix(){
	if [ -z "$1" ]; then
	   return 0
	fi
	
	if [ "$1" = "plugin" ]; then
	   echo "Installing plugins,Waitting........"
	   cut -f 1 -d "(" $MAX_SHELL/vagrant-plugins | cat | while read VGPLUGIN; do
         vagrant plugin list | grep $VGPLUGIN || vagrant plugin install $VGPLUGIN
       done
	elif [ "$1" = "box" ]; then
	   echo "Installing boxes,Waitting........"
	   cut -f 1 -d "(" $MAX_SHELL/vagrant-boxes | cat | while read VGBOX; do
         vagrant box list | grep $VGBOX || vagrant box add $VGBOX --provider virtualbox
       done
	fi
}


itvagrant(){
	if [ -z "$1" ]; then
	   echo ""
	   echo "     Usage: itvagrant [Vagrant Version]"
	   echo ""
	   echo ""
	   return 1
	elif [[ $# -ge 2 ]] && [[ "$1" = "fix" ]]; then
	   _itvagrant_fix $2
	   return 0
	fi
	
	
	version=$1
	if  rpm -qa | grep -qw vagrant; then
       supass dnf remove -y  vagrant
    fi
    #supass rpm -Uvh $MAX_HOME/.max/vagrant_1.9.1_x86_64.rpm 
    echo https://releases.hashicorp.com/vagrant/${version}/vagrant_${version}_x86_64.deb
	aria2c -c -x 10 -j 10  -d/tmp -o vagrant_${version}_x86_64.deb  https://releases.hashicorp.com/vagrant/${version}/vagrant_${version}_x86_64.deb && \
	supass apt-get install /tmp/vagrant_${version}_x86_64.deb 
	_itvagrant_fix plugin
	_itvagrant_fix box
		
}



##virtualenvwrapper
itenv(){
  pip install virtualenvwrapper
  export WORKON_HOME=$MAX_HOME/Envs
  mkdir -p $WORKON_HOME
  source /usr/local/bin/virtualenvwrapper.sh	
  mkvirtualenv env1
}

_itpython_fix(){
   if ! type nano  > /dev/null; then
      echo "Can not find pip"
      wget https://bootstrap.pypa.io/get-pip.py -O /tmp/get-pip.py
   fi
   
   supass python /tmp/get-pip.py
   supass  pip install Django==1.10.5	
   supass  pip install Flask
}


##pyenv https://github.com/yyuu/pyenv, pyenv-virtualenv https://github.com/yyuu/pyenv-virtualenv
itpython(){
  if [ ! -z "$1" ] && [[ "$1" = "fix" ]]; then
	   echo "You had choosed to fix python  candidates"
	   _itpython_fix
	   return 0
  fi
	
  git clone https://github.com/yyuu/pyenv.git $MAX_HOME/.pyenv	
  git clone https://github.com/yyuu/pyenv-virtualenv.git $MAX_HOME/.pyenv/plugins/pyenv-virtualenv
  ldpyenv
  if [ ! -z "$1" ]; then
    for ver in "$@"
    do
        pyenv install $ver
    done
  fi
}

itfileserver(){
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

### ssh config and ssh for github ( $MAX_HOME/.ssh)

### stormpath maxkerrer@live.com 1tw ($MAX_HOME/.stormpath)

###/etc/host , /etc/fstab, $MAX_HOME/.zshrc  /etc/pip.conf 

### backup .vagrant.d/   /var/lib/docker

### $MAX_HOME/.m2/setting 

####clitools for https://github.com/webdev# Reset


###travis for travis-ci.com


### $MAX_HOME/.stormpath/apiKey.properties for https://api.stormpath.com  salty-squall:mk@live:1t9


##mulesoft maxkerrer 1tWS


#cas /etc/cas

########################################################################
ldsdk () {
  export SDKMAN_DIR="$MAX_HOME/.sdkman"
  [[ -s "$MAX_HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$MAX_HOME/.sdkman/bin/sdkman-init.sh" 
}

ldgvm () {
  [[ -s "$MAX_HOME/.gvm/scripts/gvm" ]] && source "$MAX_HOME/.gvm/scripts/gvm"
}

ldnvm () {
  export NVM_DIR="$MAX_HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
}

ldjenv () {
   export PATH="$HOME/.jenv/bin:$PATH"
   eval "$(jenv init -)"
}

ldperlbrew () {
   source $MAX_HOME/perl5/perlbrew/etc/bashrc
}

ldrakudobrew () {
   export PATH=$MAX_HOME/.rakudobrew/bin:$PATH
   rakudobrew init 
}

ldrbenv () {
   export PATH="$HOME/.rbenv/bin:$PATH"
   eval "$(rbenv init -)"
   type rbenv
}

ldrvm () {
   source $HOME/.rvm/scripts/rvm
   #export PATH="$PATH:$HOME/.rvm/bin"
   #rvm list known
}

ldenvwrap() {
   export WORKON_HOME=$MAX_HOME/Envs
   source /usr/bin/virtualenvwrapper.sh
}

ldpyenv () {
   export PYENV_ROOT="$HOME/.pyenv"
   export PATH="$PYENV_ROOT/bin:$PATH"
   eval "$(pyenv init -)"
   eval "$(pyenv virtualenv-init -)"
}


ldcoreoskubernetes(){
   echo "Current Dir: $(pwd)"
   export KUBECONFIG="${KUBECONFIG}:$(pwd)/kubeconfig"
   kubectl config use-context vagrant-multi
   kubectl config set-cluster vagrant-multi-cluster --server=https://172.17.4.101:443 --certificate-authority=${PWD}/ssl/ca.pem
   kubectl config set-credentials vagrant-multi-admin --certificate-authority=${PWD}/ssl/ca.pem --client-key=${PWD}/ssl/admin-key.pem --client-certificate=${PWD}/ssl/admin.pem
   kubectl config set-context vagrant-multi --cluster=vagrant-multi-cluster --user=vagrant-multi-admin
   kubectl config use-context vagrant-multi
}

function ldmirrors {
  echo "cpan"
  
  echo "gem"
  
  echo "python pip"	
  
}

ldvagrantkubernetetes(){
   export KUBERNETES_PROVIDER=vagrant
   export KUBERNETES_MASTER_MEMORY=1536
   export KUBERNETES_NODE_MEMORY=4096
   export KUBE_ENABLE_INSECURE_REGISTRY=true
}

function itdockerimages {
	while read line; do
		[ -z "$line" ]  && continue || echo "$line"
 
		conType=$(echo $line | awk  '{print $1}')
		conImage=$(echo $line | awk  '{print $2}')
		imageName=$(echo $conImage | awk -F:  '{print $1}')
		imageVersion=$(echo $conImage | awk -F: '{print $2}')
		imageBase="${imageName##*/}"
		if [[ "rkt" = "$conType" ]]; then 
			supass rkt image list | grep -s "$imageName.*$imageVersion" ||  supass rkt fetch $imageName:$imageVersion  
			supass rkt image export  $imageName:$imageVersion "/job/images/${imageBase}_${imageVersion}.aci"
		elif [[ "docker" = "$conType" ]]; then
			supass docker images | grep -s "$imageName.*$imageVersion" ||  supass docker pull $imageName:$imageVersion  
			supass docker save $imageName:$imageVersion > "/job/images/${imageBase}_${imageVersion}.tar"
		fi
		supass chmod -R 0777 /job/images
	done <<< "$VAR"
}


function ldimages {
	echo -e "I ${Red}love Stack Overflow"

	controllerImgs=(start flannel hyperkube kubedns-amd64 kube-dnsmasq-amd64 dnsmasq-metrics-amd64 exechealthz-amd64 cluster-proportional-autoscaler-amd64 heapster addon-resizer kubernetes-dashboard-amd64 node cni kube-policy-controller end)

	workerImgs=(start flannel hyperkube gb-frontend redis gb-redisslave end)
	kubadmimgs=(start kube-apiserver-amd64 kube-controller-manager-amd64 kube-scheduler-amd64 kube-proxy-amd64 etcd-amd64 pause-amd64 k8s-dns-sidecar-amd64 k8s-dns-kube-dns-amd64 k8s-dns-dnsmasq-nanny-amd64 end)

	while read line; do
		[ -z "$line" ]  && continue || echo -e "${Green}$line${Color_End}"
 
		conType=$(echo $line | awk  '{print $1}')
		conImage=$(echo $line | awk  '{print $2}')
		imageName=$(echo $conImage | awk -F:  '{print $1}')
		imageVersion=$(echo $conImage | awk -F: '{print $2}')
		imageBase="${imageName##*/}"
 
		[[ "${controllerImgs[@]}" =~ " $imageBase " ]] && echo "$(tput setaf 1)$(tput setab 7)Load $imageBase.... $(tput sgr0)" || continue

                if [[ "rkt" = "$conType" ]]; then 
                    supass  rkt image list | grep -s "$imageName.*$imageVersion" ||  supass rkt fetch --insecure-options=image "/images/${imageBase}_${imageVersion}.aci"
                elif [[ "docker" = "$conType" ]]; then
                    supass  docker images | grep -s "$imageName.*$imageVersion" ||  supass docker load < "/images/${imageBase}_${imageVersion}.tar"
                fi 
4
	done <<< "$VAR"
}

########################################################################
########################################################################
#test
ittestperl(){
  ${MAX_HOME}/.max/perltest.pl sdfafafa asdfasfas  || echo failure	
  

}

ittestpython(){
	/job/shell/test.py sdfafafa asdfasfas  || echo failure	
}

ldtest(){
	echo $(pwd)
}
