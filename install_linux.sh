#!/bin/bash

THIS_DIR="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

echo "starting install..."

echo "installing nvim..."

# we get to build from source here, fun!!!
if ! which nvim
then
    sudo apt install ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl doxygen

    ./build_nvim.sh

    curl -sL https://deb.nodesource.com/setup_16.x -o /tmp/nodesource_setup.sh
    sudo bash /tmp/nodesource_setup.sh
    sudo apt install nodejs
fi

echo "installing vim-plug..."
if [ -f $HOME/.vim/autoload/plug.vim ]; then
    echo "already installed, skipping..."
else
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

echo "copying vim dotfiles..."
cp $THIS_DIR/.vimrc $HOME
cp $THIS_DIR/.terminal-vimrc $HOME
cp $THIS_DIR/.vscode-vimrc $HOME
mkdir -p $HOME/.config/nvim
cp $THIS_DIR/init.vim $HOME/.config/nvim
cp $THIS_DIR/coc-settings.json $HOME/.config/nvim
mkdir -p $HOME/.vim/after/syntax
cp $THIS_DIR/c.vim $HOME/.vim/after/syntax

echo "installing tmux..."
if ! which tmux
then
    sudo apt install tmux
fi

echo "installing tmux plugin manager..."
if [ -d $HOME/.tmux/plugins/tpm ]; then
    echo "already installed, skipping..."
else
    git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
fi

echo "copying tmux dotfiles..."
cp $THIS_DIR/.tmux.conf $HOME

echo "installing clangd..."
sudo apt install clangd-12
sudo update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-12 100

echo "installing ripgrep..."
sudo apt install ripgrep

echo "installing alacritty config..."
mkdir -p $HOME/.config/alacritty
cp $THIS_DIR/alacritty.yml $HOME/.config/alacritty

echo "installing .gdbinit"
cp $THIS_DIR/.gdbinit $HOME

echo "installing .ssh/config"
mkdir $HOME/.ssh
cp $THIS_DIR/ssh_config $HOME/.ssh
mv $HOME/.ssh/ssh_config $HOME/.ssh/config

echo "installing zsh..."
sudo apt-get install zsh

echo "installing oh-my-zsh..."
if [ -d $HOME/.oh-my-zsh ]; then
    echo "already installed, skipping..."
else
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    source $HOME/.zshrc
fi

echo "installing syntax highlighting plugin..."
if [ -d $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting ]; then
    echo "already installed, skipping..."
else
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
fi

echo "installing p10k..."
if [ -d $HOME/.oh-my-zsh/custom/themes/powerlevel10k ]; then
    echo "already installed, skipping..."
else
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
fi

echo "copying oh-my-zsh dotfiles..."
cp $THIS_DIR/.zshrc $HOME
cp $THIS_DIR/.zsh_custom $HOME
cp $THIS_DIR/*.zsh-theme $HOME/.oh-my-zsh/themes

echo "installing scripts..."
mkdir $HOME/scripts

# fuck_windows
sudo apt-get install dos2unix
touch $HOME/scripts/fuck_windows
chmod +x $HOME/scripts/fuck_windows
echo "#\!/bin/bash" > $HOME/scripts/fuck_windows
cat $THIS_DIR/fuck_windows >> $HOME/scripts/fuck_windows


# file-share
pip3 install -r requirements.txt
touch $HOME/scripts/file-share
chmod +x $HOME/scripts/file-share
echo "#!/usr/bin/python3" > $HOME/scripts/file-share
cat $THIS_DIR/file-share >> $HOME/scripts/file-share

echo "installing WM dotfiles"
mkdir -p $HOME/.config/i3/config
cp $THIS_DIR/linux/i3-config $HOME/.config/i3/config

echo "installing polybar conf"
if [ -d $HOME/.config/polybar ]; then
    echo "already installed, skipping..."
else
    cp -r $THIS_DIR/linux/polybar $HOME/.config/polybar
fi
