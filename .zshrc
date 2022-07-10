# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="custom"

plugins=(git)

source $ZSH/oh-my-zsh.sh


alias enw="emacs -nw -Q --eval '(menu-bar-mode -1)' --eval '(global-display-line-numbers-mode)' -bg black"
alias open="xdg-open"


#Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='enw'
else
  export EDITOR='enw'
fi

