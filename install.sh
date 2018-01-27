#!/bin/bash

#Update and Upgrade
echo "Updating and Upgrading"
apt-get update && sudo apt-get upgrade -y
cd Descargas

sudo apt-get install dialog
cmd=(dialog --separate-output --checklist "Please Select Software you want to install:" 22 76 16)
options=(1 "Google Chrome" off
	 2 "Sublime Text 3" off    # any option can be set to default to "on"
         3 "Git" off
         4 "JDK 8 / JAVA_HOME" off
	 5 "Mysql Workbench" off
	 6 "DBeaver" off
	 7 "Spotify" off
	 8 "Atom" off
	 9 "Studio3t (robomongo)" off
	 10 "IntelliJ IDEA" off
	 11 "Grails" off
	 12 "Postman" off)
choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
clear
for choice in $choices
	do case $choice in
	  	1)
			echo "Google Chrome"
			wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
			sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
			apt-get update 
			apt-get install google-chrome-stable -y
			;;
	        2)
			echo "Sublime Text"
			add-apt-repository ppa:webupd8team/sublime-text-3 -y
			apt update
			apt install sublime-text-installer -y
			;;	
		3)
			echo "Git, please congiure git later..."
			apt install git -y
			;;
		4)
			echo "JDK 8"
			apt install python-software-properties -y
			add-apt-repository ppa:webupd8team/java -y
			apt update
			apt install oracle-java8-installer -y
					
			echo "JAVA_HOME"
			JAVA_HOME_CANDIDATES=$(find /usr -name 'java-8-oracle*')
			export JAVA_HOME=$JAVA_HOME_CANDIDATES
			;;
		5)
			echo "Mysql Workbench"
			apt install mysql-workbench -y
			;;
		6)
			echo "DBeaver"
			wget https://dbeaver.jkiss.org/files/dbeaver-ce_latest_amd64.deb
			dpkg -i dbeaver*.deb
			rm dbeaver*.deb
			;;
		7)
			echo "Spotify"
			apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0DF731E45CE24F27EEEB1450EFDC8610341D9410
			echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list
			apt update
			apt install spotify-client -y
			;;
		8)
			echo "Atom"
			add-apt-repository ppa:webupd8team/atom -y
			apt update 
			apt install atom
			;;
		9)
			echo "Studio3t (robomongo)"
			wget https://download.studio3t.com/studio-3t/linux/5.7.2/studio-3t-linux-x64.tar.gz
			tar -xvzf studio-3t*
			./studio-3t*.sh -y
			rm studio-3t*
			;;
		10)
			echo "IntelliJ IDEA"
			wget https://download.jetbrains.com/idea/ideaIU-2017.3.2.tar.gz
			tar -xvzf ideaIU*
			rm -r ideaIU*.tar.gz
			mv idea-IU* $HOME/Documentos
			;;
		11)
			echo "Grails"
			apt install curl
			curl -s get.sdkman.io | bash
			source "$HOME/.sdkman/bin/sdkman-init.sh"
			sdk install grails
			grails -version
			;;
		12)
			echo "Postman"
			wget https://dl.pstmn.io/download/latest/linux64 -O postman.tar.gz
			tar -xzf postman.tar.gz -C /opt
			rm postman.tar.gz
			ln -s /opt/Postman/Postman /usr/bin/postman
			;;
	esac
done
