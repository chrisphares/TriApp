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
		if (mSport.getState() == ACTIVITY_STOP) {
			Sys.println("activity already stopped, do nothing");
		}
		else if (mSport.getSport() != SPORT_SWIM) {
			Sys.println("activity not stopped, stop it");
			mSport.setState(ACTIVITY_STOP);
		}
		return true;
	}

	function onTap(evt) {
		if (mSport.getState() == ACTIVITY_STOP) {
			Sys.println("activity stopped, start it");
			mSport.setState(ACTIVITY_RECORD);
		}
		else {
			Sys.println("activity not stopped, do nothing");
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
			Sys.println("enter");
			if (mSport.getState() == ACTIVITY_RECORD) {
				Sys.println("activity recording, transition");
				var view = getNextView();
				mSport.setSport(mSport.getSport() + 1);
				mSport.setState(ACTIVITY_RECORD);
				Ui.switchToView(view, new SportInputDelegate(mSport, mSettings), Ui.SLIDE_IMMEDIATE);
			}
		}
		return true;
	}

	function getNextView() {
		var nextSport = mSport.getSport() + 1; //add transition yes/no ness plus additionl settings for the page types
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