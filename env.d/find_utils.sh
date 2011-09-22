
# find-functions-in-files implementation
# (incomplete...)
__ffif() {
	local MAX_ARGS=10
	local GREP_ARGS=
	if [ "$1" = "-ga" ]; then
		GREP_ARGS=$1
		shift
	fi

	local FCN=$1
	local NARGS=$2
	shift
	shift

	if [ $NARGS -lt 1 -o $NARGS -gt $MAX_ARGS ]; then
		echo "ffif: too many arguments ($MAX_ARGS max)"
		return
	fi
	local N=
	let N=NARGS-1
	local argregex='\([^,]\+,\)\{'${N}'\}[^,]\+'

	local DIR=${1:-.}
	shift

	until [ -z "$DIR" ]; do
		echo -e "Searching for \033[1;32m$argregex\033[0m in \033[0;33m${DIR}\033[0m"
		find "${DIR}" -type f -print0 | xargs -0 -E '\0' cat | grep $GREP_ARGS -z -n "${FCN}(${argregex}" | grep --color -n "${FCN}"
		DIR=$1
		shift
	done
}

# find-in-files implementation
__fif() {
	local GREP_ARGS=
	local PAT=$1
	shift

	if [ "$PAT" = "-ga" ]; then
		GREP_ARGS=$1
		shift
		PAT=$1
		shift
	fi

	local DIR=${1:-.}
	shift

	until [ -z "$DIR" ]; do
		find "${DIR}" -type f -print0 | xargs -0 grep $GREP_ARGS --color -n "$PAT"
		DIR=$1
		shift
	done
}

# find-in-files: ignore warnings/errors
fif() {
	local PAT=${1/ /\\ }
	shift
	if [ "$PAT" = "-h" ]; then
		echo "usage: fif [-ga] {pattern} [directory]"
		echo "        -ga [options]    : 'options' are passed directly to grep"
		echo "        {pattern}        : simple pattern or POSIX regex (grep style"
		echo "        [directory]      : directory to search (defaults to ./)"
		echo ""
		return
	elif [ "$PAT" = "-ga" ]; then
		local GA=$1
		shift
		PAT=${1/ /\\ }
		shift
		__fif -ga $GA "$PAT" $@ 2>/dev/null
	else
		__fif "$PAT" $@ 2>/dev/null
	fi
}

# Find a file in the current, or specified directory
ff() {
	FNAME=$1
	if [ -z "$FNAME" -o "$FNAME" = "-h" ]; then
		echo "usage: ff [name_of_file] {dir}"
	else
		find ${2:-.} -type f -name ${FNAME}
	fi
}
