Installation
------------

To install, run

    git clone git://github.com/nviennot/zsh-config.git ~/.zsh
    cd ~/.zsh
    make install

To update the repository, run

    make update

Key Bindings
-------------

`Ctrl + b` Go back in the directory location history  
`Ctrl + f` Go forward in the directory location history  
`Ctrl + u` Go up in the directory structure  
`Ctrl + k` ls  
`Alt + v` vim  

Not ideal, I'm open to suggestions.

Features
--------

* The git status is printed in the prompt. To disable type `nog` (huge
  repositories tend to slow down the shell). Also disable git completion
* The command history is shared across sessions (very useful with `Ctrl + r`).
  To disable type `noh` (useful when all you are doing is Up arrow + Enter).
* Syntax is highlighted.
* No need to type `bundler exec` for most commands (annotate cap capify
  cucumber ey foreman guard heroku middleman nanoc rackup rainbows rails rake
  rspec ruby shotgun spec spork thin thor unicorn unicorn\_rails).
* `vi file:123` will open file at line 123.
* hitch is supported
* To load nodejs bin directory in the $PATH, type `npm_bin`
