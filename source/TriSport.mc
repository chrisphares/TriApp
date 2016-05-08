using Toybox.System as Sys;
using Toybox.Graphics as Gfx;
using Toybox.WatchUi as Ui;

class TriSport {

	hidden var currentState;
	hidden var currentSport;
	hidden var mTimer;

	function initialize() {
		currentState = ACTIVITY_STOP;
		currentSport = -1;
		mTimer = new Timer.Timer();
	}

	function clearBorder() {
		borderLine = Gfx.COLOR_TRANSPARENT;
		Ui.requestUpdate();
		mTimer.stop();
	}

	function clearAnim() {
		play = false;
		stop = false;
		Ui.requestUpdate();
		mTimer.stop();
		mTimer.start(method(:clearBorder), 4000, false);
	}

	function getState() {
		return currentState;
	}

	function setState(state) {
		if (currentState != state) {
			currentState = state;

			if (currentState == ACTIVITY_STOP) {
				borderLine = Gfx.COLOR_DK_RED;
				stop = true;
				play = false;
				mTimer.stop();
				mTimer.start(method(:clearAnim), 1000, false); //clear animation color after 1 second
			}
			else if (currentState == ACTIVITY_RECORD) {
				borderLine = Gfx.COLOR_DK_GREEN;
				play = true;
				stop = false;
				mTimer.stop();
				mTimer.start(method(:clearAnim), 1000, false); //clear animation color after 1 second
			}
			else if (currentState == ACTIVITY_FINISH) {
				return true;
			}
			Ui.requestUpdate();
		}
		return true;
	}

	function getSport() {
		return currentSport;
	}

	function setSport(sport) {
		currentSport = sport;
		if (currentSport == SPORT_FINISH) {
			setState(ACTIVITY_FINISH);
			Sys.println("finished");
		}
		return true;
	}
}