#!/usr/bin/env bash
set -eu

#
# Application installer (via brew-cask)
#

# Apps
apps=(
  1password
  qlcolorcode
  appcleaner
  firefox
  hazel
  vagrant
  flash
  iterm2
  qlprettypatch
  sublime-text3
  virtualbox
  atom
  qlstephen
  sketch
  vlc
  quicklook-json
  sourcetree
)

# fonts
fonts=(
  font-m-plus
  font-clear-sans
  font-roboto
)

# Atom packages
atom=(
  advanced-railscasts-syntax
  atom-beautify
  cmd-9
  color-picker
  css-comb
  docblockr
  editor-stats
  emmet
  file-icons
  git-history
  highlight-selected
  key-peek
  language-jade
  linter
  merge-conflicts
  neutron-ui
  npm-install
  react
  vim-mode
  zentabs
)

# Specify the location of the apps
appdir="/Applications"

# Check for Homebrew
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

main() {

  # Ensure homebrew is installed
  homebrew

  # Install homebrew-cask
  echo "installing cask..."
  #brew tap phinze/homebrew-cask
  #brew install brew-cask
  brew install caskroom/cask/brew-cask

  # Tap alternative versions
  brew tap caskroom/versions

  # Tap the fonts
  brew tap caskroom/fonts

  # install apps
  echo "installing apps..."
  brew cask install --appdir=$appdir ${apps[@]}

  # install fonts
  echo "installing fonts..."
  brew cask install ${fonts[@]}

  # install atom plugins
  echo "installing atom plugins..."
  apm install ${atom[@]}

  # link with alfred
  #alfred
  cleanup
}

homebrew() {
  if test ! $(which brew); then
    echo "Installing homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi
}

alfred() {
  brew cask alfred link
}

cleanup() {
  brew cleanup
}

main "$@"
exit 0
