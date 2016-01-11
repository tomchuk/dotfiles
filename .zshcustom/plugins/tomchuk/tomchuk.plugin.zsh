# Add your own custom plugins in the custom/plugins directory. Plugins placed
# here will override ones with the same name in the main plugins directory.
[ -f ~/.aliases ] && source ~/.aliases
[ -f ~/.exports ] && source ~/.exports
unalias run-help
autoload run-help
HELPDIR=/usr/local/share/zsh/help
DEFAULT_USER='thomas'
bindkey "\e[1~" beginning-of-line
bindkey "\e[4~" end-of-line
