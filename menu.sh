#!/bin/bash

function mydialog {
HEIGHT=15
WIDTH=40
CHOICE_HEIGHT=4
BACKTITLE="Backtitle here"
TITLE="Title here"
MENU="Choose one of the following options:"

OPTIONS=(1 "Option 1"
         2 "Option 2"
         3 "Option 3")

CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)

clear
case $CHOICE in
        1)
            echo "You chose Option 1"
            ;;
        2)
            echo "You chose Option 2"
            ;;
        3)
            echo "You chose Option 3"
            ;;
esac

}


show_menu(){
    NORMAL=`echo "\033[m"`
    MENU=`echo "\033[36m"` #Blue
    NUMBER=`echo "\033[33m"` #yellow
    FGRED=`echo "\033[41m"`
    RED_TEXT=`echo "\033[31m"`
    ENTER_LINE=`echo "\033[33m"`
    echo -e "${MENU}*********************************************${NORMAL}"
    echo -e "${MENU}**${NUMBER} 1)${MENU} Mount dropbox ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 2)${MENU} Mount USB 500 Gig Drive ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 3)${MENU} Restart Apache ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 4)${MENU} ssh Frost TomCat Server ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 5)${MENU} ${NORMAL}"
    echo -e "${MENU}*********************************************${NORMAL}"
    echo -e "${ENTER_LINE}Please enter a menu option and enter or ${RED_TEXT}enter to exit. ${NORMAL}"
    read opt
}
function option_picked() {
    COLOR='\033[01;31m' # bold red
    RESET='\033[00;00m' # normal white
    MESSAGE=${@:-"${RESET}Error: No message passed"}
    echo -e "${COLOR}${MESSAGE}${RESET}"
}

function testdia {
clear
show_menu
while [ opt != '' ]
    do
    if [[ $opt = "" ]]; then 
            exit;
    else
        case $opt in
        1) clear;
        option_picked "Option 1 Picked";
        sudo mount /dev/sdh1 /mnt/DropBox/; #The 3 terabyte
        menu;
        ;;

        2) clear;
            option_picked "Option 2 Picked";
            sudo mount /dev/sdi1 /mnt/usbDrive; #The 500 gig drive
        menu;
            ;;

        3) clear;
            option_picked "Option 3 Picked";
        sudo service apache2 restart;
            show_menu;
            ;;

        4) clear;
            option_picked "Option 4 Picked";
        ssh lmesser@ -p 2010;
            show_menu;
            ;;

        x)exit;
        ;;

        \n)exit;
        ;;

        *)clear;
        option_picked "Pick an option from the menu";
        show_menu;
        ;;
    esac
fi
done

}


function test3dia {
	 E='echo -e';e='echo ';trap "R;exit" 2
    ESC=$( $e "\e")
   TPUT(){ $e "\e[${1};${2}H";}
  CLEAR(){ $e "\ec";}
  CIVIS(){ $e "\e[?25l";}
   DRAW(){ $e "\e%@\e(0";}
  WRITE(){ $e "\e(B";}
   MARK(){ $e "\e[7m";}
 UNMARK(){ $e "\e[27m";}
      R(){ CLEAR ;stty sane;$e "\ec\e[37;44m\e[J";};
   HEAD(){ DRAW
           for each in $(seq 1 13);do
           $E "   x                                          x"
           done
           WRITE;MARK;TPUT 1 5
           $E "BASH SELECTION MENU                       ";UNMARK;}
           i=0; CLEAR; CIVIS;NULL=/dev/null
   FOOT(){ MARK;TPUT 13 5
           printf "ENTER - SELECT,NEXT                       ";UNMARK;}
  ARROW(){ read -s -n3 key 2>/dev/null >&2
           if [[ $key = $ESC[A ]];then echo up;fi
           if [[ $key = $ESC[B ]];then echo dn;fi;}
     M0(){ TPUT  4 20; $e "Login info";}
     M1(){ TPUT  5 20; $e "Network";}
     M2(){ TPUT  6 20; $e "Disk";}
     M3(){ TPUT  7 20; $e "Routing";}
     M4(){ TPUT  8 20; $e "Time";}
     M5(){ TPUT  9 20; $e "ABOUT  ";}
     M6(){ TPUT 10 20; $e "EXIT   ";}
      LM=6
   MENU(){ for each in $(seq 0 $LM);do M${each};done;}
    POS(){ if [[ $cur == up ]];then ((i--));fi
           if [[ $cur == dn ]];then ((i++));fi
           if [[ $i -lt 0   ]];then i=$LM;fi
           if [[ $i -gt $LM ]];then i=0;fi;}
REFRESH(){ after=$((i+1)); before=$((i-1))
           if [[ $before -lt 0  ]];then before=$LM;fi
           if [[ $after -gt $LM ]];then after=0;fi
           if [[ $j -lt $i      ]];then UNMARK;M$before;else UNMARK;M$after;fi
           if [[ $after -eq 0 ]] || [ $before -eq $LM ];then
           UNMARK; M$before; M$after;fi;j=$i;UNMARK;M$before;M$after;}
   INIT(){ R;HEAD;FOOT;MENU;}
     SC(){ REFRESH;MARK;$S;$b;cur=`ARROW`;}
     ES(){ MARK;$e "ENTER = main menu ";$b;read;INIT;};INIT
  while [[ "$O" != " " ]]; do case $i in
        0) S=M0;SC;if [[ $cur == "" ]];then R;$e "\n$(w        )\n";ES;fi;;
        1) S=M1;SC;if [[ $cur == "" ]];then R;$e "\n$(ifconfig )\n";ES;fi;;
        2) S=M2;SC;if [[ $cur == "" ]];then R;$e "\n$(df -h    )\n";ES;fi;;
        3) S=M3;SC;if [[ $cur == "" ]];then R;$e "\n$(route -n )\n";ES;fi;;
        4) S=M4;SC;if [[ $cur == "" ]];then R;$e "\n$(date     )\n";ES;fi;;
        5) S=M5;SC;if [[ $cur == "" ]];then R;$e "\n$($e by oTo)\n";ES;fi;;
        6) S=M6;SC;if [[ $cur == "" ]];then R;exit 0;fi;;
 esac;POS;done
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# !!! warning warning warnig !!!: not running directly as an executable, might give you wrong result
# Please save the code into a file menu.sh, execute: chmod +x menu.sh, then run it ./menu.sh
# if you will try like:  sh ./menu.sh, echo might respond wrong way
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
}


function  test4dia {
	
# sample.mnu
# A simple script menu under Unix
# Main logic starts at MAIN LOGIC
# The logo will be displayed at the top of the screen
LOGO="Sample Menu"

#------------------------------------------------------
# MENU PROMPTS
#------------------------------------------------------
# A list of menu prompts to be displayed for the user.
# The list can be modified.
# In this first list, enter the menu prompt as it should appear
# on the screen for each of the letters A - L. In this example
# menu pick variables emenu through lmenu are blank as there
# are no menu selections for keys E through L.

amenu="a.  Job Scheduling"                ;
bmenu="b.  Set Standard Defaults "        ; 
cmenu="c.  Display Directory Listing "    ; 
dmenu="d   Payroll Menu "                 ;
emenu=" "                                 ;
fmenu=" "                                 ;
gmenu=" "                                 ;
hmenu=" "                                 ;
imenu=" "                                 ;
jmenu=" "                                 ;
kmenu=" "                                 ;
lmenu=" "                                 ;

#------------------------------------------------------
# MENU FUNCTION DEFINITIONS
#------------------------------------------------------

# Define a function for invalid menu picks
# The function loads an error message into a variable
badchoice () { MSG="Invalid Selection ... Please Try Again" ; } 

# For each prompt displayed above, there is a list of 
# commands to execute in response to the user picking the
# associated letter.
# They are defined as functions
# apick () through lpick () where
# apick () corresponds to the menu
# prompt amenu which is selected
# selected by pressing a or A.
# bpick () corresponds to the menu
# prompt bmenu which is selected by
# pressing b or B and so on.
# Any menu item that is not
# assigned a set of commands, is
# assigned
# the function badchoice () as a default for that pick.
# If the user
# selects a menu key that is assigned
# to badchoice (). This function
# causes an error message to be
# displayed on the screen.
# To add items to this second
# list, replace badchoice ()
# with the commands to run when
# that letter is pressed.
# The following steps simply define
# the functions, but do not cause
# any shell program steps to be executed.

apick () { sched ; }
bpick () { defmnt ; }
cpick () { ls -l| more ; echo Press Enter ; read DUMMY ; }
dpick () { payroll.mnu ; }
epick () { badchoice ; }
fpick () { badchoice ; }
gpick () { badchoice ; }
hpick () { badchoice ; }
ipick () { badchoice ; }
jpick () { badchoice ; }
kpick () { badchoice ; }
lpick () { badchoice ; }

#------------------------------------------------------
# DISPLAY FUNCTION DEFINITION
#------------------------------------------------------
# This function displays the menu.
# The routine clears the screen, echoes
# the logo and menu prompts
# and some additional messages.
# Note that this definition does
# not cause the function to
# be executed yet, it just defines
# it ready to be executed.

themenu () {
# clear the screen
clear
echo `date`
echo
echo "\t\t\t" $LOGO
echo
echo "\t\tPlease Select:"
echo
echo "\t\t\t" $amenu
echo "\t\t\t" $bmenu
echo "\t\t\t" $cmenu
echo "\t\t\t" $dmenu
echo "\t\t\t" $emenu
echo "\t\t\t" $fmenu
echo "\t\t\t" $gmenu
echo "\t\t\t" $hmenu
echo "\t\t\t" $imenu
echo "\t\t\t" $jmenu
echo "\t\t\t" $kmenu
echo "\t\t\t" $lmenu
echo "\t\t\tx. Exit"
echo
echo $MSG
echo
echo Select by pressing the letter and then ENTER ;
}

#------------------------------------------------------
# MAIN LOGIC
#------------------------------------------------------
# Every thing up to this point has been to define
# variables or functions.
# The program actually starts running here.

# Clear out the error message variable
MSG=

# Repeat the menu over and over
# Steps are:
# Display the menu
# 'read' a line of input from the key board
# Clear the error message
# Check the answer for a or A or b or B etc. and dispatch
#    to the appropriate program or function or exit
# If the entry was invalid call the badchoice () function
#    to initialize MSG to an error message
# This error message is used when setting up the menu
#    for a menu pick that is valid but has no command
#    associated with it.

while  true
do
# display the menu
themenu

# read a line of input from the keyboard
read answer

# Clear any error message
MSG=

# Execute one of the defined functions based on the
#    letter entered by the user.

# If the choice was E through L, the pre-defined
#    function for that pick will execute badchoice ()
#    which loads an error message into MSG  

case $answer in
a|A) apick;;
b|B) bpick;;
c|C) cpick;;
d|D) dpick;;
e|E) epick;;
f|F) fpick;;
g|G) gpick;;
h|H) hpick;;
i|I) ipick;;
j|J) jpick;;
k|K) kpick;;
l|L) lpick;;

#      If the user selects =91x=92 to exit then break out
#      of this loop
x|X) break;;

# If the entry was invalid call the badchoice function
#    to initialize MSG to an error message
*) badchoice;;

esac

#     Do it again until the user enters =91x=92.
done	
}
