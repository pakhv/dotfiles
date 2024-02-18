export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#50493e,bold"
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
export CHATGE_OLLAMA_HOST=host.docker.internal:11434
export CHATGE_OLLAMA_MODEL=llama2
export EDITOR='nvim'
export VISUAL='nvim'
export WORKSPACE_DIR="/workspaces/rust"

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
alias gs="git status"

alias vim="nvim"

alias la="ls -a"
. "$HOME/.cargo/env"

alias vim="nvim"
alias tmux="tmux -u"

alias c="clear"

fpath=( ~/.local/scripts $fpath )
autoload fcd
autoload ffcd
autoload tmux-news-def
autoload tmux-neww-def

alias fd="fcd $WORKSPACE_DIR $HOME"
alias ff="ffcd $WORKSPACE_DIR $HOME"
alias tmux-news="tmux-news-def $WORKSPACE_DIR $HOME"
alias tmux-neww="tmux-neww-def $WORKSPACE_DIR $HOME"
