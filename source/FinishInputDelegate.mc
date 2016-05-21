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

	function onTap(evt) {

		return true;
	}

	function onKey(evt) {
		var key = evt.getKey();

		if (key == Ui.KEY_ESC) {
			if (mSport.session != null) {
				mSport.session.discard();
				Ui.popView(Ui.SLIDE_IMMEDIATE);
			}
			Sys.exit();
		}
		else if (key == Ui.KEY_ENTER) {
//not much here
		}
		return true;
	}
}

class saveInputDelegate extends Ui.InputDelegate {

	hidden var mSport;
	hidden var mSettings;

	function initialize(sport, settings) {
		InputDelegate.initialize();
		mSport = sport;
		mSettings = settings;
	}

	function onKey(evt) {
	}

	function onTap(evt) {
		var clickEvent = evt.getType();
			if (clickEvent == CLICK_TYPE_TAP) {
				var coords = evt.getCoordinates();
				if ((coords[0] > 70) && (coords[1] > 100)) {
					if (Toybox has :ActivityRecording) {
						if (mSport.session != null) {
							mSport.session.save(); //progress bar maybe?
							Sys.exit();
						}
					}
				}
				else if ((coords[0] < 55) && (coords[1] > 100)) {
					var cd = new Ui.Confirmation("Discard Activity?");
					Ui.pushView(cd, new CD(mSport), Ui.SLIDE_IMMEDIATE);
				}
			}
	}
}