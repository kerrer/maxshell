#!/usr/bin/bash
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
SDK_HOME=$HOME/sdk

export JAVA_HOME=/usr/java/latest

export MAVEN_HOME=$SDK_HOME/apache-maven-3.5.0
export GROOVY_HOME=$SDK_HOME/groovy-2.5.0-alpha-1
export SCALA_HOME=$SDK_HOME/scala-2.12
export GOROOT=$SDK_HOME/go1.8.1.linux-amd64/go
export ACTIVATOR_HOME=$SDK_HOME/activator-1.3.12-minimal
export GRADLE_HOME=$SDK_HOME/gradle-3.5

export PATH=$PATH:$JAVA_HOME/bin:$MAVEN_HOME/bin:$GROOVY_HOME/bin:$SCALA_HOME/bin:$GOROOT/bin:$ACTIVATOR_HOME/bin:$GRADLE_HOME/bin
export CLASSPATH="${CLASSPATH}:$SDK_HOME/libs"
LOGINPASSWD="mmmm"
LOG_FILE="$MAX_HOME/install_log"

OSNAME=`python -c "import platform;print(platform.linux_distribution()[0])"`
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

#if [[ ! -d $MAX_HOME/.oobash ]]; then
#	git clone https://github.com/niieani/bash-oo-framework.git $MAX_HOME/.oobash
#fi 	
#source "$MAX_HOME/.oobash/lib/oo-bootstrap.sh"

#exec 3>&1 1>>${LOG_FILE} 2>&1
#echo "This is stdout"
#echo "This is stderr" 1>&2
#echo "This is the console (fd 3)" 1>&3
#echo "This is both the log and the console" | tee /dev/fd/3



function optimimat {
     #/etc/gdm/custom.conf file:

    # GDM configuration storage

    #[daemon]
# Uncoment the line below to force the login screen to use Xorg
#WaylandEnable=false

#[security]
 echo ""
}

function regrup {
    sudo dnf reinstall grub2-efi grub2-efi-modules shim
    sudo grub2-mkconfig -o /boot/efi/EFI/fedora/grub.cfg
    ###for ubutnu  change uuid in /etc/fstab 
}

function itmirrors {
    #os
    supass mv /etc/yum.repos.d/fedora.repo /etc/yum.repos.d/fedora.repo.backup
    supass mv /etc/yum.repos.d/fedora-updates.repo /etc/yum.repos.d/fedora-updates.repo.backup
    supass wget -O /etc/yum.repos.d/fedora.repo http://mirrors.aliyun.com/repo/fedora.repo
    supass wget -O /etc/yum.repos.d/fedora-updates.repo http://mirrors.aliyun.com/repo/fedora-updates.repo
    supass yum makecache
    
    #pip
    sudo easy_install -i http://pypi.douban.com/simple/ saltTesting 
    sudo pip install -i http://pypi.douban.com/simple/ saltTesting
    
    #cpan
    #  perl -MCPAN -e shell
    # o conf  urllist unshift http://mirrors.aliyun.com/CPAN/
    # o conf commit
    mkdir -p $HOME/.cpan/CPAN/
    cp $HOME/MyConfig.pm $HOME/.cpan/CPAN/MyConfig.pm

    #gem
    
    #maven
    #<mirrors>
    #<mirror>
    #  <id>alimaven</id>
    #  <name>aliyun maven</name>
    #  <url>http://maven.aliyun.com/nexus/content/groups/public/</url>
    #  <mirrorOf>central</mirrorOf>        
    #</mirror>
    # </mirrors>
}

function devpkg {
	supass  dnf install -y nano git geany thunderbird  zsh fish curl aria2 p7zip augeas augeas-devel subversion mercurial expect dnf-plugins-core util-linux-user
	supass  dnf install -y make automake gcc gcc-c++ kernel-devel  
	#groupinstall "Development Tools" "Development Libraries"
}

function itwork {
        #You must change all disk label name firstly!
        ##############################################
	if [[ $# < 3 ]]; then
	   echo ""
	   echo "  Usage: itwork [sdX for work] [sdx for job sdx for Downloads]"
	   echo ""
	   echo "       Exmaple: itwork sdb1 db2 sb3"
	   echo ""
	   echo ""
	   return 1
	fi
	
	WORK_DEV=$1
	JOB_DEV=$2
        DOWN_DEV=$3

	if [[ ! -d /work ]]; then
	  supass  mkdir /work
	fi
	
	if [[ ! -d /job ]]; then
	  supass  mkdir /job
	fi
	
    supass  chown -R max:max /work /job
    workuuid=$(supass  blkid /dev/$WORK_DEV | awk  '{print $3}')
    jobuuid=$(supass blkid /dev/$JOB_DEV | awk  '{print $3}')
    downuuid=$(supass blkid /dev/$DOWN_DEV | awk  '{print $3}')
    
    echo "add  /work /job Downloads to /etc/fstab"
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
     supass augtool <<-EOF
set /files/etc/fstab/102/spec $downuuid
set /files/etc/fstab/102/file "$MAX_HOME/Downloads"
set /files/etc/fstab/102/vfstype ext4
set /files/etc/fstab/102/opt defaults
set /files/etc/fstab/102/dump 1
set /files/etc/fstab/102/passno 1
save
quit
EOF
    supass mount -a
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
	echo 'source /work/max/fedora.sh' >> $MAX_HOME/.zshrc
}

function _install_fish {
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

function _sh_alias {
   alias a2c="aria2c -c -x 10 -j 10"	
   source $HOME/max/alias.sh
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
  cp $MAX_SHELL/ssh/* $HOME/.ssh
  chmod 700 $HOME/.ssh
  chmod 600 $HOME/.ssh/authorized_keys
}

#$MAX_HOME/bin
function itbin {
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
    array=( lein phpunit composer symfony drush)
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

    curl -L https://github.com/docker/compose/releases/download/1.12.0/docker-compose-`uname -s`-`uname -m` > $HOME/bin/docker-compose
    chmod +x $HOME/bin/docker-compose

    curl -L https://github.com/docker/machine/releases/download/v0.10.0/docker-machine-`uname -s`-`uname -m` > $HOME/bin/docker-machine 
    chmod +x $HOME/bin/docker-machine 

    wget https://releases.hashicorp.com/packer/0.12.2/packer_0.12.2_linux_amd64.zip -O /tmp/packer_0.12.2_linux_amd64.zip
    cd  /tmp && unzip packer_0.12.2_linux_amd64.zip && mv packer $MAX_HOME/bin/
    chmod +x  $MAX_HOME/bin/packer
    
    wget http://www.rarlab.com/rar/rarlinux-5.4.0.tar.gz -O /tmp/rarlinux-5.4.0.tar.gz
    cd /tmp && tar xvzf rarlinux-5.4.0.tar.gz  && mv rar $MAX_HOME/bin/    
    ln -s $MAX_HOME/bin/rar/unrar $MAX_HOME/bin/unrar
    chmod -R $MAX_HOME/bin/rar/
    
    wget https://github.com/containers/build/releases/download/v0.4.0/acbuild-v0.4.0.tar.gz -O  /tmp/acbuild-v0.4.0.tar.gz
    cd /tmp && tar xvzf acbuild-v0.4.0.tar.gz 
    

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
 
function itchrome {
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

#jenv for java (http://www.jenv.be/)


function _fix_gem {
   gem install foreman --no-document
   gem install puppet  --no-document
   gem install r10k
	
}


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
	
	if [[ -d $MAX_HOME/.rbenv ]]; then
	  echo rbenv exist. Remove it firstly!
	  tar zcf $MAX_HOME/rbenv-backup_$(date +%F-%kh%M).tar.gz -C $MAX_HOME/ .rbenv
	  rm -rf $MAX_HOME/.rbenv
	fi 
	
	git clone https://github.com/rbenv/rbenv.git $MAX_HOME/.rbenv
	git clone https://github.com/rbenv/ruby-build.git $MAX_HOME/.rbenv/plugins/ruby-build
	
	if [ ! -z  $ruby_version ]; then
	   ldrbenv
           supass dnf install -y openssl-devel readline-devel
	   rbenv install $ruby_version
	   rbenv local $ruby_version
	fi
	
}

function itrvm {	
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

function upnvm {
   (
     cd "$NVM_DIR"
     git fetch origin
     git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" origin`
   ) && . "$NVM_DIR/nvm.sh"	
}

#gvm for golang
function itgvm {
  if [[ -d $MAX_HOME/.gvm ]]; then
	  echo oh-my-fish exist. Remove it firstly!
	  tar zcf $MAX_HOME/gvm-backup_$(date +%F-%kh%M).tar.gz -C $MAX_HOME/.gvm
	  rm -rf $MAX_HOME/.gvm
  fi 
  supass dnf install -y bison
  bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)	
}

#perlbrew for perl 5
function _itperl_fix {
  #o conf  urllist unshift http://mirrors.aliyun.com/CPAN/
  #o conf commit
  supass   perl -MCPAN -e 'install App::cpanminus'
  supass   cpanm  Capture::Tiny 
  supass   cpanm Dancer2  Catalyst::Devel Mojolicious
}


function itperl {
   if [ ! -z "$1" ] && [[ "$1" = "fix" ]]; then
	  echo "You had choosed to fix perl modules"
	  _itperl_fix
	  return 0
   fi
	
    curl -L https://install.perlbrew.pl | bash	
}
#rakudobrew for perl 6

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
   
   #ring-lang
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


#itdocker or itdocker fix [first|all]
function itdocker {
	if [ ! -z "$1" ] && [[ $# -ge 2 ]] && [[ "$1" = "fix" ]]; then
	   echo "You had choosed to fix docker images"
	   _itdocker_fix $2
	   return 0
	fi
	
	echo "\e[1;31m  Installing new docker ........................  \e[0m"
	supass dnf remove docker \
                  docker-common \
                  container-selinux \
                  docker-selinux \
                  docker-engine
    
    supass dnf config-manager \
    --add-repo \
    https://download.docker.com/linux/fedora/docker-ce.repo
    supass dnf makecache fast
    supass dnf install -y docker-ce
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
     sonarqube
     
     redmine
     
     mysql
     
     postsql
     
     mariadb
     
     drone
     
     portainer
     
     gitlab
}
#virtualbox vagrant and pull vagrant boxes

function itrkt {	
  #supass dnf install rkt
  gpg --recv-key 18AD5014C99EF7E3BA5F6CE950BDD3E0FC8A365E
  wget https://github.com/coreos/rkt/releases/download/v1.25.0/rkt-1.25.0-1.x86_64.rpm
  wget https://github.com/coreos/rkt/releases/download/v1.25.0/rkt-1.25.0-1.x86_64.rpm.asc
  gpg --verify rkt-1.25.0-1.x86_64.rpm.asc
  supass rpm -Uvh rkt-1.25.0-1.x86_64.rpm	
  supass setenforce Permissive
  supass firewall-cmd --add-source=172.16.28.0/24 --zone=trusted
}

function itvirtualBox {
	if [ -z "$1" ]
	then
	   echo ""
	   echo "     Usage: itvirtualBox [VirtualBox Version]"
	   echo ""
	   echo ""
	   return 1
	fi
	
	version=$1
	
	if [[ -a  /etc/yum.repos.d/virtualbox.repo ]]; then
	  echo virtualbox repo exist. Remove it firstly!
	  supass rm -rf  /etc/yum.repos.d/virtualbox.repo
	fi 
	
	if rpm -qa | grep -qw VirtualBox-${version}; then
          supass dnf remove -y VirtualBox-${version}
        fi   
        
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
            supass wget -q  http://download.virtualbox.org/virtualbox/rpm/fedora/virtualbox.repo -O /etc/yum.repos.d/virtualbox.repo
            supass wget -q  https://www.virtualbox.org/download/oracle_vbox.asc  -O /tmp/oracle_vbox.asc
            supass rpm --import  /tmp/oracle_vbox.asc    
            supass dnf update
	    supass dnf install -y dkms VirtualBox-${version}
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
	if  rpm -qa | grep -qw vagrant; then
           supass dnf remove -y  vagrant
        fi
      
	if [ ! -f /tmp/vagrant_${version}_x86_64.rpm  ]
	then
	  echo get https://releases.hashicorp.com/vagrant/${version}/vagrant_${version}_x86_64.rpm
	  aria2c -c -x 10 -j 10  -d/tmp -o vagrant_${version}_x86_64.rpm  https://releases.hashicorp.com/vagrant/${version}/vagrant_${version}_x86_64.rpm
	fi

	supass dnf install -y /tmp/vagrant_${version}_x86_64.rpm 

	_itvagrant_fix plugin
	_itvagrant_fix box		
}



##virtualenvwrapper
function itenv {
  pip install virtualenvwrapper
  export WORKON_HOME=$MAX_HOME/Envs
  mkdir -p $WORKON_HOME
  source /usr/local/bin/virtualenvwrapper.sh	
  mkvirtualenv env1
}

function _itpython_fix {
   if ! type nano  > /dev/null; then
      echo "Can not find pip"
      wget https://bootstrap.pypa.io/get-pip.py -O /tmp/get-pip.py
   fi
   
   supass   python /tmp/get-pip.py
   supass   pip install Django==1.10.5	
   supass   pip install Flask
}


##pyenv https://github.com/yyuu/pyenv, pyenv-virtualenv https://github.com/yyuu/pyenv-virtualenv
function itpython {
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

function itfileserver {
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

### ssh config and ssh for github ( $MAX_HOME/.ssh)

### stormpath maxkerrer@live.com 1tw ($MAX_HOME/.stormpath)

###/etc/host , /etc/fstab, $MAX_HOME/.zshrc  /etc/pip.conf 

### backup .vagrant.d/   /var/lib/docker

### $MAX_HOME/.m2/setting 

####clitools for https://github.com/webdevops


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




########################################################################
########################################################################
#test
ittestperl(){
  ${MAX_HOME}/.max/perltest.pl sdfafafa asdfasfas  || echo failure
}

ittestpython(){
	/job/shell/test.py sdfafafa asdfasfas  || echo failure	
}

ittestruby(){

}

ittestgo(){

}

ittestscala(){

}

ldtest(){
   if read -t 3 -q "name?please enter your name:"  ; then 
     echo -n "hello $name ,welcome to my script"
   else
     echo $name
     echo "sorry,too slow"
   fi
}
