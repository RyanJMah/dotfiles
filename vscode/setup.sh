THIS_DIR="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

if [[ $OSTYPE == "linux"* ]];
then
    VSCODE_SETTINGS_DIR=$HOME/.config/Code/User
fi

if [[ $OSTYPE == "darwin"* ]];
then
    VSCODE_SETTINGS_DIR=$HOME/Library/Application\ Support/Code/User
fi

ln -sf $THIS_DIR/settings.json "${VSCODE_SETTINGS_DIR}/settings.json"
ln -sf $THIS_DIR/keybindings.json "${VSCODE_SETTINGS_DIR}/keybindings.json"
