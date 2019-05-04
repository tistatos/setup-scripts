#/bin/sh

#used for python
sudo add-apt-repository ppa:deadsnakes/ppa -y
#update and upgrade
sudo apt-get update && sudo apt-get upgrade -y	

#install packages
sudo apt-get install -y \
	build-essential \
	compton \
	cmake \
	dmenu \
	firefox \
	gdb \
	git \
	i3-wm \
	neovim \
	nodejs \
	npm \
	python3.7 \
	python2.7 \
	ranger \
	rofi \
	thunar \
	zsh \

#TODO: screensaver
#TODO: sleep/hibernate mode
#TODO: sleep mode


#install rust
curl https://sh.rustup.rs -sSf | sh

#get dot files
#TODO: i3
#TODO: vim
#TODO: nvim
#TODO: zsh
#TODO: global git

#ruby
gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
curl -sSL https://get.rvm.io | bash -s stable --rails

#install vundle
#TODO

#ycm install
#TODO

#zsh install
chsh -s/bin/zsh $USER
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
