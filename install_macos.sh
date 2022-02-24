#!/bin/zsh

THIS_DIR="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

echo "starting install..."

echo "installing nvim..."
brew install neovim

echo "installing vim-plug..."
if [ -f $HOME/.vim/autoload/plug.vim ]; then
    echo "already installed, skipping..."
else
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

echo "copying vim dotfiles..."
cp $THIS_DIR/.vimrc $HOME
mkdir -p $HOME/.config/nvim
cp $THIS_DIR/init.vim $HOME/.config/nvim

echo "installing vim plugins..."
nvim +PluginInstall +qall

echo "installing .gdbinit"
cp $THIS_DIR/.gdbinit $HOME
echo "appending 'set startup-with-shell off' to ~/.gdbinit because macos"
echo "set startup-with-shell off" >> $HOME/.gdbinit;

echo "installing .ssh/config"
mkdir $HOME/.ssh
cp $THIS_DIR/ssh_config $HOME/.ssh
mv $HOME/.ssh/ssh_config $HOME/.ssh/config

echo "installing zsh..."
brew install zsh

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
source $HOME/.zsh_custom

echo "installing scripts..."
if [ -d $HOME/scripts ]; then
    mkdir $HOME/scripts
fi
cp $THIS_DIR/fuck_windows_macos $HOME/scripts
mv $HOME/scripts/fuck_windows_macos $HOME/scripts/fuck_windows

