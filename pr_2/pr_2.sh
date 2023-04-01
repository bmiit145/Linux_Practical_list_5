#!/bin/bash

# Validate command line arguments
if [ $# -ne 2 ]; then
  echo "Usage: $0 game_type cricketer_name"
  exit 1
fi

# Assign command line arguments to variables
game_type="$1"
cricketer_name="$2"

# game ID for  game type
game_id=$(awk -v game_type="$game_type" '$2 == game_type {print $1}' GAME.txt)

# Check if game ID is found
if [ -z "$game_id" ]; then
  echo "Game Record not found"
  exit
fi

#  cricketer for thegame ID and cricketer name with Case Ignores
cricketer_data=$(awk -v game_id="$game_id" -v cricketer_name="$cricketer_name" 'tolower($3) == tolower(game_id) && tolower($2) == tolower(cricketer_name) {print $4,$5,$6}' CRICKETER.txt)

# Check if cricketer data is found
if [ -z "$cricketer_data" ]; then   # z for chacking result
  echo "Cricketer Record not found"
  exit
fi 

# Calculate total score, runs from 4s, and runs from 6s
total_runs=0
runs_from_4s=0
runs_from_6s=0


# work like Foreach loop
while read -r score fours sixes; do
  total_runs=$((total_runs + score))
  runs_from_4s=$((runs_from_4s + fours))
  runs_from_6s=$((runs_from_6s + sixes))
done <<< "$cricketer_data"

# Print report
echo "======================================"
echo "Cricketer Name: $cricketer_name"
echo "Game type: $game_type"
echo "Total Runs: $total_runs"
echo "Runs from 4s: $runs_from_4s"
echo "Runs from 6s: $runs_from_6s"
echo "======================================"



# run as bash pr_2.sh cricket virat