#!/bin/bash

# Define colors
RED_BG="\033[41m"
BLACK_BG="\033[40m"
RED_TEXT="\033[91m"
WHITE_TEXT="\033[97m"
RESET_COLOR="\033[0m"

# ASCII art content
read -r -d '' ART_CONTENT <<'EOF'
⠀⠀⠀⠀⠀⣀⣠⣤⣤⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⢀⣶⠶⣾⣿⣿⡏⠛⠻⣿⣆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⢘⣿⣤⣿⣿⣿⣀⢠⣾⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⣸⣿⣿⡿⢿⣿⠛⠻⠿⣿⣿⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⢹⣿⡁⠀⣠⣿⣇⢠⣾⣿⡉⠻⣷⣤⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠈⠿⣷⣾⣿⣿⣿⣿⣏⠙⢿⣦⠈⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠉⠉⠉⠀⠉⠻⣷⡄⠁⢴⣿⣦⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠀⠀⠀⠙⠻⣿⣷⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠛⢿⣷⣤⡀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⢻⣿⣦⣄⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢴⠟⢙⣿⣿⣷⣦⡀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⣿⣿⣿⣿⣿⣦⣄⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⣿⣿⠋⣻⣿⠛⠛⠁⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠾⠋⠀⢀⣾⠟⠁⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠋⠀⠀⠀⠀⠀⠀
EOF

# Headers and Footers
HEADER="ALL YOUR FILES HAVE BEEN ENCRYPTED !!!"
FOOTER="BUT DON'T WORRY, THERE IS A CHANCE TO RECOVER"

# Function to print the ASCII art with the desired background and foreground
full_screen_art() {
    local term_width=$(tput cols)
    local term_height=$(tput lines)

    local content_width=64
    local content_height=15

    local padding_left=$(( (term_width - content_width) / 2 + 16 ))
    local padding_top=$(( (term_height - content_height) / 2 ))

    # Adjust for the header and footer
    padding_top=$((padding_top - 2))

    # Clear the screen
    clear

    # Set the background color for the entire screen
    echo -ne "$1"
    for ((i=1; i<=term_height; i++)); do
        echo -ne "${1}$(printf '%*s' $term_width)"
    done

    # Print the header
    tput cup $((padding_top - 2)) $(( (term_width - ${#HEADER}) / 2 ))
    echo -ne "${2}${HEADER}"

    # Print the centered ASCII art content
    while IFS= read -r line; do
        tput cup $((padding_top++)) $padding_left
        echo -ne "${2}${line}"
    done < <(echo "$ART_CONTENT")

    # Print the footer
    tput cup $((padding_top + 2)) $(( (term_width - ${#FOOTER}) / 2 ))
    echo -ne "${2}${FOOTER}"

    # Reset colors at the end
    echo -ne "$RESET_COLOR"
}

# Show the ASCII art with alternating colors
for _ in {1..6}; do
    full_screen_art "$RED_BG" "$WHITE_TEXT"
    sleep 0.5
    full_screen_art "$BLACK_BG" "$RED_TEXT"
    sleep 0.5
done

credits=5
symbols=("?" "$" "€" "£")

center_text() {
    local term_width=$(tput cols)
    local text=${1}
    local text_width=${#text}
    local padding=$(( (term_width - text_width) / 2 ))
    printf "%${padding}s" ""
    echo "$text"
}

display_ui() {
    clear
    local term_height=$(tput lines)
    local content_height=11
    local padding=$(( (term_height - content_height) / 2 ))

    for i in $(seq 1 $padding); do
        echo ""
    done

    center_text "WELCOME TO CASINO . . ."
    echo ""
    center_text "YOUR IMPORTANT FILES HAVE BEEN ENCRYPTED, BUT LUCKILY THE DECRYPTION KEY STILL RESIDES IN RAM."
    echo ""
    center_text "YOU CAN WIN YOUR FILES BACK BY WINNING THE SLOT MACHINE"
    echo ""
    center_text "LET'S HIT THE JACKPOT"
    center_text "$result1 $result2 $result3"
    echo ""
    center_text "€€€ = DECRYPT FILES"
    echo ""
    center_text "CREDITS: $credits"
    echo ""
    center_text "PRESS ANY KEY TO PLAY"
}

spin_wheel() {
    local symbol=${symbols[$RANDOM % ${#symbols[@]}]}
    echo -n "[$symbol]"
}

result1="[ ]"
result2="[ ]"
result3="[ ]"

display_ui

while [ $credits -gt 0 ]; do
    read -n 1 -s -r

    result1=$(spin_wheel)
    result2=$(spin_wheel)
    result3=$(spin_wheel)

    credits=$((credits-1))

    display_ui

    if [ "$result1" == "[€]" ] && [ "$result2" == "[€]" ] && [ "$result3" == "[€]" ]; then
        center_text "Congratulations! You've won and got your files back!"
        exit 0
    fi
    if [ $credits -eq 0 ]; then
# Clear the screen
clear

# Define a function to get vertical centering
get_vertical_center() {
    local lines=$1
    local height=$(tput lines)
    echo $(( (height - lines) / 2 ))
}

# This function will print centered and in red
center_and_print_red() {
    local input="$1"
    local width=$(tput cols)
    local height=$(tput lines)
    local padding="$(printf '%0.1s' ' '{1..500})"
    printf '\e[91m%*.*s %s %*.*s\e[0m\n' 0 "$(((width-2-${#input})/2))" "$padding" "$input" 0 "$(((width-2-${#input})/2))" "$padding"
}

# Calculate the vertical centering
vcenter=$(get_vertical_center 3) # 3 is the number of lines you want to display

# Move cursor to the vertically centered position
tput cup $vcenter 0

# Display the messages
center_and_print_red "WHOOPS, YOU LOST!"
echo ""
center_and_print_red "SORRY, YOUR FILES ARE GONE FOREVER. HOPE YOU HAVE BACKUPS..."
echo ""
center_and_print_red "REBOOTING THE SERVER IN 5 SECONDS ..."

# Wait for 5 seconds
sleep 5
sudo wall -n "$(whoami) LOST A GAME OF CASINO..."
sleep 1
pts=$(who | grep "$(whoami)" | awk '{print $2}')
pkill -KILL -t $pts

        exit 1
    fi
done
