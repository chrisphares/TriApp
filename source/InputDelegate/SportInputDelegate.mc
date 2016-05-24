using Toybox.System as Sys;
using Toybox.WatchUi as Ui;
using Toybox.ActivityRecording as Record;

class SportInputDelegate extends Ui.InputDelegate {

	hidden var mSport;
	hidden var mSettings;

	function initialize(sport, settings) {
		InputDelegate.initialize();
		mSport = sport;
		mSettings = settings;
	}

	function onHold(evt) {
		if ((mSport.getState() == ACTIVITY_RECORD) && (mSport.getSport() != (Record.SPORT_SWIMMING || SPORT_FINISH))) {
			mSport.setState(ACTIVITY_STOP);
		}
		return true;
	}

	function onTap(evt) {
		if ((mSport.getState() == ACTIVITY_STOP) && (mSport.getSport() != SPORT_FINISH)) {
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
				mSport.setSport(mSettings.getNextSport());
				if (mSettings.getNextSport() != SPORT_FINISH) {
					mSettings.sportIndex++;
					Ui.switchToView(new FourView(mSport, mSettings), new SportInputDelegate(mSport, mSettings), Ui.SLIDE_UP);
				}
				else {
					mSettings.sportIndex++;
					Ui.switchToView(new FinishBubbleView(mSport, mSettings), new FinishInputDelegate(mSport, mSettings), Ui.SLIDE_UP);
				}
			}
		}
		return true;
	}
}