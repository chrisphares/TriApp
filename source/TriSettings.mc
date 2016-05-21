using Toybox.System as Sys;
using Toybox.Graphics as Gfx;
using Toybox.ActivityRecording as Record;

class TriSettings {
	//format: sportData[Record.SPORT_ENUM][SP_DAT_ENUM][VALUE]
	var sportData = new [32]; //all sports
	var sportOrder = new[6]; //up to 5 sports
	var sportIndex;

	function initialize() {
		sportData[Record.SPORT_SWIMMING] = [
			["Swim","Swimming", Gfx.COLOR_BLUE],
			[DATA_SWIM_DISTANCE, DATA_NA, DATA_LAP_TIME, DATA_NA]
		];
		sportData[Record.SPORT_TRANSITION] = [
			["Trans","Transition", Gfx.COLOR_PURPLE],
			[DATA_ELAPSED_TIME,	DATA_NA, DATA_HR, DATA_NA]
		];
		sportData[Record.SPORT_CYCLING] = [
			["Bike","Cycling", Gfx.COLOR_YELLOW],
			[DATA_10S_POWER, DATA_30S_POWER, DATA_HR, DATA_CADENCE]
		];
		sportData[Record.SPORT_RUNNING] = [
			["Run","Run", Gfx.COLOR_DK_RED],
			[DATA_ELAPSED_TIME, DATA_LAP_PACE, DATA_HR, DATA_CADENCE]
		];
		sportOrder = [Record.SPORT_SWIMMING, Record.SPORT_TRANSITION, Record.SPORT_CYCLING, Record.SPORT_TRANSITION, Record.SPORT_RUNNING, SPORT_FINISH];
		sportIndex = 0;
	}

	function getNextSport() {
		var nextSport = sportIndex + 1;
		return sportOrder[nextSport];
	}
}