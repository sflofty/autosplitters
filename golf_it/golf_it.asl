state("GolfIt-Win64-Shipping") {
	//menu: 0, start: 1, loading_finished:2, hole_finished:3, map_finished: 4
	int game_state : "GolfIt-Win64-Shipping.exe", 0x04C4FB50, 0xDE8, 0xC0, 0x158, 0xD18;
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
	//reset, when exiting to main menu from ingame (game_state = 0)
	if(current.game_state == 0 && old.game_state != 0) {
		//disable reset, when running all-maps, because runners might enter main menu, when selecting a new map
		if(!settings["split_on_map"]) return true;
	}
	return false;
}

split {
	//gets triggered, when a hole or map is finished (state 3 and 4)
	if (current.game_state >= 3 && old.game_state < 3) {
	
		//
		if(!settings["split_on_map"]) {
			vars.loading = true;
			return true;
		} else {
			if (current.game_state == 4) {
				vars.loading = true;
				return true;
			}
		}
	}
	
	return false;
}
