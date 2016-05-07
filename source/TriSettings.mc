using Toybox.System as Sys;
using Toybox.Graphics as Gfx;

class TriSettings {
	//get this from settings data, set it for initial swim data
	var labels = [
		["Distance","","Lap Time","",""],
		["Elapsed Time","","Heart Rate","",""],
		["10s Power","30s Power","Heart Rate","Cadence",""],
		["Elapsed Time","","Heart Rate","",""],
		["Elapsed Time","Lap Pace","Heart Rate","Cadence",""],
		["Elapsed Time","Distance","33.3","",""],
		["Swim","T1","Bike","T2", "Run"]
	];

	function initialize() {
	}

	function getLabelText(sport) {
		var label = [labels[sport][0],labels[sport][1],labels[sport][2],labels[sport][3],labels[sport][4]];
		return label;
	}

	function getLineColor(sport) {
		var mSport = sport;
		var line = new [2];

		if (sport == SPORT_SWIM) {
			line[0] = Gfx.COLOR_TRANSPARENT;
			line[1] = Gfx.COLOR_BLUE;
		}
		else if (sport == SPORT_T1 || sport == SPORT_T2) {
			line[0] = Gfx.COLOR_TRANSPARENT;
			line[1] = Gfx.COLOR_PURPLE;
		}
		else if (sport == SPORT_BIKE) {
			line[0] = Gfx.COLOR_YELLOW;
			line[1] = Gfx.COLOR_YELLOW;
		}
		else if (sport == SPORT_RUN) {
			line[0] = Gfx.COLOR_DK_RED;
			line[1] = Gfx.COLOR_DK_RED;
		}
		else if (sport == SPORT_FINISH) {
			line = new [5];
			line[0] = Gfx.COLOR_DK_BLUE;
			line[1] = Gfx.COLOR_PURPLE;
			line[2] = Gfx.COLOR_YELLOW;
			line[3] = Gfx.COLOR_PURPLE;
			line[4] = Gfx.COLOR_DK_RED;
		}
		return line;
	}
}