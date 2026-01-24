export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#50493e,bold"
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'

export ASPNETCORE_ENVIRONMENT="Development"
export PATH="$PATH:/home/vladislav/.dotnet/tools"
export DOTNET_ROOT=/usr/share/dotnet
export PATH=$PATH:$DOTNET_ROOT
export WORKSPACE_DIR="/home/vladislav/work/projects"
export LC_ALL=C.UTF-8
export DOTNET_SVCUTIL_TELEMETRY_OPTOUT=1
export DOTNET_USE_POLLING_FILE_WATCHER=true

export EDITOR='nvim'
export VISUAL='nvim'
export MANPAGER='nvim +Man!'

export TERM=xterm-256color

function parse_git_branch() {
    git branch 2> /dev/null | sed -n -e 's/^\* \(.*\)/ [\1]/p'
}

COLOR_DIR=$'%F{blue}'
COLOR_GIT=$'%F{red}'
COLOR_ARROW=$'%F{204}'
setopt PROMPT_SUBST

export PROMPT='${COLOR_DIR}%~${COLOR_ARROW}$(parse_git_branch)$f $ '

. "$HOME/.cargo/env"

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# autocompelete
autoload -Uz compinit && compinit
[[ $commands[kubectl] ]] && source <(kubectl completion zsh)

# edit-command-line
autoload -z edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line

# aliases
alias ggo="git log --graph --oneline"
alias ggs="git log --graph --shortstat"
alias gs="git status"

alias ls="ls --color=auto"
alias la="exa -lah --icons --no-permissions"

alias vim="nvim"
alias tmux="tmux -u"
alias tmux-ks="tmux kill-session -t"
alias tmux-ls="tmux list-sessions"

alias c="clear"
alias k="kubectl"

alias dr="dotnet run"
alias db="dotnet build"

fpath=( ~/.local/scripts $fpath )
autoload fcd
autoload ffcd

alias fd="fcd $WORKSPACE_DIR $HOME"
alias ff="ffcd $WORKSPACE_DIR $HOME"
alias tmux-news="zsh ~/.local/scripts/tmux-sessions.sh $WORKSPACE_DIR $HOME"
