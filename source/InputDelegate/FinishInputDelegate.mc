using Toybox.System as Sys;
using Toybox.WatchUi as Ui;

class FinishInputDelegate extends Ui.InputDelegate {

	hidden var mSport;
	hidden var mSettings;

	function initialize(sport, settings) {
		InputDelegate.initialize();
		mSport = sport;
		mSettings = settings;
	}

	function onKey(evt) {
		var key = evt.getKey();

		if (key == Ui.KEY_ESC) {
			var cd = new Ui.Confirmation("Exit?");
			Ui.pushView(cd, new CD(), Ui.SLIDE_IMMEDIATE);
		}
		return true;
	}
}