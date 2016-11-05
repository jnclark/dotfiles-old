# dotfiles
My configuration files.

## latexmkrc
tested on Linux, incorporates SageTeX to latexmk

## vimrc
tested on Linux, to pull all submodules easily, utilize 

git config --global alias.pullall '!f(){ git pull "$@" && git submodule update --init --recursive; }; f'
