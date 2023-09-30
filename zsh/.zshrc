export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#50493e,bold"
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'

export ASPNETCORE_ENVIRONMENT="Development"

function parse_git_branch() {
    git branch 2> /dev/null | sed -n -e 's/^\* \(.*\)/[\1]/p'
}

COLOR_DEF=$'%f{green}'
COLOR_USR=$'%F{green}'
COLOR_DIR=$'%F{blue}'
COLOR_GIT=$'%F{red}'
setopt PROMPT_SUBST
export PROMPT='${COLOR_USR}%n ${COLOR_DIR}%~ ${COLOR_GIT}$(parse_git_branch)$f $ '

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# autocompelete
autoload -Uz compinit && compinit

# aliases
alias ggo="git log --graph --oneline"
alias ggs="git log --graph --shortstat"

alias la="ls -a"

# fuzzy cd
function fcd() { 
    cd $(find $1 -path "./proc/*" -prune -o -path "/proc/*" -prune -o -type d | fzf); 
};
