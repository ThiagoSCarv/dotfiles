starship init fish | source

# Mostrar Fastfetch ao abrir o terminal
if status is-interactive
    fastfetch
end

fish_config theme choose "Rosé Pine"

# Melhor ls
alias ls="eza --icons --group-directories-first --color=always"
# Cat com syntax highlight
alias cat="bat" 
# === Aliases essenciais ===
alias la="eza -la --icons --group-directories-first"
alias ll="eza -l --icons --group-directories-first"
alias lt="eza --tree --icons"

alias grep="rg"

alias cls="clear"
alias financa="cd ~/finance-control-notion && npx ts-node src/main.ts"
# Navegação inteligente
zoxide init fish | source
alias cd="z"
# ─── Path Correto para fdfind (fd) ────────────────────────────────
if type -q fdfind
  alias fd="fdfind"
end
# FZF com Ctrl+R para histórico
if type -q fzf
    bind \cr 'fzf | read -l result; and commandline -r $result'
end

function fzf --wraps="fzf"
    # Paste contents of preferred variant here
    set -Ux FZF_DEFAULT_OPTS "
      --color=fg:#908caa,bg:#191724,hl:#ebbcba
      --color=fg+:#e0def4,bg+:#26233a,hl+:#ebbcba
      --color=border:#403d52,header:#31748f,gutter:#191724
      --color=spinner:#f6c177,info:#9ccfd8
      --color=pointer:#c4a7e7,marker:#eb6f92,prompt:#908caa"
    command fzf
end

function fz --description 'Jump to a directory using zoxide + fzf with preview'
    if not type -q zoxide
        echo "zoxide não instalado. Instale com: sudo pacman -S zoxide"
        return 1
    end

    set -l preview_cmd
    if type -q eza
        set preview_cmd "eza -al --group-directories-first --icons --color=always {} | head -n 200"
    else
        set preview_cmd "ls -al {} | head -n 200"
    end

    set -l target (zoxide query -l | fzf \
        --height=90% --layout=reverse --border \
        --preview "$preview_cmd" \
        --preview-window=right,50%,border)

    if test -n "$target"
        cd "$target"
        commandline -f repaint
    end
end
# -------------------------
# NVM auto-load via nvm.fish
# -------------------------
# Carrega a versão do Node de acordo com o .nvmrc
function load_nvm_version --on-variable PWD
    if test -f .nvmrc
        set node_version (string trim (cat .nvmrc))
        if not nvm use $node_version >/dev/null 2>&1
            echo "Instalando Node $node_version..."
            nvm install $node_version
        end
    else
        nvm use default >/dev/null 2>&1
    end
end
