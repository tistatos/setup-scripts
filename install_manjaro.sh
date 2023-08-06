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

read -p "Do you want to install python2 stuff?(Y/n) " yn
case $yn in
	[Yy]* ) python2=$YES; break;;
	[Nn]* ) python2=$NO;;
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


	curl -sS https://download.spotify.com/debian/pubkey_0D811D58.gpg | gpg --import

	#update and upgrade
	sudo pacman -Syy
	sudo pacman -Syu

	#install packages
	sudo pacman -S 
		base-devel \
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
		libqalculate \
		python3.7 \
		python3-pip \
		ranger \
		rofi \
		the_silver_searcher \
		spotify-client \
		thunar \
		tig \
		xfce4-volumed \
		zsh \

	# playerctl install
	# FIXME: can we always get the lastest some how?
	wget https://github.com/altdesktop/playerctl/releases/download/v2.1.1/playerctl-2.1.1_amd64.deb
	sudo dpkg -i playerctl-2.1.1_amd64.deb

	# oh-my-zsh install, do this last
	chsh -s/bin/zsh $USER
	sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -) --unattended"
fi

if [ $python2 -eq $YES ]; then
	echo "installing python2 stuff..."
	sudo apt-get install -y \
		python2.7 \
		python-pip
	pip install setuptools
	pip install neovim
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

	ln -s -f $PWD/dotfiles/.gtkrc-2.0 ~/

	ln -s -f $PWD/dotfiles/zsh/.zshrc ~/
	git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
	git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

	# fix icons for thunar
	echo "gtk-icon-theme-name=\"gnome\"" >> ~/.gtkrc-2.0
	# scripts
	mkdir -p ~/.config/scripts
	ln -s -f $PWD/scripts/locking ~/.config/scripts
	ln -s -f $PWD/scripts/screendetect ~/.config/scripts

	# i3
	mkdir -p ~/.config/i3
	mkdir -p ~/.config/i3status
	ln -s -f $PWD/dotfiles/i3/config ~/.config/i3
	ln -s -f $PWD/dotfiles/i3status/config ~/.config/i3status/

	# vim
	ln -s -f $PWD/dotfiles/vim/.vimrc ~/.vimrc
	mkdir -p ~/.config/nvim
	ln -s -f $PWD/dotfiles/nvim/init.vim ~/.config/nvim

	mkdir -p ~/.config/rofi
	ln -s -f $PWD/dotfiles/rofi/config ~/.config/rofi
	ln -s -f $PWD/dotfiles/rofi/slate.rasi ~/.config/rofi

	# vim: install vundle
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

	# vim: install python binding
	pip3 install setuptools
	pip3 install neovim

	# ycm install
	# TODO: add ycm and evaluate if ale is better?

	# compton
	ln -s -f $PWD/dotfiles/compton/compton.config ~/.config/compton.config

	# TODO: global config git
fi

cat <<-'EOF'
 ___________________________
< Installation is complete! >
 ---------------------------
      \                    / \  //\
       \    |\___/|      /   \//  \\
            /0  0  \__  /    //  | \ \
           /     /  \/_/    //   |  \  \
           @_^_@'/   \/_   //    |   \   \
           //_^_/     \/_ //     |    \    \
        ( //) |        \///      |     \     \
      ( / /) _|_ /   )  //       |      \     _\
    ( // /) '/,_ _ _/  ( ; -.    |    _ _\.-~        .-~~~^-.
  (( / / )) ,-{        _      `-.|.-~-.           .~         `.
 (( // / ))  '/\      /                 ~-. _ .-~      .-~^-.  \
 (( /// ))      `.   {            }                   /      \  \
  (( / ))     .----~-.\        \-'                 .~         \  `. \^-.
             ///.----..>        \             _ -~             `.  ^-`  ^-_
               ///-._ _ _ _ _ _ _}^ - - - - ~                     ~-- ,.-~
                                                                  /.-~
