using Toybox.System as Sys;
using Toybox.WatchUi as Ui;

class SwimInputDelegate extends Ui.InputDelegate {

	hidden var mSport;
	hidden var mTimer;

	function initialize(sport) {
		mSport = sport;
		mTimer = new Timer.Timer();
	}

    function onKeyHeld() {
    	stopChange = true;
        if (mSport.getState() == ACTIVITY_STOP) {
        	Sys.println(state);
        	Sys.println("activity already stopped, do nothing");
        }
        else {
        	Sys.println("activity not stopped, stop it");
        	mSport.setState(ACTIVITY_STOP);
        	//stop the activity
        }
        return true;
    }

	function onKey(evt) {
		var key = evt.getKey();

		if (key == KEY_ESC) {
        	Sys.println("key disabled");
		}
        return true;
	}

	function onKeyPressed(evt) {
		var key = evt.getKey();

		if (key == Ui.KEY_ENTER) {
			Sys.println("enter");
			if (mSport.getState() == ACTIVITY_STOP) {
				mSport.setState(ACTIVITY_RECORD);
				Sys.println("start activititty");
				stopChange = true;
			}
			else {
				mTimer.stop();
				mTimer.start(method(:onKeyHeld), 1000, false); //do something after 1 second
			}
		}
	}

	function onKeyReleased(evt) {
		var key = evt.getKey();
		if (key == Ui.KEY_ENTER) {
			if (stopChange) {
				Sys.println("first press, dont do things");
				stopChange = false;
			}
			else if (mSport.getState() == ACTIVITY_RECORD) {
				Sys.println("activity recording do things");
				Ui.switchToView(new TransitionView(mSport), new TransitionInputDelegate(mSport), Ui.SLIDE_IMMEDIATE);
			}
			else {
				return true;
			}
		}

		mTimer.stop();
	}
}