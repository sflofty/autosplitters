//TODO: Proper implementation of Reset, when split_on_map is enabled
//TODO: implement game time removal

state("GolfIt-Win64-Shipping") {
	//this increases, when finishing a Hole (at the moment the stroke-counter goes invisible)
	int hole_counter : "GolfIt-Win64-Shipping.exe", 0x02DCC4E0, 0x90, 0x0, 0x1E8;
	
	//game state: lobby=12, ingame=9, other=0
	int game_state : "GolfIt-Win64-Shipping.exe", 0x02EC2100, 0x68, 0x7A0;
	
	//not ready: 12, ready: 16
	//int ready : "GolfIt-Win64-Shipping.exe", 0x02EA3298, 0x718, 0x30, 0xC0, 0x1E8, 0x530, 0xCE0;
}

startup {	
	settings.Add("split_on_map", false, "All-Maps: Split only every 18 holes");
	settings.Add("1_add_player", false, "Co-Op: Activate for +1 player");
	settings.Add("2_add_players", false, "Co-Op: Activate for +2 players");
}
 
start {

	//this is needed to undo a split, when resetting
	vars.timerModel = new TimerModel { CurrentState = timer };

	if(current.game_state == 9 && old.game_state == 12){
	
		vars.split_every_x = 1;
		if(settings["split_on_map"]) vars.split_every_x = 18;
		
		vars.multiplier = 1;
		if(settings["1_add_player"]) vars.multiplier += 1;
		if(settings["2_add_player"]) vars.multiplier += 2;
		vars.split_every_x = vars.multiplier * vars.split_every_x;
		
		//vars.loading = true;
		vars.holes_completed = 0;
		
		return true;
	}
	return false;
}

isLoading {

	//check the total seconds left in current level
	//if (current.ready == 16 && old.ready != 16) vars.loading = false;
	//return vars.loading;
	
	return false;
}

reset {

	//reset, when exiting to main menu from ingame (game_state = 0)
	if(current.game_state == 0 && old.game_state == 9) {
	
		//Undo the last hole, because the timer splits once, before exiting to main menu
		vars.timerModel.UndoSplit();
		
		if(!settings["split_on_map"]) return true;
	}
}

split {

	//gets triggered, when a hole is finished
	if (current.hole_counter > old.hole_counter) {
	
		//stop game timer
		//vars.loading = true;
		
		//when 18 holes are completed: reset holes_completed and return true 
		vars.holes_completed++;
		if(vars.holes_completed < vars.split_every_x) return false;
		vars.holes_completed = 0;
		
		return true;	
	}
	
}
