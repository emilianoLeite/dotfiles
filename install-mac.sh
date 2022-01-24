# install homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# install zsh
echo "\ninstalling zsh..."
brew install zsh zsh-completions

# install oh-my-zsh
echo "\ninstalling oh-my-zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# install oh-my-zsh plugins and prompt
echo "\ninstalling oh-my-zsh plugins..."
./install-zsh-plugins.sh

# oh-my-zsh config
echo "\ncopying .zshrc to HOME..."
cp ./.zshrc ~/
source ~/.zshrc

source ./macos-functions.sh

install_autojump
install_fzf

echo "Setup finished ✅"
