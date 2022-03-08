state("GolfIt-Win64-Shipping") {
	//menu: 0, start: 1, loading_finished:2, hole_finished:3, map_finished: 4
	//version 0.8.2.1 : "GolfIt-Win64-Shipping.exe", 0x0557BEB8, 0x58, 0xDF8;
	int game_state : "GolfIt-Win64-Shipping.exe", 0x0557BEB8, 0x58, 0xE18;
}

startup {	
	settings.Add("split_on_map", false, "Split only on when finishing a map");
}
 
start {
	if(current.game_state == 1 && old.game_state != 1){
		vars.loading = true;
		return true;
	}
	return false;
}

isLoading {
	if (current.game_state == 2 && old.game_state != 2) vars.loading = false;
	return vars.loading;
}

reset {

	//reset, when exiting to main menu or lobby (game_state = 0)
	if(current.game_state == 0 && old.game_state != 0){
		
		//disable reset when running all-maps
		if(!settings["split_on_map"]) return true;
	}
	
	return false;
}

split {

	if (current.game_state != old.game_state) {
		print("LS: " + old.game_state + " --> " + current.game_state);
	}

	//hole finished (state 3 or 4)
	if (current.game_state >= 3 && old.game_state == 2) {
	
		vars.loading = true;
		
		//split on hole (setting deactivated) or on map (state = 4)
		if(!settings["split_on_map"]) {
			return true;
		}else if(current.game_state == 4) {
			return true;
		}
	}

	return false;
}
