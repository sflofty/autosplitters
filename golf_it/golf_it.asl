//TODO: Proper implementation of Reset, when split_on_map is enabled

state("GolfIt-Win64-Shipping") {
	//this increases, when finishing a Hole (at the moment the stroke-counter goes invisible)
	int hole_tracker : "GolfIt-Win64-Shipping.exe", 0x02F140C0, 0x1D0, 0x0, 0x1E8;
	
	//game state: lobby=11, ingame=9, other=0
	int game_state : "GolfIt-Win64-Shipping.exe", 0x02EC0910, 0xE10, 0x7A0;
	
	//seconds left from timer
	int seconds : "GolfIt-Win64-Shipping.exe", 0x02C98998, 0x28, 0x40, 0x60, 0x1A8, 0x60, 0x6D4;
	
	//minutes left from timer
	int minutes : "GolfIt-Win64-Shipping.exe", 0x02C98998, 0xC8, 0xC0, 0x40, 0x1A8, 0x1810;
}

startup {	
	settings.Add("split_on_map", false, "All-Maps: Split only every 18 holes");
	settings.Add("1_add_player", false, "Co-Op: Activate for +1 player");
	settings.Add("2_add_players", false, "Co-Op: Activate for +2 players");
}
 
start {
	if(current.game_state == 9 && old.game_state == 11){
	
		vars.split_every_x = 1;
		if(settings["split_on_map"]) vars.split_every_x = 18;
		
		vars.multiplier = 1;
		if(settings["1_add_player"]) vars.multiplier += 1;
		if(settings["2_add_player"]) vars.multiplier += 2;
		vars.split_every_x = vars.multiplier * vars.split_every_x;
		
		vars.loading = true;
		vars.holes_completed = 0;
		
		return true;
	}
	return false;
}

isLoading {

	//check the total seconds left in current level
	if (vars.loading && 60 * current.minutes + current.seconds > 60 * old.minutes + old.seconds) vars.loading = false;
	
	return vars.loading;
}

reset {

	//reset, when exiting to main menu from ingame (game_state = 0)
	if(current.game_state == 0 && old.game_state == 9) {
		if(!settings["split_on_map"]) return true;
	}
}

split {

	//gets triggered, when a hole is finished
	if (current.hole_tracker > old.hole_tracker) {
	
		//stop game timer
		vars.loading = true;
		
		//count finished holes
		vars.holes_completed++;

		//when 18 holes are completed: reset holes_completed and return true 
		if(vars.holes_completed < vars.split_every_x) return false;
		vars.holes_completed = 0;
		
		return true;	
	}
}
