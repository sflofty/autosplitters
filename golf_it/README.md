# Golf It! Autosplitter

This is an AutoSplitter script for [LiveSplit](https://github.com/LiveSplit/LiveSplit). 

## Installing
 1. Open LiveSplit > *right click* > `Edit Splits`
 2. Set the Game to `Golf It!`
 3. Press `Activate`
 4. Press `Settings` to customize automation for start, splitting, reset and all maps

## How the script works

* **Start:** When pressing "Start Match" the game state in _Golf It!_ changes to **9**. The script detects this and starts the timer.
* **Split:** Everytime you finish a hole, a certain variable in _Golf It!_ increases. The script detects this and splits the timer. 
* **Reset:** When entering the main menu the game state in _Golf It!_ changes to **0**. The script detects this and resets the timer. Be careful when doing a 100% to not press "Exit" after completing a map. You might want to disable this option when doing a 100% run.
* **Game Timer:**  The Game Timer stops, as soon as a hole is registered as completed (see _Split_). When entering a new hole, the in-game timer in the top right corner resets (_default 02:00 min_). This reset can be detected as an **increase** and the script resumes the Game Timer.

#### Additional Settings
* _"Split only every 18 holes"_: With this activated, the script only splits every 18 holes. This is for when you only want to split on map completion in a 100% run.
