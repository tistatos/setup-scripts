#!/bin/sh
YES=1
NO=0

laptop-detect
not_laptop=$?

	# TODO: screensaver setup
	# TODO: sleep/hibernate mode on laptop lid
	# TODO: sleep mode on desktop

if [ $not_laptop -eq $YES ]; then
	echo "not running laptop"
else
	echo "laptop"
fi

read -p "Do you want to install apps via apt-get?(Y/n) " yn
case $yn in
	[Yy]* ) install=$YES; break;;
	[Nn]* ) install=$NO;;
esac


read -p "Do you want to symlink dotfiles to their directories?(Y/n) " yn
case $yn in
	[Yy]* ) symlink=$YES; break;;
	[Nn]* ) symlink=$NO;;
esac


read -p "Do you want to install ruby?(Y/n) " yn
case $yn in
	[Yy]* ) install_ruby=$YES; break;;
	[Nn]* ) install_ruby=$NO;;
esac

read -p "Do you want to install rust?(Y/n) " yn
case $yn in
	[Yy]* ) install_rust=$YES; break;;
	[Nn]* ) install_rust=$NO;;
esac

if [ $install -eq $YES ]; then
	echo "Installing apps..."
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
		feh \
		firefox \
		gdb \
		git \
		gitk \
		i3-wm \
		meld \
		neovim \
		nodejs \
		notify-osd \
		npm \
		qalc \
		python3.7 \
		python2.7 \
		python-pip \
		python3-pip \
		ranger \
		rofi \
		silversearcher-ag \
		spotify-client \
		thunar \
		tig \
		xfce4-volumed \
		zsh \

	# oh-my-zsh install
	chsh -s/bin/zsh $USER
	sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
fi

if [ $install_rust -eq $YES ]; then
	echo "installing rust..."
	# install rust
	curl https://sh.rustup.rs -sSf | sh
	# TODO: rustfmt and clippy
fi

if [ $install_ruby -eq $YES ]; then
	echo "installing ruby..."
	# ruby
	gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
	curl -sSL https://get.rvm.io | bash -s stable --rails
fi


################
# CONFIG FILES #
################

if [ $symlink -eq $YES ]; then
	echo "symlinking..."
	# TODO: fix the plugins for zsh
	# TODO: config files for zsh and oh my shell
	# TODO: zsh config file

	# fix icons for thunar
	echo "gtk-icon-theme-name=\"gnome\"" >> ~/.gtkrc-2.0

	# i3
	mkdir -p ~/.i3
	ln -s $PWD/dotfiles/i3/config ~/.i3/config
	# TODO: i3status files

	# vim
	ln -s $PWD/dotfiles/vim/.vimrc ~/.vimrc
	mkdir -p ~/.config/nvim
	ln -s $PWD/dotfiles/nvim/init.vim ~/.config/nvim

	mkdir -p ~/.config/rofi
	ln -s $PWD/dotfiles/rofi/config ~/.config/rofi
	ln -s $PWD/dotfiles/rofi/slate.rasi ~/.config/rofi

	# vim: install vundle
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

	# vim: install python binding
	pip3 install setuptools
	pip3 install neovim
	pip install setuptools
	pip install neovim

	# ycm install
	# TODO: add ycm and evaluate if ale is better?

	# compton
	ln -s $PWD/dotfiles/compton/compton.config ~/.config/compton.config

	# TODO: global config git
fi
