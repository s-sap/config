# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export PATH="$PATH:/home/ss/.local/bin"

# export GOPATH="$HOME/.go"
# export PATH=$PATH:$GOPATH/bin
# export GOROOT="/usr/bin/go"
# export PATH=$PATH:$GOROOT/bin


ZSH_THEME="custom"
plugins=(
    git
    zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# To exec when enw is open
emacs_eval="--eval '(menu-bar-mode -1)' \
	    --eval '(global-display-line-numbers-mode)'"


alias enw="emacs -nw -Q $emacs_eval"
alias open="xdg-open"
alias rmx="shred -uzvn5"
alias eopen="emacsclient -n"


# RUN tmux in emacs terminal only
if [[ $TERM == "eterm-color" ]]; then
    exec tmux
fi


xset r rate 350 60
