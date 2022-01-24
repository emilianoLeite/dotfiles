install_autojump() {
  echo "\ninstalling autojump..."
  echo "# Source autojump \n. /usr/share/autojump/autojump.sh" >> ~/.zshrc

  # # if the command above does not work, run the following:
  # git clone git://github.com/wting/autojump.git && \
  # cd autojump && \
  # ./install.py && \
  # cd .. && rm -rf ./autojump
}
install_fzf() {
  echo "\ninstalling fzf (fuzzy-finder)..."
  sudo apt-get install fzf

  # Alternatively, you can "git clone" this repository to any directory and run install script.

  # git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  # ~/.fzf/install
}
