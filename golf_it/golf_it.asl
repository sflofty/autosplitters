//TODO: Proper implementation of Reset, when split_on_map is enabled

state("GolfIt-Win64-Shipping") {
	//this increases, when finishing a Hole (at the moment the stroke-counter goes invisible)
	int hole_tracker : "GolfIt-Win64-Shipping.exe", 0x02FA5508, 0x1D0, 0x0, 0x1E8;
	
	//game state: lobby=11, ingame=9, other=0
	int game_state : "GolfIt-Win64-Shipping.exe", 0x02F4F500, 0x68, 0x710;
	
	//seconds left from timer
	int seconds : "GolfIt-Win64-Shipping.exe", 0x02F51C60, 0xF8, 0x3E0, 0x230;
	
	//minutes left from timer
	int minutes : "GolfIt-Win64-Shipping.exe", 0x02F51C60, 0xF8, 0x3E0, 0x22C;
}

startup {	
	settings.Add("split_on_map", false, "Split only every 18 holes (useful for 100% category)");
}
 
start {

	vars.loading = true;
	if(settings["split_on_map"]) vars.holes_completed = 0;
	
	return current.game_state == 9 && old.game_state == 11;
}

isLoading {

	//check the total seconds left in current level
	if (vars.loading && 60 * current.minutes + current.seconds > 60 * old.minutes + old.seconds) vars.loading = false;
	
	return vars.loading;
}

reset {

	//reset, when exiting to main menu from ingame (game_state = 0)
	if(current.game_state == 0 && old.game_state == 9) return true;
}

split {

	//gets triggered, when a hole is finished
	if (current.hole_tracker > old.hole_tracker) {
	
		//stop game timer
		vars.loading = true;
		
		if(settings["split_on_map"]) {
			
			//count finished holes
			vars.holes_completed++;
			
			//when 18 holes are completed: reset holes_completed and return true 
			if(vars.holes_completed < 18) return false;
			vars.holes_completed = 0;
		}
		
		return true;	
	}
}
