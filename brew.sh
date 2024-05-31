# Install command-line tools using Homebrew

# Install homebrew if it is not installed
which brew 1>&/dev/null
if [ ! "$?" -eq 0 ] ; then
	echo "Homebrew not installed. Attempting to install Homebrew"
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
	if [ ! "$?" -eq 0 ] ; then
		echo "Something went wrong. Exiting..." && exit 1
	fi
fi

# Check system for potential problems
brew doctor

# Make sure we’re using the latest Homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade

# **********************************************************************#
#                        Basic Utilities                                #
#***********************************************************************#
brew install bash coreutils findutils gnu-sed gawk jq

# **********************************************************************#
#                        Common Tools                                   #
#***********************************************************************#

# Text interface for git
brew install tig

# Fonts
brew install font-inconsolata font-noto-sans

# **********************************************************************#
#                        Terminal gimicks                               #
#***********************************************************************#

# The computer fortune teller
brew install fortune

# ASCII cow art
brew install cowsay

# Remove outdated versions from the cellar
brew cleanup
