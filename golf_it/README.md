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
* **Reset:** When pressing "Start Match" the game state in _Golf It!_ changes to **0**. The script detects this and resets the timer.
* **Game Timer:**  The Game Timer stops, as soon as a hole is registered as completed (see _Split_). When entering a new hole, time-left-on-hole (_default 02:00 min_) resets. This results in a **increase** of time-left-on-hole. The script detects this **increase** and resumes the Game Timer.

#### Additional Settings
* _"Pause the game timer when the game is loading"_: This is a relict from a bug fix and there is no real reason to use it. It might get deleted in a future version. For more info see _Game Timer_ above.
* _"Only split on Hole 18"_: work-in-progress as implementation to use the script for "All-maps" category.

