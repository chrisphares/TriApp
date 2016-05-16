using Toybox.System as Sys;
using Toybox.Graphics as Gfx;

class TriSettings {
	//get this from settings data, set it for initial use

	//format: labels[SPORT_XXX][SP_DAT_XXX][#]
	var sportData = new [5];

	var sportOrder = [SPORT_SWIM, SPORT_T1, SPORT_BIKE, SPORT_T2, SPORT_RUN, SPORT_FINISH];
	var sportIndex = 0;

	function initialize() {
		sportData[SPORT_SWIM] = [
			["Distance","","Lap Time","",""],
			["Swim"],
			[Gfx.COLOR_TRANSPARENT, Gfx.COLOR_BLUE],
			[DATA_SWIM_DISTANCE, DATA_NA, DATA_LAP_TIME, DATA_NA]
		];
		sportData[SPORT_T1] = [
			["Elapsed Time","","Heart Rate","",""],
			["Tran"],
			[Gfx.COLOR_TRANSPARENT, Gfx.COLOR_PURPLE],
			[DATA_ELAPSED_TIME,	DATA_NA, DATA_HR, DATA_NA]
		];
		sportData[SPORT_BIKE] = [
			["10s Power","30s Power","Heart Rate","Cadence",""],
			["Bike"],
			[Gfx.COLOR_YELLOW, Gfx.COLOR_YELLOW],
			[DATA_10S_POWER, DATA_30S_POWER, DATA_HR, DATA_CADENCE]
		];
		sportData[SPORT_T2] = [
			["Elapsed Time","","Heart Rate","",""],
			["Tran"],
			[Gfx.COLOR_TRANSPARENT, Gfx.COLOR_PURPLE],
			[DATA_ELAPSED_TIME, DATA_NA, DATA_HR, DATA_NA]
		];
		sportData[SPORT_RUN] = [
			["Elapsed Time","Lap Pace","Heart Rate","Cadence",""],
			["Run"],
			[Gfx.COLOR_DK_RED, Gfx.COLOR_DK_RED],
			[DATA_ELAPSED_TIME, DATA_LAP_PACE, DATA_HR, DATA_CADENCE]
		];
	}

	function getNextSport() {
		var nextSport = sportIndex + 1;
		return sportOrder[nextSport];
	}

	function getLineColor(sport) {
		var mSport = sport;
		var line = new [2];
		line[0] = sportData[sport][SPDAT_COLOR][0];
		line[1] = sportData[sport][SPDAT_COLOR][1];
		return line;
	}
}