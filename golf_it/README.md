# Golf It! Autosplitter

This is an AutoSplitter Script for [LiveSplit](https://github.com/LiveSplit/LiveSplit). 

**Note this project is still work in progress, so be ready to undo a split with a Hotkey (in Settings) in Livesplit.**

The script...
 ... starts, when you press "Start Match".
 ... splits, everytime you finish a Hole.
 ... records game time. The game time is the defined by the time you see the stroke count in the bottom right corner. It stops after it splits for a hole and resumes once the new level is loaded. It stops when selecting a new map for "All-Maps", aswell.
 ... resets, when you enter main menu. (you can disable this in the layout settings for the Scriptable AutoSplitter)

## All Maps
IMPORTANT: If you have auto-reset enabled, exiting to the main menu resets the run. Either disable auto-reset or never leave to main menu, when doing a "All-maps" run. Improving this behaviour is noted as TODO.

When split-on-map is enabled, the scripts splits, when a hole with the number 18 is finished, therefore this only works on maps with 18 holes.

## Installing
 1. Download the current verion of the script [`golf_it.asl`](https://github.com/sflofty/autosplitters/releases)
 2. Open LiveSplit > Edit Layout 
 3. Add Control > Scriptable AutoSplitter
 4. Browse for `golf_it.asl`
