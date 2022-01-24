install_autojump() {
  echo "\ninstalling autojump..."
  brew install autojump
}
install_fzf() {
  echo "\ninstalling fzf (fuzzy-finder)..."
  brew install fzf

  # To install useful key bindings and fuzzy completion:
  $(brew --prefix)/opt/fzf/install
}
