mkdir ~/src
cd ~/src
git clone https://github.com/tomchuk/dotfiles
cd dotfiles
git submodule init
git submodule update
cd prezto
git submodule init
git submodule update
cd ~
shopt -s dotglob
for file in src/dotfiles/.*; do
  ln -s $file .
done
rm .git
for file in src/dotfiles/prezto/runcoms/*; do
  ln -s $file ".`basname $file`"
done
ln -s src/dotfiles/preztto .zprezto

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"


# thomas ALL=(ALL) NOPASSWD: ALL /etc/sudoers

brew tap homebrew/cask-versions
brew cask install iterm2-nightly
brew install zsh zsh-completions
brew install vim --with-override-system-vi
if ! fgrep -q '/usr/local/bin/zsh' /etc/shells; then
  echo '/usr/local/bin/zsh' | sudo tee -a /etc/shells;
fi;
sudo chpass -s /usr/local/bin/zsh thomas

brew install coreutils moreutils findutils dark-mode speedtest_cli
brew install gnu-sed --with-default-names
brew install libpng libtiff libxml2 libjpeg wget tree htop gnupg
brew install awscli curl git git-lfs gpg-agent mas node the_silver_searcher watchman
brew cask install java8
brew install python mercurial git nginx rabbitmq mysql@5.7 redis elasticsearch@1.3 yarn

brew cask install appcleaner transmit vlc shimo little-snitch micro-snitch keybase paw handbrake
brew cask install bee backblaze bartender firefox-developer-edition steam dash intel-power-gadget
brew cask install google-chrome intensify-pro kaleidoscope muzzle tableplus transmission-nightly
brew cask install timer geekbench macs-fan-control

pip2 install hg-evolve
pip3 install flake8

mas install 413965349  #  Soulver
mas install 824183456  #  Affinity Photo
mas install 824171161  #  Affinity Designer
mas install 985614903  #  SQLPro Studio
mas install 890031187  #  Marked 2
mas install 411643860  #  DaisyDisk
mas install 1091189122 #  Bear
mas install 424390742  #  Compressor
mas install 777874532  #  Cinemagraph Pro
mas install 937984704  #  Amphetamine
mas install 1290358394 #  Cardhop
mas install 1333542190 #  1Password 7
mas install 874920950  #  Proxy
mas install 990588172  #  Gestimer
mas install 441258766  #  Magnet
mas install 638332853  #  Logitech Camera
mas install 975937182  #  Fantastical 2
mas install 924726344  #  Deliveries
mas install 461369673  #  VOX
mas install 431224317  #  Disk Drill
mas install 424389933  #  Final Cut
mas install 1312996177 #  Photolemur
mas install 1081413713 #  GIF Brewery
mas install 413535631  #  SignalScope Pro
mas install 1035350363 #  Teeny Tokyo
mas install 425424353  #  The Unarchiver
mas install 803453959  #  Slack
mas install 980406518  #  iPull
mas install 1262957439 #  Textual 7
mas install 576338668  #  Leaf
mas install 425264550  #  Blackmagic Disk Speed Test
mas install 413535631  #  SignalScope Pro
