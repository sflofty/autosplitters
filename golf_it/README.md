# Golf It! Autosplitter

This is an AutoSplitter Script for [LiveSplit](https://github.com/LiveSplit/LiveSplit). 

**The script:**
* starts, when you press "Start Match"
* splits, everytime you finish a Hole
* records game time. The game time is the defined by the time you see the stroke count in the bottom right corner. It stops after it splits for a hole and resumes once the new level is loaded. It also stops when selecting a new map for "All-Maps"
* resets, when you enter main menu. (you can disable this in the layout settings for the Scriptable AutoSplitter)

## All Maps
IMPORTANT: If you have auto-reset enabled, exiting to the main menu resets the run. Either disable auto-reset or never leave to main menu, when doing a "All-maps" run. Improving this behaviour is noted as TODO.

When split-on-map is enabled, the scripts splits, when a hole with the number 18 is finished, therefore this only works on maps where the number of the last hole is 18.

## Installing
 1. Open LiveSplit > right click > `Edit Splits`
 2. Set the Game to `Golf It!`
 3. Press `Activate`
 4. Press `Settings` to customize automation for start, splitting, reset and all maps
