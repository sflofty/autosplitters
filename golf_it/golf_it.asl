//TODO: For All-Maps: After finishing a Map, pressing EXIT will split the timer.
//TODO: Game Timer does not work.
//TODO: Change Map Splitter to split when a map is finished, not when 18 Holes are finished.

state("GolfIt-Win64-Shipping") {
	//this increases by one, when the stroke-counter goes away
	int hole_finished_counter : "GolfIt-Win64-Shipping.exe", 0x2FA54E8, 0x1A0, 0x220, 0x130, 0x0, 0x1E8;
	
	//SOMETIMES DOESN'T WORK
	//when a load finishes, this increases, but might change at other times (not 100% sure)
	//int load_counter : "GolfIt-Win64-Shipping.exe", 0x02FA6878, 0x20, 0x20, 0x130, 0x0, 0x410;
		
	//game state: lobby=11, ingame=9, other=0
	int game_state : "GolfIt-Win64-Shipping.exe", 0x02D220B0, 0x0, 0x4A8, 0x50, 0x68, 0x710;
}

startup {	
	//actually splits after 18 Holes
	settings.Add("split_on_map", false, "Split only when a map is finished");
	
	//settings.Add("split_on_holes", true, "Split when a hole is finished");
	
	vars.holes_finished = 0;
}
 
start {
	vars.loading = true;
	return current.game_state == 9 && old.game_state == 11;
}

// GAME TIMER DEACTIVATED, BECAUSE IT IS STILL BUGGY
//isLoading {
//	if (current.load_counter > old.load_counter) {
//		vars.loading = false;
//	}
//	return vars.loading;
//}

reset {
	if(current.game_state == 0 && old.game_state == 9) {
		return true;
	}
}

split {
	//check for split if hole finishes and currently ingame
	if (current.hole_finished_counter > old.hole_finished_counter) {
		if (current.game_state == 9) {
			vars.loading = true;
		
			//check if split after every hole or after 18 holes
			if(settings["split_on_map"]) {
				vars.holes_finished++;
				if(vars.holes_finished >= 18) {
					vars.holes_finished = 0;
					return true;
				}else {
					return false;
				}
			}else {
				return true;
			}			
		}
	}
}
