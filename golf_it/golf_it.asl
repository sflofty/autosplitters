//TODO: implement logik for All-Maps category

state("GolfIt-Win64-Shipping") {
	//this increases by one, when the stroke-counter goes away
	int hole_finished_counter : "GolfIt-Win64-Shipping.exe", 0x02FA5508, 0x1D0, 0x0, 0x1E8;
	
	//game state: lobby=11, ingame=9, other=0
	int game_state : "GolfIt-Win64-Shipping.exe", 0x02F4F500, 0x68, 0x710;
	
	//seconds left from timer
	int seconds : "GolfIt-Win64-Shipping.exe", 0x02F51C60, 0xF8, 0x3E0, 0x230;
	
	//minutes left from timer
	int minutes : "GolfIt-Win64-Shipping.exe", 0x02F51C60, 0xF8, 0x3E0, 0x22C;
}

startup {	
	settings.Add("pause_when_loading", true, "Pause the game timer when the game is loading");
}
 
start {
	if(settings["pause_when_loading"])  vars.loading = true;
	
	return current.game_state == 9 && old.game_state == 11;
}

isLoading {
	//check the total seconds left level
	if (60 * current.minutes + current.seconds > 60 * old.minutes + old.seconds) {
		vars.loading = false;
	}
	
	return vars.loading;
}

reset {
	//game_state:0 = main menu
	if(current.game_state == 0 && old.game_state == 9) return true;
}

split {
	if (current.hole_finished_counter > old.hole_finished_counter) {
		if(settings["pause_when_loading"]) vars.loading = true;
		return true;
	}
}
