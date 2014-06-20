
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
		#find "${DIR}" -type f -print0 | xargs -0 grep $GREP_ARGS --color -n "$PAT"
		# -S: follow symlinks
		# -s: ignore non-existent/unreadable files
		# -I: ignore binary files
		# -n: output line numbers
		grep -sInR --exclude-dir '.git' --color=always $GREP
		DIR=$1
		shift
	done
}

__fif_usage() {
	echo "usage: fif [grep-options] {pattern} [directory]"
	echo "        [grep-options]   : 'options' are passed directly to grep"
	echo "        {pattern}        : simple pattern or POSIX regex (grep style)"
	echo "        [directory]      : directory to search (defaults to ./)"
	echo ""
	return
}

# find-in-files: ignore warnings/errors
fif() {
	local GA=
	local PAT=${1/ /\\ }
	shift
	while [[ "${PAT:0:1}" = "-" ]]; do
		if [ "$PAT" = "-h" -o "$PAT" = "--help" ]; then
			__fif_usage
			return
		fi
		GA="$GA $1"
		shift
		PAT=${1/ /\\ }
		shift
	done

	if [ ! -z "$GA" ]; then
		__fif -ga "$GA" "$PAT" $@ 2>/dev/null
	else
		__fif "$PAT" $@ 2>/dev/null
	fi
}

# Find a file in the current, or specified directory
ff() {
	local find_args=
	local fname=$1
	shift

	while [[ "$fname" = "-fa" ]]; do
		find_args="${find_args} $1"
		shift
		fname=$1
		shift
	done

	if [ -z "$fname" -o "$fname" = "-h" ]; then
		echo "usage: ff {-fa find-arg {-fa other-find-arg} ...} [name_of_file] {dir}"
		return
	fi
	
	find ${1:-.} -type f -name ${fname} ${find_args}
}
