# Create LS_COLORS environment variable from gdircolors file in $ZSH/
# (use the grep -v for OSX compatibility)
DIRCOLORS=`which dircolors | grep -v "dircolors not found"`
if [ -z "$DIRCOLORS" ]; then
	DIRCOLORS=`which gdircolors | grep -v "gdircolors not found"`
fi
if [ ! -z "$DIRCOLORS" ]; then
	# Try a color file in the custom environment directory first
	if [ -r $CUSTOM_ENV_DIR/gdircolors ]; then
		eval $($DIRCOLORS -b "$CUSTOM_ENV_DIR/gdircolors")
	elif [ -r "$ZSH/gdircolors" ]; then
		eval $($DIRCOLORS -b "$ZSH/gdircolors")
	fi
else
	LS_COLORS='no=00;32:fi=00:di=00;34:ln=01;36:pi=04;33:so=01;35:bd=33;04:cd=33;04:or=31;01:ex=00;32:*.rtf=00;33:*.txt=00;33:*.html=00;33:*.doc=00;33:*.pdf=00;33:*.ps=00;33:*.sit=00;31:*.hqx=00;31:*.bin=00;    31:*.tar=00;31:*.tgz=00;31:*.arj=00;31:*.taz=00;31:*.lzh=00;31:*.zip=00;31:*.z=00;31:*.Z=00;31:*.gz=00;31:*.deb=00;31:*.dmg=00;36:*.jpg=00;35:*.gif=00;35:*.bmp=00;35:*.ppm=00;35:*.tga=00;35:*.xbm=00;35:*.    xpm=00;35:*.tif=00;35:*.mpg=00;37:*.avi=00;37:*.gl=00;37:*.dl=00;37:*.mov=00;37:*.mp3=00;35:'
fi

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
ZSH_HIGHLIGHT_STYLES+=(
  default                       'none'
  unknown-token                 'fg=red,bold'
  reserved-word                 'fg=yellow'
  alias                         'fg=none,bold'
  builtin                       'fg=none,bold'
  function                      'fg=none,bold'
  command                       'fg=none,bold'
  hashed-command                'fg=none,bold'
  path                          'fg=cyan'
  globbing                      'fg=cyan'
  history-expansion             'fg=blue'
  single-hyphen-option          'fg=magenta'
  double-hyphen-option          'fg=magenta'
  back-quoted-argument          'fg=magenta,bold'
  single-quoted-argument        'fg=green'
  double-quoted-argument        'fg=green'
  dollar-double-quoted-argument 'fg=cyan'
  back-double-quoted-argument   'fg=cyan'
  assign                        'none'
)

function term_color_map() {
	# This function echoes a bunch of color codes to the terminal to demonstrate
	# what's available. Each line is the color code of one forground color,
	# out of 17 (default + 16 escapes), followed by a test use of that color
	# on all nine background colors (default + 8 escapes).
	#
	# Code originally from:
	# http://bitmote.com/index.php?post/2012/11/19/Using-ANSI-Color-Codes-to-Colorize-Your-Bash-Prompt-on-Linux
	#
	T='gYw'   # The test text
	echo -e "\n                 40m     41m     42m     43m     44m     45m     46m     47m";
	for FGs in '    m' '   1m' '  30m' '1;30m' '  31m' '1;31m' '  32m' '1;32m' '  33m' '1;33m' '  34m' '1;34m' '  35m' '1;35m' '  36m' '1;36m' '  37m' '1;37m';
	    do FG=${FGs// /}
	    echo -en " $FGs \033[$FG  $T  "
	    for BG in 40m 41m 42m 43m 44m 45m 46m 47m;
	        do echo -en "$EINS \033[$FG\033[$BG  $T \033[0m\033[$BG \033[0m";
	    done
	    echo;
	done
	echo
}

function full_color_map() {
	#
	# generates an 8 bit color table (256 colors) for reference,
	# using the ANSI CSI+SGR \033[48;5;${val}m for background and
	# \033[38;5;${val}m for text (see "ANSI Code" on Wikipedia)
	#
	# Code originally from:
	# http://bitmote.com/index.php?post/2012/11/19/Using-ANSI-Color-Codes-to-Colorize-Your-Bash-Prompt-on-Linux
	#
	echo -en "\n   +  "
	for i in {0..35}; do
	    printf "%2b " $i
	done
	printf "\n\n %3b  " 0
	for i in {0..15}; do
	    echo -en "\033[48;5;${i}m  \033[m "
	done
	#for i in 16 52 88 124 160 196 232; do
	for i in {0..6}; do
	    let "i = i*36 +16"
	    printf "\n\n %3b  " $i
	    for j in {0..35}; do
	        let "val = i+j"
	        echo -en "\033[48;5;${val}m  \033[m "
	    done
	done
	echo -e "\n"
}
