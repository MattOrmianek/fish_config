

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
#eval /Users/mateuszormianek/opt/anaconda3/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<

# THEME PURE #
set fish_function_path /Users/mateuszormianek/.config/fish/functions/theme-pure/functions/ $fish_function_path
#source /Users/mateuszormianek/.config/fish/functions/theme-pure/conf.d/pure.fish

#alias l='ls -all'
alias gitl="git log --graph --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%an%C(reset)%C(bold yellow)%d%C(reset) %C(dim white)- %s%C(reset)' --all"

function f
    fish
end

# Function for checking name and email of git user
function gml
    git config --global user.name
    git config --global user.email
end

function corti
    echo "Before change: "
    git config --global user.name
    git config --global user.email

    #change to TechOcean login and email
    git config --global user.name "Mateusz Ormianek"
    git config --global user.email "mormianek@cortivision.com"

    echo "After change: "
    git config --global --get user.name
    git config --global --get user.email
end

function to
    echo "Before change: "
    git config --global user.name
    git config --global user.email

    #change to TechOcean login and email
    git config --global user.name "Mateusz Ormianek"
    git config --global user.email "m.ormianek@techocean.pl"

    echo "After change: "
    git config --global --get user.name
    git config --global --get user.email
end

function git_last
    # Get the author name and email
    set author_info (git log -1 --pretty=format:"Author: %an <%ae>")

    # Get the commit time
    set commit_time (git log -1 --pretty=format:"Time: %ad")

    # Get the commit description
    set commit_desc (git log -1 --pretty=format:"Description: %s")

    # Print gathered information
    echo $author_info
    echo $commit_time
    echo $commit_desc
    echo "Changes:"

    # Get the list of changed files
    set changed_files (git show --name-only --pretty=format:"" HEAD)

    # Loop through each changed file to count insertions and deletions
    for file in $changed_files
        # Count the insertions and deletions for the current file
        set deletions (git diff HEAD^ HEAD -- $file | grep '^[-]' | grep -vc '^[-][-]')
        set insertions (git diff HEAD^ HEAD -- $file | grep '^[+]' | grep -vc '^[+][+]')
        echo -e "\033[32m$file: INSERTIONS: $insertions\033[32m |\033[31m DELETIONS: $deletions \033[0m"
    end
end

function git_last_expanded
    # Get the list of changed files
    set changed_files (git show --name-only --pretty=format:"" HEAD)

    # Loop through each changed file to show line-by-line changes
    for file in $changed_files
        echo "File: $file"
        git diff HEAD^ HEAD -- $file | awk '/^[+-]/ && !/^(--- a\/|\+\+\+ b\/)/ { print }' | while read -l line
            set first_char (string sub -l 1 -- $line)
            if test "$first_char" = "+"
                # Green color for lines starting with +
                echo -e "\t\033[32m$line\033[0m"
            else if test "$first_char" = "-"
                # Red color for lines starting with -
                echo -e "\t\033[31m$line\033[0m"
            end
        end
    end
end

function git
    if test "$argv[1]" = "push"
        set global_email (git config --global user.email)
        set global_name (git config --global user.name)
        set local_email (git config user.email)
        set local_name (git config user.name)

        echo "Globalny autor: $global_name <$global_email>"
        if test -n "$local_email" -o -n "$local_name"
            echo "Lokalny autor: $local_name <$local_email>"
        end

        read -l -P 'Do you want to continue? [Y/N] ' confirm

        switch $confirm
            case Y y
                command git push $argv[2..-1]
            case '' N n
                echo "Operacja przerwana przez użytkownika."
                return 1
        end

    else
        command git $argv
    end
end


function test_prompt
 
end

function read_confirm
  while true
    
  end
end


function s
    find . -name "$argv"
end

function se
    find . -name "*$argv*"
end

# Function for editing plan.txt
function pl
    if test "$argv" = "d"
        rm /Users/mateuszormianek/plan.txt
        touch /Users/mateuszormianek/plan.txt
    else if test "$argv" = "e"
        nano /Users/mateuszormianek/plan.txt
    else
        cat /Users/mateuszormianek/plan.txt
    end
end


function nq
    networkquality
end

function gl
    gitl
end

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

function gp
    git push
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

function b
    git branch
end

function venv
    source $argv[1]/bin/activate.fish
    echo "Activated virtual environment at $argv[1]"
end

function l
    set -l grep_pattern ""
    set -l sort_option ""
    set -l max_length 20
    set -l max_files 0
    set -l arg_count (count $argv)

    if test $arg_count -eq 0
        set grep_pattern ""
        set sort_option ""
        set max_files 0
    else
        for i in (seq $arg_count)
            switch $argv[$i]
                case "g"
                    if test (math "$i + 1") -le $arg_count
                        set grep_pattern $argv[(math "$i + 1")]
                        set i (math "$i + 1")
                    end
                case "S"
                    set sort_option "-S"
                case "m"
                    if test (math "$i + 1") -le $arg_count
                        set max_files $argv[(math "$i + 1")]
                        set i (math "$i + 1")
                    end
            end
        end
    end

    for file in (ls)
        set -l length (string length $file)
        if test $length -gt $max_length
            set max_length $length
        end
    end

    set -l cmd "ls -lt"
    if test -n "$sort_option"
        set cmd "$cmd $sort_option"
    end

    eval $cmd | awk -v pattern="$grep_pattern" -v max_len="$max_length" -v max_files="$max_files" 'BEGIN {count=0} NR > 1 {
        if ($9 == "all" || (pattern != "" && $9 !~ pattern)) next;
        count++;
        if (max_files > 0 && count > max_files) exit;
        type = ($1 ~ /^d/) ? "D" : "F";
        color_start = ($1 ~ /^d/) ? "\033[35m" : ($9 ~ /\.py$/) ? "\033[32m" : "";
        color_end = "\033[0m";
        size = $5;
        unit = "B";
        if (size >= 1024) {
            size /= 1024;
            unit = "KB";
        }
        if (size >= 1024) {
            size /= 1024;
            unit = "MB";
        }
        if (size >= 1024) {
            size /= 1024;
            unit = "GB";
        }
        if (size >= 1024) {
            size /= 1024;
            unit = "TB";
        #}
        printf " %s%-" max_len "s%s %-2s %-3s %-3s %-5s | %-6.1f %-2s \n", color_start, $9, color_end, type, $7, $6, $8, size, unit
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
    set -l split_opt ""
    set -l split_status False
    # Check for split argument
    if test "$argv[1]" = "s"
        set split_opt "--split"
        set split_status True
    end

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

    # Initialize total insertions and deletions
    set -l total_insertions 0
    set -l total_deletions 0

    # Accumulate changes per file
    set -l changed_files (git diff --name-only HEAD)
    for file in $changed_files
        echo "File: $file"
        # Count the insertions and deletions for the current file
        set -l deletions (git diff HEAD -- $file | grep '^[-]' | grep -vc '^[-][-]')
        set -l insertions (git diff HEAD -- $file | grep '^[+]' | grep -vc '^[+][+]')
        echo -e "\033[32mINSERTIONS: $insertions\033[32m |\033[31m DELETIONS: $deletions \033[0m"
        # Update the total counts
        set total_insertions (math "$total_insertions + $insertions")
        set total_deletions (math "$total_deletions + $deletions")

        # Capture and display the changes, line by line
        git diff HEAD -- $file | awk '/^[+-]/ && !/^(--- a\/|\+\+\+ b\/)/ { print }' | while read -l line
            if test (string sub -l 1 -- $line) = "+"
                # Green color for lines starting with +
                echo -e "\t\033[32m$line\033[0m"
            else if test (string sub -l 1 -- $line) = "-"
                # Red color for lines starting with -
                echo -e "\t\033[31m$line\033[0m"
            end
        end
    end

    # Check how many lines of code there are in the project, excluding virtual environments
    set -l total_lines 0
    set -l without_paths ""
    for dir in ./*/
        if is_venv $dir
            set without_paths "$dir"
        end
    end
    echo "Excluding paths: $without_paths"

    if test $split_status = False
        set total_lines (sz --without $without_paths | grep 'total line count:' | awk '{ print $4 }')
        echo "lines: $total_lines | total insertions: $total_insertions | total deletions: $total_deletions"
    end

    if test "$split_status" = "True"
        sz --without $without_paths --split
    end

end