# install zsh
echo "\ninstalling zsh..."
sudo apt-get install zsh && \

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

source ./linux-functions.sh

install_autojump
install_fzf

echo "Setup finished ✅"
