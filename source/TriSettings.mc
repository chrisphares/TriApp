using Toybox.System as Sys;

class TriSettings {
	//get this from settings data, set it for initial swim data
	var labels = [
		["Distance","","Lap Time",""],
		["Elapsed Time","","Heart Rate",""],
		["10s Power","30s Power","Heart Rate","Cadence"],
		["Elapsed Time","","Heart Rate",""],
		["Elapsed Time","Lap Pace","Heart Rate","Cadence"]
	];

	function initialize() {
	}

	function getLabelText(sport) {
		Sys.println(labels[0][0]);
		var label = [labels[sport][0],labels[sport][1],labels[sport][2],labels[sport][3]];
		return label;
	}
}