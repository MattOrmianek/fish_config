
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
#eval /Users/mateuszormianek/opt/anaconda3/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<

# THEME PURE #
set fish_function_path /Users/mateuszormianek/.config/fish/functions/theme-pure/functions/ $fish_function_path
#source /Users/mateuszormianek/.config/fish/functions/theme-pure/conf.d/pure.fish

#alias l='ls -all'
alias gitl="git log --graph --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%an%C(reset)%C(bold yellow)%d%C(reset) %C(dim white)- %s%C(reset)' --all"

function vs
    code $argv
end

function sz
    python3 /Users/mateuszormianek/functions/sz.py
end

function c
    clear
end

function c.
    cd ..
end

function c..
    cd ../..
end

function c...
    cd ../../..
end

function cD
    cd /Users/mateuszormianek/Desktop
end

function cw
    cd /Users/mateuszormianek/Desktop/pracka
end

function f
    fish
end


function b
    git branch
end

function venv
    source $argv[1]/bin/activate.fish
    echo "Activated virtual environment at $argv[1]"
end

function l
    ls -lt | awk 'NR > 1 {
        type = ($1 ~ /^d/) ? "D" : "F";
        color_start = ($1 ~ /^d/) ? "\033[35m" : ($9 ~ /\.py$/) ? "\033[32m" : "";
        color_end = "\033[0m";
        size = $5;
        unit = "B";
        if (size >= 1024) {
            size = size / 1024;
            unit = "KB";
        }
        if (size >= 1024) {
            size = size / 1024;
            unit = "MB";
        }
        printf " %s%-30s%s %-2s %-3s %-3s %-5s | %-2s %-5.0f \n", color_start, $9, color_end, type, $7, $6, $8, unit, size
    }'
end

function nl
    # Get the number of inserted lines from the last commit
    set -l insertion (git diff --stat HEAD | tail -n 1 | awk '{print $4}')
    
    # Get the number of deleted lines from the last commit
    set -l deletion (git diff --stat HEAD | tail -n 1 | awk '{print $6}')
    
    # Calculate the sum of inserted and deleted lines
    set sum (math $insertion + $deletion)
    
    # Display the total changed lines since the last commit
    echo "Changed lines since last commit: $sum"
end
