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
		else if (evt.getKey() == Ui.KEY_ENTER) {
			mSport.setSport(SPORT_SWIM); //or is it??
			mSport.setState(ACTIVITY_RECORD);

			Ui.switchToView(new FourView(mSport, mSettings), new SportInputDelegate(mSport, mSettings), Ui.SLIDE_IMMEDIATE);
		}
	}
}