# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
export ZSH_THEME="jeremya"

# Set to this to use case-sensitive completion
# export CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
export DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# export DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# export DISABLE_AUTO_TITLE="true"

# Path to your shell environment customization directory
export CUSTOM_ENV_DIR=$HOME/.env.d

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git github git-flow cap gem lol zsh-syntax-highlighting bundler heroku)

source /etc/profile
source $ZSH/oh-my-zsh.sh

unsetopt nomatch

#bindkey "\e[H" beginning-of-line
#bindkey "\e[F" end-of-line
bindkey "\e[1;5D" backward-word
bindkey "\e[1;5C" forward-word

alias noh="unsetopt sharehistory"

unsetopt auto_name_dirs # rvm_rvmrc_cwd fix
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session.
unset RUBYOPT
cd . # to rvm reload

if [[ -x `which hitch` ]]; then
	hitch() {
		command hitch "$@"
		if [[ -s "$HOME/.hitch_export_authors" ]] ; then source "$HOME/.hitch_export_authors" ; fi
	}
	alias unhitch='hitch -u'
	hitch
fi

alias nogit="disable_git_prompt_info; compdef -d git"
alias nog="nogit"

export PATH="$HOME/bin:/opt/local/bin:$PATH"

# customize the environment a bit
function source_dir() {
	envdir=$1
	re_env_ignore="^\."
	if [ -d "$envdir" ]; then
		_T=$(ls "$envdir")
		if [ ! -z "$_T" ]; then
			for d in $(ls -1 "$envdir"); do
				if [[ "$d" =~ $re_env_ignore ]]; then
					echo "ignoring env setup file '$d'" > /dev/null
				else
					source "$envdir/$d"
				fi
			done
		fi
	fi
}

source_dir "$CUSTOM_ENV_DIR"
source_dir "$ZSH/env.d"

