state("GolfIt-Win64-Shipping") {
	//menu: 0, start: 1, loading_finished:2, hole_finished:3, map_finished: 4
	int game_state : "GolfIt-Win64-Shipping.exe", 0x04C37558, 0x58, 0xD18;
	
	//alternative addresses: 
	//0x2EC8F90, 0xF8, 0x90, 0xE10, 0x30, 0x240, 0xC50;
	//0x02EC4860, 0x140, 0xC50;
	//0x02EC2110, 0xE10, 0xC50;
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
