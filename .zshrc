# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"


# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="robbyrussell"
# ZSH_THEME="avit"
# ZSH_THEME="miloshadzic"
# ZSH_THEME="agnoster"
ZSH_THEME="spaceship"
DEFAULT_USER="emilianoleite"
SPACESHIP_GIT_PREFIX=""
SPACESHIP_PACKAGE_SHOW='false'
SPACESHIP_DOCKER_SHOW='false'
SPACESHIP_KUBECTL_SHOW='false'
SPACESHIP_KUBECTL_VERSION_SHOW='false'
SPACESHIP_KUBECONTEXT_SHOW='false'
SPACESHIP_TERRAFORM_SHOW='false'
SPACESHIP_NODE_PREFIX=''
SPACESHIP_RUBY_PREFIX=''
SPACESHIP_BATTERY_THRESHOLD='50'

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
plugins=(
  git
  git-open
  zsh-autosuggestions
  zsh-syntax-highlighting
  docker
)

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

alias delete-all-local-branches='git branch | egrep -v "(^\*|master)" | xargs git branch -D'
alias delete-merged='ggl && git branch --merged | egrep -v "(^\*|master|dev|release|codus)" | xargs git branch -d && git fetch --all --prune'
alias yas="yarn start"
alias yat="yarn test"
alias yatch="yarn test --watch"
alias gview="gh pr view -w"
alias gcreate="gh pr create -w"
alias gpmr="ggp && gcreate"

# =====  FUNCTIONS  =====
run_setup() {
  printf "\n ⚙ Do you wish to run full setup? (y/n): "
  read answer
  if [ $answer = 'y' ] || [ $answer = 'Y' ]
  then
    install_nvm
    install_asdf
    create_git_aliases
    set_global_gitignore
    echo "\n✅  SETUP SUCCESSFUL ✅ \n"
  else
    echo "\n❌  SETUP ABORTED ❌ \n"
  fi
}

install_nvm() {
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
}
install_rvm() {
  \curl -sSL https://get.rvm.io | bash -s stable --ruby
}



install_asdf() {
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.7.6

  echo -e '\n. $HOME/.asdf/asdf.sh' >> ~/.zshrc
  echo -e '\n. $HOME/.asdf/completions/asdf.bash' >> ~/.zshrc
}
install_jabba(){
  curl -sL https://github.com/shyiko/jabba/raw/master/install.sh | bash && . ~/.jabba/jabba.sh
}
create_git_aliases() {
  git config --global alias.co checkout
  git config --global alias.br branch
  git config --global alias.ci commit
  git config --global alias.st status
  git config --global alias.amend "commit --amend --no-edit"
}
set_global_gitignore() {
  cp ./.global_gitignore ~/.global_gitignore
  git config --global core.excludesfile ~/.global_gitignore
}
# short for fixup_and_rebase
frb() {
  git commit --fixup=$1 && git rebase -i --autosquash $1~
}
cj() {
  j $1 && code .
}
uncommited_changes() {
  echo 'repos with uncommitted changes: '
  for dir in * ; do
    if [[ -d $dir  ]] && [[ -d $dir/.git ]]; then
      (
        cd $dir
        # do we have any change on repo?
        if [ 1 -ne `git status | grep 'nothing to commit' | wc -l` ]; then
          echo $dir
          git status -s
        fi
      );
    fi
  done

  echo
  echo 'repos with unpushed changes: '

  for dir in * ; do
    if [[ -d $dir  ]] && [[ -d $dir/.git ]]; then
      (
        cd $dir
        # do we have any unpushed commit on repo?
        if [ 0 -ne `git status | grep 'Your branch is ahead of' | wc -l` ]; then
          echo $dir
        fi
      );
    fi
  done

  echo
  echo 'repos on feature-branches: '

  for dir in * ; do
    if [[ -d $dir  ]] && [[ -d $dir/.git ]]; then
      (
        cd $dir
        # are we on master branch?
        if [ 1 -ne `git status | grep 'On branch master' | wc -l` ]; then
          echo $dir": "$(git rev-parse --abbrev-ref HEAD)
        fi
      );
    fi
  done
}