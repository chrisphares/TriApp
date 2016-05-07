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
			Sys.println("start this");
			var view = getNextView();
			mSport.setSport(SPORT_SWIM); //or is it??
			mSport.setState(ACTIVITY_RECORD);

			Ui.switchToView(view, new SportInputDelegate(mSport, mSettings), Ui.SLIDE_IMMEDIATE);
		}
	}

	function getNextView() {
		var nextSport = mSport.getSport() + 1; //add transition yes/no ness plus additionl settings for the page types/ order
		var view = null;

		if (nextSport == SPORT_SWIM) {
			view = new TwoView(mSport, mSettings);
		}
		else if (nextSport == SPORT_T1 || nextSport == SPORT_T2) {
			view = new TwoView(mSport, mSettings);
		}
		else if (nextSport == SPORT_BIKE) {
			view = new FourView(mSport, mSettings);
		}
		else if (nextSport == SPORT_RUN) {
			view = new FourView(mSport, mSettings);
		}

		return view;
	}
}