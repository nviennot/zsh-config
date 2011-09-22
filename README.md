Introduction
=============

It comes from the oh-my-zsh config and from nviennot's zsh config :)


Installation
=============

    cd ~
    git clone git://github.com/afrojer/zsh-config.git .oh-my-zsh
    ln -s .oh-my-zsh/zshrc .zshrc
    cd .oh-my-zsh
    git submodule init
    git submodule update
    chsh -s `which zsh`
