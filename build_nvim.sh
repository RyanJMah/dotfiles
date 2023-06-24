git clone https://github.com/neovim/neovim.git
cd neovim

git checkout tags/v0.9.0
make CMAKE_BUILD_TYPE=Release
sudo make install

sudo apt-get install python3-pip
pip3 install neovim
pip3 install jedi
python3 -m pip install --user --upgrade pynvim

cd ..
rm -rf neovim