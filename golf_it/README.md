# Golf It! Autosplitter

This is an AutoSplitter script for [LiveSplit](https://github.com/LiveSplit/LiveSplit). 

## Installing
 1. Open LiveSplit > *right click* > `Edit Splits`
 2. Set the Game to `Golf It!`
 3. Press `Activate`
 4. Press `Settings` to customize automation for start, splitting, reset and all maps

## How the script works

* **Start:** When pressing "Start Match" `game_state` changes to **1**. The script detects this and starts the timer.
* **Split:** Everytime you finish a hole `game_state` changes to **3**. The script detects this, splits the timer and stops the _ingame_ timer. 
* **Game Timer:** When every player is finished loading the hole `game_state` changes to **2**. The script detects this restarts the _ingame_ timer. 
* **Reset:** When entering the main menu `game_state` changes to **0**. The script detects this and resets the timer. Resetting is deactivated, while the setting `"Split only every 18 holes"` is activated. This is to prevent accidental resets, while doing a all-maps run. 

#### Additional Settings
* _"Split only every 18 holes"_: With this activated, the script only splits when a map is finished. This is for when you only want to split on map completion in a 100% run.
