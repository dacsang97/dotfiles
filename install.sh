#!/bin/bash

# Utils
function is_installed {
	local return_=1
	type $1 > /dev/null 2>&1 || { local return_=0; }
	echo "$return_"
}

# Installation for macOS
function install_macos {
	if [[ $OSTYPE != darwin* ]]; then
		return
	fi
	echo "macOS Detected"
	xcode-select --install
	if [[ "$(is_installed brew)" == "0" ]]; then
		echo "Installing Homebrew"
		/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	fi

	if [[ "$(is_installed zsh)" == "0" ]]; then
		echo "Installing zsh"
		brew install zsh zsh-completions
	fi

	if [[ "$(is_installed ag)" == "0" ]]; then
		echo "Installing The silver searcher"
		brew install the_silver_searcher
	fi

	if [[ "$(is_installed fzf)" == "0" ]]; then
		echo "Installing fzf"
		brew install fzf
	fi

	if [[ "$(is_installed tmux)" == "0"  ]]; then
		echo "Installing tmux"
		brew install tmux
		echo "Installing reattach-to-user-namespace"
		brew install reattach-to-user-namespace
		echo "Installing tmux-plugin-manager"
		git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
	fi

	if [[ "$(is_installed node)" == "0" ]]; then
		echo "Installing NVM"
		curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.0/install.sh | bash
		nvm install node
		npm install -g yarn
	fi

	echo "Installing PHP 7.2"
	brew install php72
	brew install composer

	if [[ "$(is_installed java)" == "0" ]]; then
		echo "Installing JDK 8"
		brew cask install adoptopenjdk/openjdk/adoptopenjdk8
	fi

	if [ "$(is_installed python3)" == "0" ]; then
		echo "Installing python3"
		brew install python3
	fi

	if [ "$(is_installed go)" == "0" ]; then
		echo "Installing go"
		brew install go
	fi


	if [[ "$(is_installed nvim)" == "0" ]]; then
		echo "Installing neovim"
		brew install neovim
	fi

  	if [[ "$(is_installed tmuxinator)" == "0" ]]; then
		echo "Install tmuxinator"
		brew install tmuxinator
  	fi
}

function backup {
	echo "Backing up dotfiles"
	local current_date=$(date +%s)
	local backup_dir=dotfiles_$current_date

	mkdir ~/$backup_dir

	mv ~/.zshrc ~/$backup_dir/.zshrc
	mv ~/.tmux.conf ~/$backup_dir/.tmux.conf
	mv ~/.vim ~/$backup_dir/.vim
	mv ~/.vimrc ~/$backup_dir/.vimrc
	mv ~/.vimrc.bundles ~/$backup_dir/.vimrc.bundles
	echo $backup_dir
}

function link_dotfiles {
	echo "Linking dotfiles"

	ln -s $(pwd)/zshrc ~/.zshrc
	ln -s $(pwd)/tmux.conf ~/.tmux.conf
	ln -s $(pwd)/vim ~/.vim
	ln -s $(pwd)/vimrc ~/.vimrc
	ln -s $(pwd)/vimrc.bundles ~/.vimrc.bundles

	echo "Installing oh-my-zsh"
 	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

	if [ ! -d "$ZSH/custom/plugins/zsh-autosuggestions" ]; then
		echo "Installing zsh-autosuggestions"
		git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH/custom/plugins/zsh-autosuggestions
	fi

	curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

	rm -rf $HOME/.config/nvim/init.vim
	rm -rf $HOME/.config/nvim
	mkdir -p ${XDG_CONFIG_HOME:=$HOME/.config}
	ln -s $(pwd)/vim $XDG_CONFIG_HOME/nvim
	ln -s $(pwd)/vimrc $XDG_CONFIG_HOME/nvim/init.vim

	ln -s $(pwd)/zsh-themes/yasuo.zsh-theme ~/.oh-my-zsh/themes/yasuo.zsh-theme
}

while test $# -gt 0; do
	case "$1" in
		--help)
			echo "Help"
			exit
			;;
		--macos)
			install_macos
			exit
			;;
		--dotfiles)
			backup
			link_dotfiles
			exit
			;;
	esac
done
