#!/bin/bash

function gi() {
	t=$1
	shift

	if [ "${t:0:1}" = "t" ]; then
		echo "Correcting your mistake ;-)"
		git ${t:1} $*
	fi
}

