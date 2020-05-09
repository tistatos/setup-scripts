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

# TODO: screensaver setup
# TODO: sleep/hibernate mode on laptop lid
# TODO: sleep mode on desktop

# oh-my-zsh install
chsh -s/bin/zsh $USER
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

# install rust
curl https://sh.rustup.rs -sSf | sh
# TODO: rustfmt and clippy

# ruby
gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
curl -sSL https://get.rvm.io | bash -s stable --rails


################
# CONFIG FILES #
################

# TODO: fix the plugins for zsh
# TODO: config files for zsh and oh my shell

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

# TODO: zsh config file
# TODO: global config git
