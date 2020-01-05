//TODO: don't reset, when exiting to main menu after finishing a map

state("GolfIt-Win64-Shipping") {
	//this increases by one, when the stroke-counter goes away
	int hole_finished_counter : "GolfIt-Win64-Shipping.exe", 0x02FA5508, 0x1D0, 0x0, 0x1E8;
	
	//this somewhat resembles wheather the stroke count in the bottom right is visible
	//2:main menu/not visible, 3:selecting server, 4:visible, 6/11:selecting map, 
	int strokes_visible : "GolfIt-Win64-Shipping.exe", 0x02F4F500, 0x98, 0x6E8, 0x10, 0xD28;
	
	//game state: lobby=11, ingame=9, other=0
	int game_state : "GolfIt-Win64-Shipping.exe", 0x02F4F500, 0x68, 0x710;
	
	//results the current hole. it changes in the middle of loading the next level
	int current_hole : "GolfIt-Win64-Shipping.exe", 0x02F38260, 0x30, 0x78, 0x320, 0x3F8;
}

startup {	
	//splits when the 18th hole of a map is finished
	settings.Add("split_on_map", false, "Split only when a map is finished (Only works on maps where the number of the last Hole is 18)");
}
 
start {
	vars.loading = true;
	vars.last_hole = 0;
	return current.game_state == 9 && old.game_state == 11;
}

update {
	//save the hole number, that was finished
	if(current.current_hole != old.current_hole){
		vars.last_hole = old.current_hole;
	}
}

isLoading {
	
	//4 = stroke_count is visible
	if (current.strokes_visible == 4) {
		
		//only resume game timer, when on a Hole with number between 0 and 18
		if(current.current_hole >= 0 && current.current_hole <= 18) vars.loading = false;

	}
	
	//if the number of the larger hole is bigger than the current hole, the game time is not running
	if(vars.last_hole >= current.current_hole) vars.loading = true;
	
	return vars.loading;
}

reset {
	//game_state:0 = main menu
	if(current.game_state == 0 && old.game_state == 9) {
		
		//after a map is finished current_hole is set to 19. after that it gets set back to 18 and vars.last_hole is set to 19
		//if(vars.last_hole == 19) return false;
		//if(vars.last_hole == 18 && (current.current_hole < 0 || current.current_hole > 18)) return false;
		
		return true;
	}
}

split {
	//check for split if currently not loading and a hole is finished
	if (!vars.loading && current.hole_finished_counter > old.hole_finished_counter) {
	
		//loading starts as soon as a hole is finished
		vars.loading = true;
		
		//check if split only after the game and return false, if it was not the 18th hole of the map
		if(settings["split_on_map"] && current.current_hole != 18) return false;
		
		//if it was the 18th hole or split_on_map is off, it always returns true
		return true;
	}
}
