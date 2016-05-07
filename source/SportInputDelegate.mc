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
		else if ((mSport.getSport() != SPORT_SWIM) || (mSport.getState() != SPORT_FINISH)) {
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
			Sys.println("activity not stopped/is finished, do nothing");
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
			Sys.println("enter");
			if (mSport.getState() == ACTIVITY_RECORD) {
				if (mSport.getSport() != SPORT_FINISH) {
					mSport.setSport(mSport.getSport() + 1);
				}
				var view = getNextView();
				Ui.switchToView(view, new SportInputDelegate(mSport, mSettings), Ui.SLIDE_IMMEDIATE);
			}

		}
		return true;
	}

	function getNextView() {
		var nextSport = mSport.getSport(); //add transition yes/no ness plus additionl settings for the page types
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
		else if (nextSport == SPORT_FINISH) {
			view = new finishBubbleView(mSport, mSettings);
			mSport.setState(ACTIVITY_FINISH);
		}
		else if (nextSport > SPORT_FINISH) {
			Sys.exit(); // a bit harsh for now.
		}

		return view;
	}
}