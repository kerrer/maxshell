#!/usr/bin/bash

echo "Hello World!"
MAX_SHELL="$HOME/max"
SDK_HOME=$HOME/sdk

export JAVA_HOME=/usr/java/latest
#export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk
export PATH=$PATH:$JAVA_HOME/bin:
export CLASSPATH="${CLASSPATH}:$SDK_HOME/libs"
LOGINPASSWD="mmmm"
LOG_FILE="$HOME/install_log"

OSNAME=`python -c "import platform;print(platform.linux_distribution()[0])"`
alias supass="echo $LOGINPASSWD | sudo -S "
alias supath='sudo env "PATH=$PATH" '
echo progress-bar >> $HOME/.curlrc

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
###################################/usr/bin/javaws#####################################
 #flannel version from coreos
 #/usr/lib/systemd/system/flannel-docker-opts.service
 #/usr/lib/systemd/system/flanneld.service
VAR=$(cat <<'END_HEREDOC'
rkt     quay.io/coreos/flannel:v0.7.0
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

#if [[ ! -d $HOME/.oobash ]]; then
#	git clone https://github.com/niieani/bash-oo-framework.git $HOME/.oobash
#fi 	
#source "$HOME/.oobash/lib/oo-bootstrap.sh"

#exec 3>&1 1>>${LOG_FILE} 2>&1
#echo "This is stdout"
#echo "This is stderr" 1>&2
#echo "This is the console (fd 3)" 1>&3
#echo "This is both the log and the console" | tee /dev/fd/3

. $(dirname $0)/ubuntu.sh
. $(dirname $0)/fedora.sh

function init {
	alias supass="echo $LOGINPASSWD | sudo -S "
    alias supath='sudo env "PATH=$PATH" '
    
    alias cttfc="cd /work/ttfc"
    alias cproject="cd /work/project"
    echo progress-bar >> $HOME/.curlrc
    
    
}

function setAll {
	### $HOME/.m2/setting 
    cp $MAX_SHELL/maven/m2/settings.xml $HOME/.m2/
}

function itpkgs {
   case  $OSNAME  in
      Fedora)       
          _fedora_devpkg
          ;;
      Ubuntu)
          _ubuntu_devpkg
          ;;           
      *)              
   esac 	
}


function optimimat {
   case  $OSNAME  in
      Fedora)       
          _fedora_optimimat
          ;;
      Ubuntu)
          _ubuntu_optimimat
          ;;           
      *)              
   esac 
}

function grep_repaire {
   case  $OSNAME  in
      Fedora)       
          _fedora_regrup
          ;;
      Ubuntu)
          _ubuntu_regrup
          ;;           
      *)              
   esac 
}

function itmirrors {
	#os
	case  $OSNAME  in
      Fedora)       
          supass mv /etc/yum.repos.d/fedora.repo /etc/yum.repos.d/fedora.repo.backup
          supass mv /etc/yum.repos.d/fedora-updates.repo /etc/yum.repos.d/fedora-updates.repo.backup
          supass wget -O /etc/yum.repos.d/fedora.repo http://mirrors.aliyun.com/repo/fedora.repo
          supass wget -O /etc/yum.repos.d/fedora-updates.repo http://mirrors.aliyun.com/repo/fedora-updates.repo
          supass yum makecache
          ;;
      Ubuntu)
          
          ;;           
      *)              
    esac 
    
    
    
    #pip [see itpython pip]
    
    #cpan
    # perl -MCPAN -e shell
    # o conf  urllist unshift http://mirrors.aliyun.com/CPAN/
    # o conf commit
    case  $OSNAME  in
      Fedora)       
          mkdir -p /root/.local/share/.cpan/CPAN/
          cp $MAX_SHELL/MyConfig.pm /root/.local/share/.cpan/CPAN/MyConfig.pm
          ;;
      Ubuntu)
          mkdir -p $HOME/.cpan/CPAN/
          cp $MAX_SHELL/MyConfig.pm $HOME/.cpan/CPAN/MyConfig.pm
          ;;           
      *)              
    esac    
    
    supass   perl -MCPAN -e 'install App::cpanminus'
    cpanm  Capture::Tiny Git::Hooks Path::Class
    cpanm Dancer2  Catalyst::Devel Mojolicious
    cpanm Parallel::Prefork
  

    #gem
    ldrbenv
    gem sources --add https://gems.ruby-china.org/ --remove https://rubygems.org/
    #bundle config mirror.https://rubygems.org https://gems.ruby-china.org	
    #Gemfile 
    #source 'https://rubygems.org/'
    gem sources -l
    gem install rails   --no-document
    gem install foreman --no-document
    gem install puppet  --no-document
    gem install r10k	--no-document
   
    
    
    #npm 
    npm install -g cnpm --registry=https://registry.npm.taobao.org
    #alias cnpm="npm --registry=https://registry.npm.taobao.org  --cache=$HOME/.npm/.cache/cnpm --disturl=https://npm.taobao.org/dist --userconfig=$HOME/.cnpmrc"
    cnpm install -g foreman
}

function itansible {
   supass dnf install -y 	redhat-rpm-confi   python-devel
   sudo pip install -i http://pypi.douban.com/simple/  --trusted-host pypi.douban.com ansible
   
   ip=$( ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1' | grep 192.168.0 )
   supass midir /etc/ansible
   echo $ip | sudo tee /etc/ansible/hosts
   
   echo "[defaults]\nhost_key_checking = False" | sudo tee /etc/ansible/ansible.cfg
}

function itwork {
    #You must change all disk label name firstly!
    ##############################################
	if [[ $# < 2 ]]; then
	   echo ""
	   echo "  Usage: itwork [sdX for work] [sdX for job] [sdx for job sdx for Downloads]"
	   echo ""
	   echo "       Exmaple: itwork sdb1 db2 [sb3]"
	   echo ""
	   echo ""
	   return 1
	fi
	
	WORK_DEV=$1
	JOB_DEV=$2
   
    [[ -d /work ]] || { supass mkdir /work && supass chown -R max:max /work }
	
	[[ -d /job  ]] || { supass mkdir /job  && supass chown -R max:max /job }
	
    workuuid=$(supass  blkid /dev/$WORK_DEV | awk  '{print $3}')
    jobuuid=$(supass blkid /dev/$JOB_DEV | awk  '{print $3}')  
    
    echo "add  /work /job  to /etc/fstab"
    supass cp /etc/fstab /etc/fstab_$(date +%F-%kh%M)
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
     if [ ! -z "$3" ]
     then
        echo "add  Download  to /etc/fstab"
        DOWN_DEV=$3
        downuuid=$(supass blkid /dev/$DOWN_DEV | awk  '{print $3}')
        supass augtool <<-EOF
set /files/etc/fstab/102/spec $downuuid
set /files/etc/fstab/102/file "$HOME/Downloads"
set /files/etc/fstab/102/vfstype ext4
set /files/etc/fstab/102/opt defaults
set /files/etc/fstab/102/dump 1
set /files/etc/fstab/102/passno 1
save
quit
EOF
     fi
     
    supass mount -a
}


function itlang {
	#supass apt-get install -y ibus-pinyin
	#ibus restart
	
	#supass add-apt-repository ppa:fcitx-team/nightly
	#supass apt-get update
	
	
	supass apt-get install fcitx fcitx-pinyin fcitx-sunpinyin fcitx-googlepinyin fcitx-anthy fcitx-mozc
	wget http://http.us.debian.org/debian/pool/main/o/open-gram/sunpinyin-data_0.1.22+20131212-1_amd64.deb -O /tmp/sunpinyin-data_0.1.22+20131212-1_amd64.deb
	supass dpkg -i  /tmp/sunpinyin-data_0.1.22+20131212-1_amd64.deb
    im-config
}
function infcitx {
   supass dnf install fcitx fcitx-devel fcitx-configtool fcitx-pinyin 
   export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"
fcitx &
   #super 运行 fcitx configtool 删除所有输入法 +（add） 添加 English (US) 和 Pinyin
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

function _install_zsh {
	if [[ -d $HOME/.oh-my-zsh ]]; then
	  echo oh-my-zsh exist. Remove it firstly!
	  tar zcf $HOME/oh-my-zsh-backup_$(date +%F-%kh%M).tar.gz -C  $HOME/.oh-my-zsh
	  rm -rf $HOME/.oh-my-zsh
	fi 
	
	git clone git://github.com/robbyrussell/oh-my-zsh.git $HOME/.oh-my-zsh
	 
	if [[ -a  $HOME/.zshrc ]]; then
     echo zshrc: $chrome_file exist. Remove it firstly!
     mv $HOME/.zshrc $HOME/.zshrc.$(date +%F-%kh%M).ori
    fi
	
	cp $HOME/.oh-my-zsh/templates/zshrc.zsh-template $HOME/.zshrc
	sed -i  -e 's/^ZSH_THEME=.*/ZSH_THEME="candy"/' -e 's/^plugins=.*/plugins=(rails git ruby Composer coffee cpanm docker gem github lein mercurial node npm perl pip vagrant)/' $HOME/.zshrc
	echo "source ${MAX_SHELL}/max.sh" >> $HOME/.zshrc
}

function _install_fish {
	if [[ -d $HOME/.oh-my-fish ]]; then
	  echo oh-my-fish exist. Remove it firstly!
	  tar zcf $HOME/oh-my-fish-backup_$(date +%F-%kh%M).tar.gz -C $HOME/.oh-my-fish
	  rm -rf $HOME/.oh-my-fish
	fi 
	
	git clone https://github.com/oh-my-fish/oh-my-fish $HOME/.oh-my-fish
	cd $HOME/.oh-my-fish
	bin/install --offline
	cd ~
}

function _sh_alias {
   alias a2c="aria2c -c -x 10 -j 10"	
   source $MAX_SHELL/alias.sh
}


#zsh/fish
function itshtheme {	
	_install_zsh  || { 
	   echo "install zsh fail"
	   exit 1	
	}
	
	_install_fish  || { 
	   echo "install fish fail"
	   exit 1	
	}
}

function itssh {
  mkdir $HOME/.ssh
  cp $MAX_SHELL/ssh/* $HOME/.ssh/
  chmod 700 $HOME/.ssh
  chmod 600 $HOME/.ssh/authorized_keys
}

#$HOME/bin
function itbin {
	ACT="new"
	if [ ! -z "$1" ] && [[ "$1" = "fix" ]]; then
	  ACT="fix"
	fi	
	
	INSTALL_LOG="$HOME/bin/.installed"
	
	[ -d "$HOME/bin" ] ||  mkdir $HOME/bin
	[ -f "$INSTALL_LOG" ] ||  touch $INSTALL_LOG	 
	
	declare -A hashmap
    hashmap[lein]="https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein"
    hashmap[phpunit]="https://phar.phpunit.de/phpunit.phar"
    hashmap[composer]="https://getcomposer.org/composer.phar"
    hashmap[symfony]="https://symfony.com/installer"
    hashmap[drush]="http://files.drush.org/drush.phar"
    array=( lein phpunit composer symfony drush)
    for it in "${array[@]}"
    do
	   EXCUTOR=$it
       GETURL=${hashmap[$it]}
       if [ "$ACT" = "new" ] || ( [ "$ACT" = "fix" ] && ! grep -q $EXCUTOR $INSTALL_LOG ) ; then
         if [ "$ACT" = "new" ] && [ -e "$HOME/bin/$EXCUTOR" ] ; then
             rm -rf "$HOME/bin/$EXCUTOR"
         fi
         
	     echo "Installing $EXCUTOR..."
	     wget $GETURL -O $HOME/bin/$EXCUTOR
         chmod +x  $HOME/bin/$EXCUTOR
	     echo "$EXCUTOR"  >> $INSTALL_LOG
	   else
	     echo "Installed $EXCUTOR" 
	   fi
    done	

    curl -L https://github.com/docker/compose/releases/download/1.12.0/docker-compose-`uname -s`-`uname -m` > $HOME/bin/docker-compose
    chmod +x $HOME/bin/docker-compose

    curl -L https://github.com/docker/machine/releases/download/v0.10.0/docker-machine-`uname -s`-`uname -m` > $HOME/bin/docker-machine 
    chmod +x $HOME/bin/docker-machine 

    wget https://releases.hashicorp.com/packer/0.12.2/packer_0.12.2_linux_amd64.zip -O /tmp/packer_0.12.2_linux_amd64.zip
    cd  /tmp && unzip packer_0.12.2_linux_amd64.zip && mv packer $HOME/bin/
    chmod +x  $HOME/bin/packer
    
    terraform
    
    wget http://www.rarlab.com/rar/rarlinux-5.4.0.tar.gz -O /tmp/rarlinux-5.4.0.tar.gz
    cd /tmp && tar xvzf rarlinux-5.4.0.tar.gz  && mv rar $HOME/bin/    
    ln -s $HOME/bin/rar/unrar $HOME/bin/unrar
    chmod -R $HOME/bin/rar/
    
    wget https://github.com/containers/build/releases/download/v0.4.0/acbuild-v0.4.0.tar.gz -O  /tmp/acbuild-v0.4.0.tar.gz
    cd /tmp && tar xvzf acbuild-v0.4.0.tar.gz 

    curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl > $HOME/bin/kubectl 
    chmod +x $HOME/bin/kubectl 

    
    mattn/goreman
    ddollar/foreman
    
    curl https://github.com/chrismytton/shoreman/raw/master/shoreman.sh -sLo ~/bin/shoreman && \
    chmod 755 ~/bin/shoreman
    
    tianon/gosu

}

#intall oracle java
function itjava  {
    if [ -z "$1" ]
	then
	   echo ""
	   echo "     Usage: itjava [java version: 7 8 0]"
	   echo ""
	   echo ""
	   return 1
	fi
	
   jdk_version=$1
   case  $OSNAME  in
      Fedora)       
          _fedora_itjava $jdk_version
          ;;
      Ubuntu)
          _ubuntu_itjava $jdk_version
          ;;           
      *)              
   esac   
}
 
function itchrome {
   case  $OSNAME  in
      Fedora)       
          _fedora_itchrome
          ;;
      Ubuntu)
          _ubuntu_itchrome
          ;;           
      *)              
   esac 
}

#jenv for java (http://www.jenv.be/)

#rbenv for ruby rails puppet
function itrbenv {
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
	
	if [[ -d $HOME/.rbenv ]]; then
	  echo rbenv exist. Remove it firstly!
	  tar zcf $HOME/rbenv-backup_$(date +%F-%kh%M).tar.gz -C $HOME/ .rbenv
	  rm -rf $HOME/.rbenv
	fi 
	
	git clone https://github.com/rbenv/rbenv.git $HOME/.rbenv
	git clone https://github.com/rbenv/ruby-build.git $HOME/.rbenv/plugins/ruby-build
	
	if [ ! -z  $ruby_version ]; then
	   ldrbenv
           supass dnf install -y openssl-devel readline-devel
	   rbenv install $ruby_version
	   rbenv local $ruby_version
	fi
	
}

function itrvm {	
	if [[ -d $HOME/.rvm ]]; then
	  echo rvm exist. Remove it firstly!
	  #tar zcvf $HOME/rvm-backup_$(date +%F-%kh%M).tar.gz -C $HOME/ .rvm
	  rm -rf $HOME/.rvm
	fi 	
	#gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
	curl -SL https://rvm.io/mpapis.asc | gpg2 --import -
	curl -SL https://get.rvm.io | bash -s stable --ruby=jruby --gems=rails,puma,hirb  --ignore-dotfiles
	source $HOME/.rvm/scripts/rvm
        rvm list
}

#sdk and scala maven ant gradle activator
function _itsdk_fix {
	echo "Installing sdk candidates,Waitting......."
	ldsdk
	candidates=( ant gradle grails  griffon groovy groovyserv jbossforge leiningen maven sbt scala springboot vertx)
	for i in "${candidates[@]}"
    do
	    sdk current | grep $i || sdk install $i
    done
}

function itsdk {
	if [ ! -z "$1" ] && [[ "$1" = "fix" ]]; then
	   echo "You had choosed to fix sdk  candidates"
	   _itsdk_fix
	   return 0
	fi
    
    echo "Installing new sdkman..............."
    if [[ -d $HOME/.sdkman ]]; then
	  echo sdkman exist. Remove it firstly!
	  tar zcvf $HOME/sdkman-backup_$(date +%F-%kh%M).tar.gz -C $HOME/ .sdkman
	  rm -rf $HOME/.sdkman
	fi 
	curl -s "https://get.sdkman.io" | bash
	sed -i "s/sdkman_disable_gvm_alias=false/sdkman_disable_gvm_alias=true/" $HOME/.sdkman/etc/config
	sed -i '/sdkman/d' $HOME/.zshrc
	sdk version
	_itsdk_fix
}

#nvm for nodejs
function itnvm {
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
	
	
	
    if [[ -d $HOME/.nvm ]]; then
	  echo "nvm exist. Remove it firstly!"
	  #tar zcvf $HOME/nvm-backup_$(date +%F-%kh%M).tar.gz -C $HOME/ .nvm
	  rm -rf $HOME/.nvm
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

function upnvm {
   (
     cd "$NVM_DIR"
     git fetch origin
     git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" origin`
   ) && . "$NVM_DIR/nvm.sh"	
}

#gvm for golang
function itgvm {
  if [[ -d $HOME/.gvm ]]; then
	  echo oh-my-fish exist. Remove it firstly!
	  tar zcf $HOME/gvm-backup_$(date +%F-%kh%M).tar.gz -C $HOME/.gvm
	  rm -rf $HOME/.gvm
  fi 
  supass dnf install -y bison
  bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)	
}

#perlbrew for perl 5
function itperlbrew {
   supass cpan App::perlbrew
   perlbrew init
}

#rakudobrew for perl 6

itvala(){
   supass add-apt-repository ppa:vala-team
   supass apt-get update
   supass apt-get install val	
}

function itlang {
   #vala	
   sudo dnf install vala
   
   #mono
   supass rpm --import "http://keyserver.ubuntu.com/pks/lookup?op=get&search=0x3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF"
   supass dnf config-manager --add-repo   http://download.mono-project.com/repo/centos/
   supass dnf install -y mono-devel  mono-complete  referenceassemblies-pcl ca-certificates-mono mono-xsp4
   #dmd
   curl -fsS https://dlang.org/install.sh | bash -s dmd
   #rust
   curl https://sh.rustup.rs -sSf | sh
   
   #Zimbu
   #go
   
   #erlang
   wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb
   sudo dpkg -i erlang-solutions_1.0_all.deb
   wget https://packages.erlang-solutions.com/erlang-solutions-1.0-1.noarch.rpm
   rpm -Uvh erlang-solutions-1.0-1.noarch.rpm
   sudo dnf install erlang elixir mongooseim
   
   # elixir
   
   #ring-lang
   
   #perl 6
   
   #powershell
}

#docker and pull docker images
function _itdocker_fix {
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
      
          echo $LOGINPASSWD | supass -S docker images | grep "$name.*$tag" ||  supass docker pull $name:$tag         
      
          #sed -e "s/\__FULLNAME\__:/\ $n $l :/g;s/\__Project__/\ $p /g" Reminder.email > sendnow.txt
       done < $images_file
	fi	
}

function docker_configure {
	 ori_pwd=${PWD}
	 ip=$( ip addr | grep 'state UP' -A2 | tail -n1 | awk '{print $2}' | cut -f1  -d'/' )
	 echo "Yuu must use hostname for this: $HOSTNAME $ip"
	 echo "Create server key"
	 
     openssl genrsa -aes256 -out ca-key.pem 4096
     openssl genrsa -aes256 -out ca-key.pem 4096
     openssl req -new -x509 -days 365 -key ca-key.pem -sha256 -out ca.pem
     openssl genrsa -out server-key.pem 4096
     penssl req -subj "/CN=$HOSTNAME" -sha256 -new -key server-key.pem -out server.csr
     echo subjectAltName = DNS:$HOSTNAME,IP:$ip,IP:127.0.0.1 > extfile.cnf
      openssl x509 -req -days 365 -sha256 -in server.csr -CA ca.pem -CAkey ca-key.pem  -CAcreateserial -out server-cert.pem -extfile extfile.cnf
     echo "create a client key"
     openssl genrsa -out key.pem 4096
     openssl req -subj '/CN=client' -new -key key.pem -out client.csr
     echo  extendedKeyUsage = clientAuth > extfile.cnf
     openssl x509 -req -days 365 -sha256 -in client.csr -CA ca.pem -CAkey ca-key.pem  -CAcreateserial -out cert.pem -extfile extfile.cnf
     
     sudo cp $MAX_SHELL/daemon.json /etc/docker/daemon.json
     #change /usr/lib/systemd/system/docker.service
     #ExecStart=/usr/bin/dockerd  -H=unix:///var/run/docker.sock -H=tcp://0.0.0.0:2376
     sudo systemctl daemon-reload
     sudo systemctl restart docker
     sudo systemctl status docker
     
     #client:
     mkdir -pv ~/.docker
     cp -v {ca,cert,key}.pem ~/.docker
     export DOCKER_HOST=tcp://$HOST:2376 DOCKER_TLS_VERIFY=1
}

#itdocker or itdocker fix [first|all]
function itdocker { 
	if [ ! -z "$1" ] && [[ $# -ge 2 ]] && [[ "$1" = "fix" ]]; then
	   echo "You had choosed to fix docker images"
	   _itdocker_fix $2
	   return 0
	fi
	
	echo "\e[1;31m  Installing new docker ........................  \e[0m"
	case  $OSNAME  in
      Fedora)       
          _fedora_itdocker
          ;;
      Ubuntu)
          _ubuntu_itdocker
          ;;           
      *)              
    esac
   
    supass systemctl enable docker
    supass systemctl start docker
    
    grep -i "^docker" /etc/group ||  supass groupadd docker 
    id -Gn "max" | grep -qc "docker" || supass usermod -a -G docker max
    supass docker run hello-world

    _itdocker_fix first
    
    _itdocker_box
}



function _itdocker_box {
	#nexus,jenkins ###login-admin:mmmm
    supass docker run -d  -p 5000:5000 \
         --name docker-proxy \
         -h proxy.tdocker.com  \
         -v /job/cache/docker/proxy:/var/lib/registry \
         registry:2 /var/lib/registry/config.yml 
     
     
    supass docker run -d -p 5001:5000 \
         --name docker-repo \
         -h repo.tdocker.com \
         -v /job/cache/docker/repo:/var/lib/registry  \
         registry:2 /var/lib/registry/config.yml
      
    supass docker run --name apt-cacher-ng -d  \
         --publish 3142:3142  \
         --volume /job/cache/apt:/var/cache/apt-cacher-ng  \
         sameersbn/apt-cacher-ng

    supass docker run --name squid -d  \
         --publish 3128:3128 \
         --volume /job/cache/squid/squid.conf:/etc/squid3/squid.conf \
         --volume /job/cache/squid/cache:/var/spool/squid3 \
         sameersbn/squid
  
    supass docker run --name nginx -d -p 8082:80 \
         -v /job/cache/nginx/html:/usr/share/nginx/html \
         nginx

    
    supass docker run -d  -p 2525:8081 --name nexus \
         -v /job/cache/nexus:/nexus-data \
         sonatype/nexus3

   
    supass docker run -d  --name jenkins -p 3131:8080 -p 50000:50000 \
         -v /job/cache/jenkins/home:/var/jenkins_home \
         jenkins
      
      #aria2c --enable-rpc --rpc-listen-all
      #http://localhost:9100   
    docker run -d --name="aria2" -v /job/cache/aria2:/data -p 6800:6800 -p 9100:8080  max/webui-aria2

    #sonarqube
     
    #redmine
     
    #mysql
     
    #postsql
     
    #mariadb
     
    #drone
     
    #portainer
     
    #gitlab
}
#virtualbox vagrant and pull vagrant boxes

function itrkt {	
  	case  $OSNAME  in
      Fedora)       
          _fedora_itrkt
          ;;
      Ubuntu)
          _ubuntu_itrkt
          ;;           
      *)              
    esac
}

function itvirtualBox {
	if [ -z "$1" ]
	then
	   echo ""
	   echo "     Usage: itbox [VirtualBox Version]"
	   echo ""
	   echo ""
	   return 1
	fi
	
	version=$1
	VBOX_EXT=$(_pkgext)
	
	_pkgremove VirtualBox-${version}  
    
	if read -t 10 -q "choice?Is it installed from File [Y|N]:"  ; then 
            if  [ ! -f /tmp/VirtualBox-${version}.${VBOX_EXT} ]; then
               echo ""
               echo -n "Enter virutualbox download url and press [ENTER]: "
               read vbdownloadurl
               echo ""
               aria2c -c -x 10 -j 10  -d/tmp -o VirtualBox-${version}.${VBOX_EXT}  $vbdownloadurl               
            fi
            supass dnf install -y /tmp/VirtualBox-${version}.${VBOX_EXT}
    else
       case  $OSNAME  in
           Fedora)       
              _fedora_itvirtualBox $version
              ;;
           Ubuntu)
              _ubuntu_itvirtualBox $version
              ;;           
           *)              
       esac
    fi
        

    
	grep -i -q  "^vboxusers" /etc/group ||  supass groupadd vboxusers 
	id -Gn "max" | grep -qc "vboxusers" || supass usermod -a -G vboxusers max
	
	#VBoxManage list extpacks
	#supass VBoxManage extpack install Oracle_VM_VirtualBox_Extension_Pack-4.3.12-93733.vbox-extpack
	#supass VBoxManage extpack uninstall "Oracle VM VirtualBox Extension Pack"
	
	#rpm -qa | grep -qw glibc-static || yum install glibc-static
	#debian:dpkg -l | grep -qw package || dnf install package
	#arch:pacman -Qq | grep -qw package || pasman -S package
}

function _itvagrant_fix {
	if [ -z "$1" ]; then
	   return 0
	fi
	
	if [ "$1" = "plugin" ]; then
	   echo "Installing plugins,Waitting........"
	   #cut -f 1 -d "(" $MAX_SHELL/vagrant-plugins | cat | while read VGPLUGIN; do
       #  vagrant plugin list | grep $VGPLUGIN || vagrant plugin install $VGPLUGIN
       #done
       $MAX_SHELL/vagrant-plugin.py -f $MAX_SHELL/vagrant/vagrant-plugin -n 5
	elif [ "$1" = "box" ]; then
	   echo "Installing boxes,Waitting........"
	   #cut -f 1 -d "(" $MAX_SHELL/vagrant-boxes | cat | while read VGBOX; do
       #    vagrant box list | grep $VGBOX || vagrant box add $VGBOX --provider virtualbox
       #done
       
       $MAX_SHELL/vagrant.pl -f $MAX_SHELL/vagrant/vagrant-boxes -n 5
	fi
}


function itvagrant {
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
	_pkgremove vagrant 
	
	case  $OSNAME  in
      Fedora)       
          _fedora_itvagrant  $version
          ;;
      Ubuntu)
          _ubuntu_itvagrant  $version
          ;;           
      *)              
    esac

	_itvagrant_fix plugin
	_itvagrant_fix box		
}


function _itpip {
   if ! type pip  > /dev/null; then
      echo "Can not find pip"
      wget https://bootstrap.pypa.io/get-pip.py -O /tmp/get-pip.py
      supass   python /tmp/get-pip.py
   fi  
   
   #sudo easy_install -i http://pypi.douban.com/simple/ --trusted-host pypi.douban.com saltTesting 
   #sudo pip install -i http://pypi.douban.com/simple/ --trusted-host pypi.douban.com saltTesting
   mkdir -p $HOME/.pip
   cp $MAX_SHELL/python/pip.conf $HOME/.pip/
    pip install Flask
    pip install Django
    pip install honcho
    pip install ipython
    #pyton Crawler 
    pip install scrapy
    #plone odoo
}

function _itpyenv {
  #pyenv
  git clone https://github.com/yyuu/pyenv.git $HOME/.pyenv	
  git clone https://github.com/yyuu/pyenv-virtualenv.git $HOME/.pyenv/plugins/pyenv-virtualenv
  #ldpyenv
  #pyenv install $ver
}

function _itpyvirtualenv {
  ##virtualenvwrapper
  pip install virtualenvwrapper
  export WORKON_HOME=$HOME/PYEnvs
  mkdir -p $WORKON_HOME
  source /usr/local/bin/virtualenvwrapper.sh	
  mkvirtualenv env1
}

##pyenv https://github.com/yyuu/pyenv, pyenv-virtualenv https://github.com/yyuu/pyenv-virtualenv
function itpython {
  if [ ! -z "$1" ] 
  then
	 case  $1  in
        pip)       
          _itpip
          ;;
        pyenv)
          _itpyenv
          ;;  
        virt)
          _itpyvirtualenv
          ;;          
      *)              
     esac
  fi 

}

function itfileserver {
    case  $OSNAME  in
      Fedora)       
          _fedora_itfileserver
          ;;
      Ubuntu)
          _ubuntu_itfileserver
          ;;           
      *)              
    esac
}

### ssh config and ssh for github ( $HOME/.ssh)

### stormpath maxkerrer@live.com 1tw ($HOME/.stormpath)

###/etc/host , /etc/fstab, $HOME/.zshrc  /etc/pip.conf 

### backup .vagrant.d/   /var/lib/docker



####clitools for https://github.com/webdevops


###travis for travis-ci.com


### $HOME/.stormpath/apiKey.properties for https://api.stormpath.com  salty-squall:mk@live:1t9


##mulesoft maxkerrer 1tWS


#cas /etc/cas

########################################################################
function ldmaxsdk {
   export M2_HOME=$SDK_HOME/apache-maven-3.5.0
   export GROOVY_HOME=$SDK_HOME/groovy-2.5.0-alpha-1
   export SCALA_HOME=$SDK_HOME/scala-2.12.2 
   export GOROOT=$SDK_HOME/go1.8.1.linux-amd64/go
   export ACTIVATOR_HOME=$SDK_HOME/activator-1.3.12-minimal
   export GRADLE_HOME=$SDK_HOME/gradle-3.5
   export POSTMAN_HOME=$SDK_HOME/Postman
   export ROO_HOME=$SDK_HOME/spring-roo-2.0.0.RC1
   export FORGE_HOME=$SDK_HOME/forge-distribution-3.6.1.Final
   export SBT_HOME=$SDK_HOME/sbt
   export GRAILS_HOME=$SDK_HOME/grails-3.2.9
   export GNAT_HOME=/usr/gnat
   export SPRING_BOOT_HOME=/home/max/sdk/spring-boot
   export PATH=$PATH:$M2_HOME/bin:$GROOVY_HOME/bin:$SCALA_HOME/bin:$GOROOT/bin:$ACTIVATOR_HOME/bin:$GRADLE_HOME/bin:$SBT_HOME/bin:$GRAILS_HOME/bin:$POSTMAN_HOME:$ROO_HOME/bin:$FORGE_HOME/bin:$GNAT_HOME/bin:$SPRING_BOOT_HOME/bin
}


ldsdk () {
  export SDKMAN_DIR="$HOME/.sdkman"
  [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh" 
}

ldgvm () {
  [[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"
}

ldnvm () {
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
}

ldjenv () {
   export PATH="$HOME/.jenv/bin:$PATH"
   eval "$(jenv init -)"
}

ldperlbrew () {
   source $HOME/perl5/perlbrew/etc/bashrc
}

ldperl6 () {
   docker run -it --rm rakudo-star	
}

ldrakudobrew () {
   export PATH=$HOME/.rakudobrew/bin:$PATH
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

ldpyvirtual() {
   export WORKON_HOME=$HOME/Envs
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
			supass  rkt image list | grep -s "$imageName.*$imageVersion" ||  supass rkt fetch $imageName:$imageVersion  
			supass  rkt image export  $imageName:$imageVersion "/job/images/${imageBase}_${imageVersion}.aci"
		elif [[ "docker" = "$conType" ]]; then
			supass  docker images | grep -s "$imageName.*$imageVersion" ||  supass docker pull $imageName:$imageVersion  
			supass  docker save $imageName:$imageVersion > "/job/images/${imageBase}_${imageVersion}.tar"
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
                   supass  rkt image list | grep -s "$imageName.*$imageVersion" ||  supass rkt fetch --insecure-options=image "/vagrant/${imageBase}_${imageVersion}.aci"
                elif [[ "docker" = "$conType" ]]; then
                   supass  docker images | grep -s "$imageName.*$imageVersion" ||  supass docker load < "/vagrant/${imageBase}_${imageVersion}.tar"
                fi
	done <<< "$VAR"
}


function _pkgext {
	case  $OSNAME  in
      Fedora)       
          echo "rpm"
          ;;
      Ubuntu)
          echo "deb"
          ;;           
      *)              
    esac
}

function _pkgremove {
	pkg=$1
	case  $OSNAME  in
      Fedora)       
          rpm -qa | grep -qw $pkg  && supass dnf remove -y $pkg
          ;;
      Ubuntu)
          dpkg -l | grep -qw $pkg && supass apt-get autoremove -y $pkg
          ;;           
      *)              
    esac
}

########################################################################
########################################################################
#test
ittestperl(){
  ${HOME}/.max/perltest.pl sdfafafa asdfasfas  || echo failure
}

ittestpython(){
	/job/shell/test.py sdfafafa asdfasfas  || echo failure	
}

ittestruby(){

}

ittestgo(){  
	go run test.go --flagname 123 -b false -v ok
}

ittestscala(){

}

ittestelixir(){

}

####################


init
