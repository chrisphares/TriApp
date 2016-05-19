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
			["Distance","","Lap Time",""],
			["Swim"],
			[Gfx.COLOR_TRANSPARENT, Gfx.COLOR_BLUE],
			[DATA_SWIM_DISTANCE, DATA_NA, DATA_LAP_TIME, DATA_NA]
		];
		sportData[Record.SPORT_TRANSITION] = [
			["Elapsed Time","","Heart Rate",""],
			["Trans"],
			[Gfx.COLOR_TRANSPARENT, Gfx.COLOR_PURPLE],
			[DATA_ELAPSED_TIME,	DATA_NA, DATA_HR, DATA_NA]
		];
		sportData[Record.SPORT_CYCLING] = [
			["10s Power","30s Power","Heart Rate","Cadence"],
			["Bike"],
			[Gfx.COLOR_YELLOW, Gfx.COLOR_YELLOW],
			[DATA_10S_POWER, DATA_30S_POWER, DATA_HR, DATA_CADENCE]
		];
		sportData[Record.SPORT_RUNNING] = [
			["Elapsed Time","Lap Pace","Heart Rate","Cadence"],
			["Run"],
			[Gfx.COLOR_DK_RED, Gfx.COLOR_DK_RED],
			[DATA_ELAPSED_TIME, DATA_LAP_PACE, DATA_HR, DATA_CADENCE]
		];
		sportOrder = [Record.SPORT_SWIMMING, Record.SPORT_TRANSITION, Record.SPORT_CYCLING, Record.SPORT_TRANSITION, Record.SPORT_RUNNING, SPORT_FINISH];
		sportIndex = 0;
	}

	function getNextSport() {
		var nextSport = sportIndex + 1;
		return sportOrder[nextSport];
	}

	function getLineColor(sport) {
		var mSport = sport;
		var line = new [2];
		line[0] = sportData[mSport][SPDAT_COLOR][0];
		line[1] = sportData[mSport][SPDAT_COLOR][1];
		return line;
	}
}