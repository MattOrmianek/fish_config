
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
#eval /Users/mateuszormianek/opt/anaconda3/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<

# THEME PURE #
set fish_function_path /Users/mateuszormianek/.config/fish/functions/theme-pure/functions/ $fish_function_path
#source /Users/mateuszormianek/.config/fish/functions/theme-pure/conf.d/pure.fish

#alias l='ls -all'
alias gitl="git log --graph --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%an%C(reset)%C(bold yellow)%d%C(reset) %C(dim white)- %s%C(reset)' --all"

function p
    python3 $argv
end
function vs
    code $argv
end

function sz
    python3 /Users/mateuszormianek/functions/sz.py $argv
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

function cm
    cd ~
end

function cc
    cd ~/.config/fish
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

function is_venv
    # Check for the presence of the bin folder
    if test -d $argv/bin
        # Check for the presence of the activate script inside the bin folder
        if test -f $argv/bin/activate
            return 0 # Return 0 if both conditions are met, meaning it's likely a venv
        end
    end
    return 1 # Return 1 if any condition is not met, meaning it's not a venv
end

function nl
    # Check if the current directory is a Git repository
    git rev-parse --is-inside-work-tree > /dev/null 2>&1
    if test $status -ne 0
        echo "Not a Git repository."
        return 1
    end

    set -l changes (git diff --shortstat HEAD 2>&1)
    if test $status -ne 0
        echo "Error or warning occurred: $changes"
        return 1
    end

    # Extract insertions and deletions
    set -l insertions (echo $changes | grep -o '\([0-9]\+\) insertion' | sed 's/[^0-9]*//g')
    set -l deletions (echo $changes | grep -o '\([0-9]\+\) deletion' | sed 's/[^0-9]*//g')

    # Summarize the changes
    set -l total_insertions (math "$insertions + 0")
    set -l total_deletions (math "$deletions + 0")

    # Check how many lines of code there are in the project, excluding virtual environments
    set -l total_lines 0
    set -l without_paths ""
    for dir in ./*/
        if is_venv $dir
            set without_paths "$dir"
        end
    end
    echo "Excluding paths: $without_paths"

    set total_lines (sz --without $without_paths | grep 'total line count:' | awk '{ print $4 }')
    echo "lines: $total_lines | insertions: $total_insertions | deletions: $total_deletions"
end

