# -F : Causes less to automatically exit if the entire file can be displayed on
#      the first screen
# -i : ignore case (unless search term contains uppercase characters)
# -J : displays a status column at the left edge of the screen
# -m : prompt more verbosely (like more)
# -R : output raw characters, e.g. ^A (octal 001) EXCEPT for ANSI "color" escape sequences
# -X : disable termcap init/deinit, i.e., don't clear screen on start/exit
export PAGER="less -FimRX"
