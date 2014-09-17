function zle-line-init zle-keymap-select {
  zle reset-prompt
}
function zle-line-init zle-keymap-select {
	VIM_PROMPT="%{$fg_bold[yellow]%} [% NORMAL]% %{$reset_color%}"
	RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/} %{$fg_no_bold[blue]%}[%*]%{$reset_color%}"
	zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

bindkey -v
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^r' history-incremental-search-backward

export KEYTIMEOUT=1
