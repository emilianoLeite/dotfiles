# install homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# install zsh
brew install zsh zsh-completions

# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# oh-my-zsh config
cp ./.zshrc ~/
cp emiliano.zsh-theme ~/.oh-my-zsh/themes/

# install additional utilities
source ~/.zshrc
run_setup