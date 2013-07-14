##Installation

To install you first need to pull from the git repo:

~~~~
git clone git://github.com/forbajato/dotfiles.git
~~~~

I came to the pathogen party late so only some of my vim plugins are in bundles - need to clean this up sometime in the future.  To update the bundles:

~~~~
cd dotfiles
git submodule init
git submodule update
~~~~

##Create the links
In order to keep all my configs consistent across machines I need to create symlinks back to these repo config files.  The problem is that any program that changes a config file programmatically will break the link.  As such these files are ones that shouldn't be subject to such a problem.  This list may well grow as I find out more about the config files for various programs that are important to me.  In the repo each important config file is named just as it should be in its proper location but with no leading dot so that it is not hidden here.

~~~~
ln -s ~/dotfiles/vimrc ~/.vimrc
ln -s ~/dotfiles/vim ~/.vim
ln -s ~/dotfiles/zshrc ~/.zshrc
ln -s ~/dotfiles/screenrc ~/.screenrc
~~~~

For some reason TaskWarrior doesn't tolerate a symlink for its config file so I need to hard link it:

~~~~
ln ~/dotfiles/taskrc ~/.taskrc
~~~~

