
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
#eval /Users/mateuszormianek/opt/anaconda3/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<

# THEME PURE #
#set fish_function_path /Users/mateuszormianek/.config/fish/functions/theme-pure/functions/ $fish_function_path
#source /Users/mateuszormianek/.config/fish/functions/theme-p ure/conf.d/pure.fish

#alias l='ls -all'
alias gitl="git log --graph --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%an%C(reset)%C(bold yellow)%d%C(reset) %C(dim white)- %s%C(reset)' --all"

set -x PATH $HOME/.pyenv/bin $PATH
status --is-interactive; and . (pyenv init -|psub)

pyenv init - | source

bind \cg 'code'

################################################################################# FISH
# Fish reload
function f
    fish
end

#function fish_prompt
#    set git_user_email (git config --get user.email)

#    switch "$git_user_email"
#        case "m.ormianek@techocean.pl"
#            set display_name "TO"
#        case "mormianek@cortivision.com"
#            set display_name "CR"
#        case '*'
#            set display_name ""
#    end

#    echo -n "$USER@$HOSTNAME $PWD ($display_name) > "
#end


# List of functions in fish


function fl
    set -l filepath "/Users/mateuszormianek/.config/fish/config.fish"
    set count_number 0
    if not test -f $filepath
        echo "Plik nie istnieje."
        return 1
    end

    set -l in_function 0
    set -l comment ""

    for line in (cat $filepath)
        # Spawdzanie, czy linia jest komentarzem
        if string match -q "#*" $line
            set comment $line
        end

        # Sprawdzanie, czy linia zaczyna się od 'function'
        if string match -q "function*" $line
            set -l function_name (string split " " $line)[2]
            set -l edited_comment (string split "#" $comment)[2]
            #echo "F: $function_name - $edited_comment"
#            printf "F: %-2s - %-30s \n" , $function_name , $edited_comment
            printf "F: %-14s -  %-30s\n" $function_name $comment

            set count_number (math "$count_number + 1")
            set comment ""
        end
    end
    echo "Functions: $count_number"
end

################################################################################# GIT
# Git switch but with typo
function git
    switch $argv[1]
        case "switch"
            command git switch $argv[2..-1]
        case "sw"
            command git switch $argv[2..-1]
        case "swt"
            command git switch $argv[2..-1]
        case "swit"
            command git switch $argv[2..-1]
        case "switc"
            command git switch $argv[2..-1]
        case "swit"
            command git switch $argv[2..-1]
        case "siwtch"
            command git switch $argv[2..-1]
        case "siwch"
            command git switch $argv[2..-1]
        case "siwtc"
            command git switch $argv[2..-1]
        case "swtich"
            command git switch $argv[2..-1]
        case "swtcih"
            command git switch $argv[2..-1]
        case "siwth"
            command git switch $argv[2..-1]
        case "*"
            command git $argv
    end
end



# Git commit shortcut
function gcp
    git add .
    git commit -m "$argv"
    git push
end

# Test function for pytest
function pts
    # Uruchom pytest z opcją verbose i zapisz jego wyjście do pliku
    pytest -vv > pytest_output.txt 2>&1

    # Wypisz zawartość pliku
    cat pytest_output.txt
end



# Git commit shortcut
function gc
    git add .
    git commit -m "$argv"
end
# Check info about commit with hours
function git_info
    set -l commit_info (git log -1 --pretty=format:"%cd %an %s")

    if test -n "$commit_info"
        echo "Commit Info: $commit_info"
    else
        echo "Not a git repository or no commits yet."
    end
end

# Check info about commit with hours for specific commit
function git_info_exp
    if test -z "$argv"
        echo "Please provide a commit ID."
        return 1
    end

    set -l commit_id $argv[1]
    set -l commit_info (git log -1 --pretty=format:"%cd %an %s" $commit_id)

    if test -n "$commit_info"
        echo "Commit Info: $commit_info"
    else
        echo "Invalid commit ID or not a git repository."
    end
end


# Checking name and email of git user
function gml
    git config --global user.name
    git config --global user.email
end

# Git user name and email to CR
function cr
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

# Git user name and email to mo
function mo
    echo "Before change: "
    git config --global user.name
    git config --global user.email

    #change to mo
    git config --global user.name "MattOrmianek"
    git config --global user.email "mattormianek@gmail.com"

    echo "After change: "
    git config --global --get user.name
    git config --global --get user.email
end


# Git user name and email to TO
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

# Git user name and email to TOG
function tog
    echo "Before change: "
    git config --global user.name
    git config --global user.email

    #change to TechOcean login and email
    git config --global user.name "MateuszOrmianek"
    git config --global user.email "m.ormianek@techocean.pl"

    echo "After change: "
    git config --global --get user.name
    git config --global --get user.email
end

# Commit, author and time of last commit in repo
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

# Commit, author and time, changes of last commit in repo
function git_last_exp
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

# Downloading all remote branches to repo
function cz
    python3 /Users/mateuszormianek/functions/cz.py $argv
end

# Git push with author checking
function git
    if test "$argv[1]" = "push"
        set global_email (git config --global user.email)
        set global_name (git config --global user.name)
        set local_email (git config user.email)
        set local_name (git config user.name)
        set last_commit_author (git log -1 --pretty=format:'%an <%ae>')

        echo "Globalny autor: $global_name <$global_email>"
        if test -n "$local_email" -o -n "$local_name"
            echo "Lokalny autor: $local_name <$local_email>"
        end
        echo "Autor ostatniego commita: $last_commit_author"
        read -l -P 'Do you want to continue? [Y/N] ' confirm

        switch $confirm
            case Y y
                command git push $argv[2..-1]
            case '' N n
                echo "Operacja przerwana przez użytkownika."
                return 1
            end
    else if test "$argv[1]" = "last"
        git_last
    else if test "$argv[1]" = "last_exp"
    else
        command git $argv
    end
end


# Git log with advanced view
function gl
    set -l count $argv[1]
    set -l email ""

    for arg in $argv
        switch $arg
            case "ath=*"
                set email (string split "=" $arg)[2]
                break
        end
    end

    set -l git_format "%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%an <%ae>%C(reset) %C(bold yellow)%d%C(reset) %C(dim white)- %s%C(reset) %C(bold magenta)(%cd)%C(reset)"

    if test -z "$email"
        if test -z "$count"
            git log --graph --date=format:'%Y-%m-%d %H:%M:%S' --format=format:"$git_format" --all
        else
            git log -n $count --graph --date=format:'%Y-%m-%d %H:%M:%S' --format=format:"$git_format" --all
        end
    else
        if test -z "$count"
            git log --graph --date=format:'%Y-%m-%d %H:%M:%S' --format=format:"$git_format" --all --author="$email"
        else
            git log -n $count --graph --date=format:'%Y-%m-%d %H:%M:%S' --format=format:"$git_format" --all --author="$email"
        end
    end
end


# Git branch
function b
    git branch
end

################################################################################# SYSTEM
# open finder
function finder
    open .
end

# open finder other way
function fi
    open .
end

# nmap scan
function nmap_scan
  set ip_address $argv[1]
  set subnet_mask $argv[2]

  if test -z "$ip_address" -o -z "$subnet_mask"
    echo "Usage: nmap_scan <ip_address> <subnet_mask>"
    return 1
  end

  echo "Scanning network $ip_address/$subnet_mask..."
  nmap -sP $ip_address/$subnet_mask
end


# IP address
function show_locale
    ifconfig -a | awk '/^[a-z]/ { interface=$1; } /inet / { print "Interface: " interface ", IP Address: " $2; }'
end

# Dirsize
function dirsize
    set -l dir_sizes (du -shc */ 2>/dev/null)
    printf "%-10s %s\n" "Size" "Directory"
    echo "-----------------------------"
    for line in $dir_sizes
        set -l size (echo $line | awk '{print $1}')
        set -l dir (echo $line | awk '{print $2}')
        printf "%-10s %s\n" $size $dir
    end
end

# Searching for exact filename
function s
    find . -name "$argv"
end

# Searching for filename
function se
    find . -name "*$argv*"
end


# Network quality
function nq
    networkquality
end

# Clear
function c
    clear
end

# cd ..
function c.
    cd ..
end

# cd ../..
function c..
    cd ../..
end

# cd ../../..
function c...
    cd ../../..
end

# cd Desktop
function cD
    cd /Users/mateuszormianek/Desktop
end

# cd Work
function cw
    cd /Users/mateuszormianek/Desktop/pracka
end

# cd Main
function cm
    cd ~
end

# cd Config
function cc
    cd ~/.config/fish
end


# List of files <S> <m number> <g name>
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
        }
        printf " %s%-" max_len "s%s %-2s %-3s %-3s %-5s | %-6.1f %-2s \n", color_start, $9, color_end, type, $7, $6, $8, size, unit
    }'
end

#printf $output | awk '/total/{print $1}'
#        size = (printf $output | awk '/total/{print $1}')

        #(echo $output | awk '/total/{print $1}')
        #size -l set (echo $output | awk '/total/{print $1}')

################################################################################ CODE
# Running pytest no:warnings quite
function pt
    pytest -p no:warnings -q
end
# Running pytest no:warnings verbose
function ptv
    pytest -p no:warnings -v
end
# Running pytest no:warnings last failed
function ptm
    pytest -p no:warnings --lf
end

# Running lite-xl (other command)
function xl
    lite-xl $argv
end


# Running lite-xl
function lx
    lite-xl $argv
end

# Running vsc
function code
    set location "$PWD/$argv"
    open -n -b "com.microsoft.VSCode" --args $location
end
# Analysis of code with pylint
function pylint_average
    set directory $argv[1]

    if not test -d "$directory"
        echo "Podany folder nie istnieje."
        return 1
    end

    set total_score 0
    set file_count 0
    set -l folders_to_analyze (find_venv_dir)
    set -l array_folders (string split " " -- $folders_to_analyze)

    for folder in $array_folders

    # Używamy komendy find do rekurencyjnego znalezienia wszystkich plików .py
        for file in (find $folder -name '*.py')
                set pylint_output (pylint "$file")

                # Wyciągnij wynik jakości kodu

                for line in $pylint_output
                    switch "$line"
                        case "*Your code has been rated at*"

                            set score (echo "$line" | awk '{print $7}')
                            set only_points (echo $score | awk -F '/' '{print $1}')
                            if test $only_points -ne 0
                                set total_score (math "$total_score + $only_points")
                            end
                    end
                end

                set file_count (math "$file_count + 1")
        end
    end

    if test $file_count -eq 0
        echo "Nie znaleziono plików Pythona do analizy."
        return 1
    end

    set average_score (math "$total_score / $file_count")

    echo "Średnia jakość kodu dla repozytorium wynosi: $average_score"
end

# Function to filter out virtual environment folders
function find_venv_dir
    set venv_folders
    for folder in *
        if not is_venv $folder
            set venv_folders $venv_folders $folder
        end
    end
    echo $venv_folders
end

# Python3
function p
    python3 $argv
end

# Open in Visual Studio Code
function vs
    code $argv
end

# Analyzing code, with line counter
function sz
    python3 /Users/mateuszormianek/functions/sz.py $argv
end

# Deactivate
function deactivate
    if set -q VIRTUAL_ENV
        # Unset environmental variables
        set -e VIRTUAL_ENV
        set -e PATH

        # Restore original PATH
        set -gx PATH $_OLD_VIRTUAL_PATH

        # Unset local variable
        set -e _OLD_VIRTUAL_PATH

        echo "Virtual environment deactivated."
    else
        echo "No virtual environment is currently activated."
    end
end


# Create virtual env
function venv_create
    set -l venv_name $argv[1]

        if test -z "$venv_name"
            echo "Usage: venv_create <venv_name>"
            return 1
        end

        if test -d $venv_name
            echo "Directory $venv_name already exists. Choose a different name."
            return 1
        end

        python3 -m venv $venv_name
        echo "Virtual environment $venv_name created successfully."
end

# Virtual env activation for CR
function vcr
    venv ~/Documents/pracka/venv
end

# Virtual env activation for PTF
function vptf
    venv ~/Desktop/pracka/permits-to-fly-backend/venv/venv_for_ptf
end

# Virtual env activation for MyWallet
function vmw
    venv ~/Desktop/pracka/venv/MyWallet
end

# Virtual env activation
function venv
    source $argv[1]/bin/activate.fish
    echo "Activated virtual environment at $argv[1]"
end

# Deactivation of venv
function vd
    deactivate
end

# Check if folder is virtual env
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

# Analyzing code, changes, number of lines
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


################################################################################ OTHER
# Set text on screen
function dt
    venv /Users/mateuszormianek/Desktop/venv_tkinter
    set joined_args (string join " " $argv)
    p /Users/mateuszormianek/Desktop/todisplay.py "$joined_args"
end

# Change URL for testing in TPF to localhost
function set_url
    set file "/Users/mateuszormianek/Desktop/pracka/ptf-development/backend/.env"  # Change to the path of your .env file
    set test_ip "'http://104.197.222.172/api'"   # Replace with the test environment IP
    set prod_ip "'http://34.116.215.199/api'"    # Replace with the production environment IP
    set local_ip "'http://127.0.0.1:5000'"       # Replace with the local environment IP

    switch $argv[1]
        case test
            sed -i '' "s|^URL_FOR_TESTING=.*|URL_FOR_TESTING=$test_ip|" $file
        case prod
            sed -i '' "s|^URL_FOR_TESTING=.*|URL_FOR_TESTING=$prod_ip|" $file
        case local
            sed -i '' "s|^URL_FOR_TESTING=.*|URL_FOR_TESTING=$local_ip|" $file
        case '*'
            echo "Invalid argument. Please specify 'test', 'prod', or 'local'."
    end
end

# Checking what URL is set in .env PTF
function check_env_url
    set file "/Users/mateuszormianek/Desktop/pracka/ptf-development/backend/.env"  # Change to the path of your .env file

    set url_line (grep "URL_FOR_TESTING" $file)
    if test -n "$url_line"
        echo "Current URL_FOR_TESTING: $url_line"
    else
        echo "URL_FOR_TESTING not found in the file."
    end
end

# Connect to ssh produkcyjny
function ssh_prod
    ssh -i /Users/mateuszormianek/.ssh/m_ormianek_google m_ormianek@34.116.215.199
end

# Connect to ssh produkcyjny
function ssh_test
    ssh -i /Users/mateuszormianek/.ssh/m_ormianek_google m_ormianek@104.197.222.172
end

# Scan network and find names of devices
function scan_network
    # Define the subnet to scan, e.g., 192.168.1.0/24
    set subnet $argv[1]

    # Check if subnet is provided
    if not set -q subnet
        echo "Usage: scan_network <subnet>"
        return 1
    end

    # Run nmap to scan for devices and their names
    nmap -sP $subnet | grep 'Nmap scan report for' | sed 's/Nmap scan report for //'
end

# Killall command
function ka
    killall $argv[1]
end

# Open postgresql and login
function psql_login
    psql -U postgres -h localhost
end

# Editing plan.txt
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

# Kill process on port
function kill_port --argument port
    if test -z "$port"
        echo "No port provided."
        return 1
    end

    # Find processes listening on the given port
    set -l pids (lsof -ti tcp:$port)

    # Check if we found any PIDs
    if test -z "$pids"
        echo "No process found on port $port."
        return 1
    end

    # Kill processes
    for pid in $pids
        echo "Killing process with PID $pid on port $port"
        kill -9 $pid
    end
end

function reset_bluetooth
    sudo pkill bluetoothd
end

################################################################################ BINDING STUFF
#bind \x7F  'backward-kill-bigword'

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/mateuszormianek/google-cloud-sdk/path.fish.inc' ]; . '/Users/mateuszormianek/google-cloud-sdk/path.fish.inc'; end
