install_autojump() {
  echo "# Source autojump \n. /usr/share/autojump/autojump.sh" >> ~/.zshrc

  # # if the command above does not work, run the following:
  # git clone git://github.com/wting/autojump.git && \
  # cd autojump && \
  # ./install.py && \
  # cd .. && rm -rf ./autojump
}
