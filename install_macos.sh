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

echo "installing scripts..."
mkdir $HOME/scripts

# fuck_windows
brew install dos2unix
touch $HOME/scripts/fuck_windows
chmod +x $HOME/scripts/fuck_windows
echo "#!/bin/zsh" > $HOME/scripts/fuck_windows
cat $THIS_DIR/fuck_windows >> $HOME/scripts/fuck_windows

# file-share
pip3 install -r requirements.txt
touch $HOME/scripts/file-share
chmod +x $HOME/scripts/file-share
echo "#!/usr/local/bin/python3" > $HOME/scripts/file-share
cat $THIS_DIR/file-share >> $HOME/scripts/file-share
