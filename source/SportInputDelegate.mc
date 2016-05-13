using Toybox.System as Sys;
using Toybox.WatchUi as Ui;

class SportInputDelegate extends Ui.InputDelegate {

	hidden var mSport;
	hidden var mSettings;
	hidden var mTimer;

	function initialize(sport, settings) {
		mSport = sport;
		mSettings = settings;
		mTimer = new Timer.Timer();
	}

	function onHold(evt) {
		if ((mSport.getState() == ACTIVITY_STOP) || (mSport.getState() == ACTIVITY_FINISH)) {
			Sys.println("activity already stopped/finished, do nothing");
		}
		else if ((mSport.getSport() != SPORT_SWIM) && (mSport.getState() != SPORT_FINISH)) {
			Sys.println("activity not stopped(or swim), stop it");
			mSport.setState(ACTIVITY_STOP);
		}
		return true;
	}

	function onTap(evt) {
		if ((mSport.getState() == ACTIVITY_STOP) && (mSport.getState() != SPORT_FINISH)) {
			Sys.println("activity stopped, start it");
			mSport.setState(ACTIVITY_RECORD);
		}
		else {
			Sys.println("activity not stopped/finished, do nothing");
		}
		return true;
	}

	function onKey(evt) {
		var key = evt.getKey();

		if (key == Ui.KEY_ESC) {
			if (mSport.getState() == ACTIVITY_FINISH) {
				Sys.exit();
			}
			else {
	        	Sys.println("key disabled... for now"); //add check for activity_stop
	        	return true;
	        }
		}
		else if (key == Ui.KEY_ENTER) {
			if (mSport.getState() == ACTIVITY_RECORD) {
				mSport.setSport(mSport.getSport() + 1);
				if (mSport.getSport() != SPORT_FINISH) {
					Ui.switchToView(new FourView(mSport, mSettings), new SportInputDelegate(mSport, mSettings), Ui.SLIDE_UP);
				}
				else {
					Ui.switchToView(new finishBubbleView(mSport, mSettings), new SportInputDelegate(mSport, mSettings), Ui.SLIDE_UP); //change input delegate
				}
			}
		}
		return true;
	}
}