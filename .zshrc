# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="custom"

plugins=(git)

source $ZSH/oh-my-zsh.sh

# To exec when enw is open
emacs_eval="--eval '(menu-bar-mode -1)' \
	    --eval '(global-display-line-numbers-mode)'"
# Emacs 4 Terminal
alias enw="emacs -nw -Q $emacs_eval -bg black"
alias open="xdg-open"


# Tmux Start
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  exec tmux
fi


