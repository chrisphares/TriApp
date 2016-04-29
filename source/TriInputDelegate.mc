using Toybox.System as Sys;
using Toybox.WatchUi as Ui;

class TriInputDelegate extends Ui.InputDelegate {

	hidden var mSport;
	hidden var mSettings;

	function initialize(sport, settings) {
		mSport = sport;
		mSettings = settings;
	}

	function onKey(evt) {
		var key = evt.getKey();

		if (key == KEY_ESC) {
        	Sys.println("dewsses.");
    		Sys.exit;
		}
	}

	function onKeyPressed(evt) {
		var key = evt.getKey();

		if (evt.getKey() == Ui.KEY_ENTER) {
			Sys.println("start this");
			mSport.setSport(SPORT_SWIM);
			mSport.setState(ACTIVITY_RECORD);

			//push a new view
			Ui.switchToView(new SwimView(mSport, mSettings), new SwimInputDelegate(mSport, mSettings), Ui.SLIDE_IMMEDIATE);
		}
	}
}