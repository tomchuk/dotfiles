# Add your own custom plugins in the custom/plugins directory. Plugins placed
# here will override ones with the same name in the main plugins directory.
[ -f ~/.aliases ] && source ~/.aliases
[ -f ~/.exports ] && source ~/.exports
unalias run-help > /dev/null 2>&1
autoload run-help
HELPDIR=/usr/local/share/zsh/help
DEFAULT_USER='thomas'
bindkey "\e[1~" beginning-of-line
bindkey "\e[4~" end-of-line
fpath=(/usr/local/share/zsh-completions $fpath)
