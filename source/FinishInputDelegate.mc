using Toybox.System as Sys;
using Toybox.WatchUi as Ui;

class finishInputDelegate extends Ui.InputDelegate {

	hidden var mSport;
	hidden var mSettings;
	hidden var mTimer;

	function initialize(sport, settings) {
		InputDelegate.initialize();
		mSport = sport;
		mSettings = settings;
		mTimer = new Timer.Timer();
	}

	function onTap(evt) {

		return true;
	}

	function onKey(evt) {
		var key = evt.getKey();

		if (key == Ui.KEY_ESC) {
			if ((mSport.session != null) && (mSport.session.isRecording() == false)) {
				Ui.pushView(new Ui.ProgressBar("Saving", null), null, Ui.SLIDE_IMMEDIATE);
				mSport.session.save();
				Ui.popView(Ui.SLIDE_IMMEDIATE);
			}
			Sys.exit();
		}
		else if (key == Ui.KEY_ENTER) {

		}
		return true;
	}
}