export VIM_APP_DIR=/Applications
MACVIM_APP="${VIM_APP_DIR}/MacVim.app"
if [ -d "${MACVIM_APP}" ]; then
	export PATH="${MACVIM_APP}/Contents/bin:${PATH}"
fi
