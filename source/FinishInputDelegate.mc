using Toybox.System as Sys;
using Toybox.WatchUi as Ui;

class finishInputDelegate extends Ui.InputDelegate {

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
			if (mSport.session != null) {
				var cd = new Ui.Confirmation("Exit?");
				Ui.pushView(cd, new CD(mSport), Ui.SLIDE_IMMEDIATE);
			}
		}
		return true;
	}
}