# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ZINIT Plugins directory
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download ZINIT (if not installed)
if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source ZINIT
source "${ZINIT_HOME}/zinit.zsh"

# Add in Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

### Plugins ###

## Zsh Plugins
# Syntax Highlighting
zinit light zsh-users/zsh-syntax-highlighting

# Completions
zinit light zsh-users/zsh-completions

# Auto Suggestions
zinit light zsh-users/zsh-autosuggestions

# Fzf-tab
zinit light Aloxaf/fzf-tab

# You Should use
zinit light MichaelAquilina/zsh-you-should-use

# Evalcache
zinit light mroth/evalcache

## Oh-My-Zsh Plugins
# Git (aliases)
zinit snippet OMZP::git

# Load completions (once in 24H)
autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
    compinit
done
compinit -C

# Custom aliases
source ~/.aliases

# Brew path
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Keybindings
bindkey '^k' history-search-backward
bindkey '^j' history-search-forward

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Fzf theme
export FZF_DEFAULT_OPTS='--color=fg:#d1c6ad,fg+:#d1c6ad,bg:-1,bg+:-1,hl:#8cb9b3,hl+:#85d8cd,info:#afaf87,marker:#b5df63,prompt:#e96866,spinner:#e09064,pointer:#e09064,header:#87afaf,border:#d1c6ad,label:#aeaeae,query:#f8f5e6 --border="rounded" --border-label="" --preview-window="border-rounded" --prompt=" " --marker=">" --pointer=" " --separator="─" --scrollbar="│"'

# Fzf-tab Completion styling
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza -1 --color=always --icons=always $realpath'
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always --icons=always $realpath'
zstyle ':fzf-tab:*' --bind=tab:accept

# Fzf-tab Theme
zstyle ':fzf-tab:*' fzf-flags --color=fg:#d1c6ad,fg+:#d1c6ad,bg:-1,bg+:-1,hl:#8cb9b3,hl+:#85d8cd,info:#afaf87,marker:#b5df63,prompt:#e09064,spinner:#e09064,pointer:#91bb87,header:#87afaf,border:#d1c6ad,label:#aeaeae,query:#f8f5e6 --border="rounded" --border-label="" --preview-window="border-rounded" --prompt=" " --marker=">" --pointer=" " --separator="─" --scrollbar="│"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Show commands execute time even if instant
typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=0
typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_PRECISION=1
typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_FORMAT='d h m s'

# NVM (node-version-manager) / Lazy load it
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
alias nvm="unalias nvm; [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"; nvm $@"

## Shell integrations
# FZF
_evalcache fzf --zsh

# Zoxide
_evalcache zoxide init --cmd cd zsh


# Yazi
function y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    yazi "$@" --cwd-file="$tmp"
    IFS= read -r -d '' cwd < "$tmp"
    [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
    rm -f -- "$tmp"
}

# Setting default editor to "nvim"
export EDITOR="nvim"

# .local/bin to path
export PATH=~/.local/bin/:$PATH

# Multi nvim builds
alias nvchad="NVIM_APPNAME=NvChad nvim"
alias lazyvim="NVIM_APPNAME=LazyVim nvim"

function nvs() {
    items=("default" "NvChad" "LazyVim" "AstroNvim" "Neovim")
    config=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Neovim Configs " --height=~50% --layout=reverse --border --exit-0)
    if [[ -z $config ]]; then
        echo "Nothing selected"
        return 0
    elif [[ $config == "default" ]]; then
        config=""
    fi
    NVIM_APPNAME=$config nvim $@
}

# eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
