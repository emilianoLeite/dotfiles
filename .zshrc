# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
export PATH="$PATH:/usr/local/sbin"

export NVM_DIR="$HOME/.nvm"
  . "/usr/local/opt/nvm/nvm.sh"

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="robbyrussell"
# ZSH_THEME="avit"
# ZSH_THEME="miloshadzic"
# ZSH_THEME="agnoster"
ZSH_THEME="emiliano"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git git-open zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#

alias p='cd ~/projects/'
alias cerc='cd ~/Projects/core/'
alias cerc-f='cd ~/Projects/frontend'
alias cerc-a='cd ~/Projects/admin-panel'
alias cerc-g='cd ~/Projects/cerc-client'
alias cerc-d='cd ~/Projects/documentacao-api'
alias cerc-i='cd ~/Projects/integra-cnab'
alias cerc-dash='cd ~/Projects/dashboard'
alias cerc-test='cd ~/Projects/cerc-client-test'
alias vsc='cd ~/Projects/VSCodus'
alias playbook='cd ~/Projects/playbook-dev'
alias blog='cd ~/Projects/blog'
alias cgraph='cd ~/Projects/core-graphql'
alias agraph='cd ~/Projects/admin-graphql'

alias build-next-release='npm run build -- --env-path .env.next-release'

alias delete-merged='ggl && git branch --merged | egrep -v "(^\*|master|dev|release|codus)" | xargs git branch -d && git fetch --all --prune'
alias newmr='git open new_mr'
alias alignbr='ggl && git fetch origin && git merge origin/preview && git merge origin/staging'
alias prune='git fetch origin --prune'

# =====  FUNCTIONS  =====
run_setup() {
  printf "\n ⚙ Do you wish to run full setup? (y/n): "
  read answer
  if [ $answer = 'y' ] || [ $answer = 'Y' ]
  then
    install_rvm
    install_highlighting_plugin
    install_autosuggestions_plugin
    create_git_aliases
    echo "\n✅  SETUP SUCCESSFUL ✅ \n"
  else
    echo "\n❌  SETUP ABORTED ❌ \n"
  fi
}

install_rvm() {
  \curl -sSL https://get.rvm.io | bash -s stable --ruby
}
install_highlighting_plugin() {
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
}
install_autosuggestions_plugin() {
  git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
}
create_git_aliases() {
  git config --global pager.diff false
  git config --global alias.co checkout
  git config --global alias.br branch
  git config --global alias.ci commit
  git config --global alias.st status
  git config --global alias.st s
  git config --global alias.amend "ci --amend --no-edit"
}

hpush () {
  branch=$(git symbolic-ref -q --short HEAD)
  git push $1 $branch:master
}

deploy-front-next-release() {
  if [ -f .env.next-release ]
  then
    build-next-release
    cp .env .env.tmp
    cp .env.next-release .env
    npm run upload-to-s3
    cp .env.tmp .env
    rm .env.tmp
  else
    echo '.env.next-release does not exist'
  fi
}
