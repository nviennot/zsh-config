#!/bin/bash

function gi() {
	t=$1
	shift

	if [ "${t:0:1}" = "t" ]; then
		echo "Correcting your mistake ;-)"
		git ${t:1} $*
	fi
}

zstyle ':completion:*:*:git:*' script ~/.oh-my-zsh/plugins/git/git_bash_completion.sh
