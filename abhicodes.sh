#!/bin/bash

# Check if folder name is provided
if [ -z "$1" ]; then
    echo "Please provide the folder name."
    exit 1
fi

folder_name="$1"
folder_path="Desktop/Local Repos/$folder_name"

# Open GitHub Desktop in fullscreen
open -a "GitHub Desktop" --args --fullscreen
sleep 2

# Open the folder in VSCode, wait a bit for it to load, and then make it full screen
code "$folder_path"
sleep 5

# Determine if it's a React or Next.js project
if grep -q '"next"' "$folder_path/package.json"; then
    run_command="npm run dev"
elif grep -q '"react-scripts"' "$folder_path/package.json"; then
    run_command="npm start"
else
    run_command="npm run dev"  # Default command
fi

# AppleScript to make VSCode fullscreen and open terminal
osascript -e "
tell application \"Visual Studio Code\"
    activate
    delay 2
    tell application \"System Events\"
        keystroke \"f\" using {command down, control down}
        delay 2
        keystroke \"\`\" using {control down, shift down}
        delay 2
        keystroke \"$run_command\"
        keystroke return
    end tell
end tell
"
sleep 5

# AppleScript to open two windows in Brave Browser with specified URLs in full screen
osascript -e '
tell application "Brave Browser"
    activate
    delay 3
    tell front window
        make new tab with properties {URL:"https://chat.openai.com"}
        delay 1
        close (get tab 1)
    end tell
    delay 2
    tell application "System Events" to keystroke "f" using {command down, control down}
    delay 5
    make new window
    delay 1
    tell front window
        make new tab with properties {URL:"http://localhost:3000"}
        delay 1
        close (get tab 1)
    end tell
end tell
'
