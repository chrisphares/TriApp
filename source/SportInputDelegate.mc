using Toybox.System as Sys;
using Toybox.WatchUi as Ui;

class SportInputDelegate extends Ui.InputDelegate {

	hidden var mSport;
	hidden var mSettings;
	hidden var mTimer;

	function initialize(sport, settings) {
		InputDelegate.initialize();
		mSport = sport;
		mSettings = settings;
		mTimer = new Timer.Timer();
	}

	function onHold(evt) {
		if ((mSport.getState() == ACTIVITY_STOP) || (mSport.getState() == ACTIVITY_FINISH)) {
		}
		else if ((mSport.getSport() != SPORT_SWIM) && (mSport.getState() != SPORT_FINISH)) {
			mSport.setState(ACTIVITY_STOP);
		}
		return true;
	}

	function onTap(evt) {
		if ((mSport.getState() == ACTIVITY_STOP) && (mSport.getState() != SPORT_FINISH)) {
			mSport.setState(ACTIVITY_RECORD);
		}
		return true;
	}

	function onKey(evt) {
		var key = evt.getKey();

		if (key == Ui.KEY_ESC) {
        	Sys.println("key disabled... for now"); //add check for activity_stop
        	return true;
		}
		else if (key == Ui.KEY_ENTER) {
			if (mSport.getState() == ACTIVITY_RECORD) {
				if (mSettings.getNextSport() != SPORT_FINISH) {
					mSport.setSport(mSettings.getNextSport());
					mSettings.sportIndex++;
					Ui.switchToView(new FourView(mSport, mSettings), new SportInputDelegate(mSport, mSettings), Ui.SLIDE_UP);
				}
				else {
					Ui.switchToView(new finishBubbleView(mSport, mSettings), new finishInputDelegate(mSport, mSettings), Ui.SLIDE_UP); //change input delegate
				}
			}
		}
		return true;
	}
}