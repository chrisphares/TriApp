using Toybox.System as Sys;
using Toybox.Graphics as Gfx;
using Toybox.WatchUi as Ui;
using Toybox.Math as Math;
using Toybox.Activity as Act;
using Toybox.ActivityRecording as Record;

class TriSport {

	hidden var currentState;
	hidden var currentSport;
	hidden var mTimer;
	var posnInfo = null;
	var snsrInfo = null;
	var distance = 0.00;
	var session = null;
	var activityTime = new [6];

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
			if(Toybox has :ActivityRecording) {
				if (session == null) {
					session = Record.createSession({:name=>"Multisport Activity", :sport=>Record.SPORT_SWIMMING}); //get a better name
					session.start();
				}
			}
			if (currentState == ACTIVITY_STOP) {
				borderLine = Gfx.COLOR_DK_RED;
				stop = true;
				play = false;
				mTimer.stop();
				mTimer.start(method(:clearAnim), 1000, false); //clear animation color after 1 second
				if (session != null) {
					session.stop();
				}
			}
			else if (currentState == ACTIVITY_RECORD) {
				borderLine = Gfx.COLOR_DK_GREEN;
				play = true;
				stop = false;
				mTimer.stop();
				mTimer.start(method(:clearAnim), 1000, false); //clear animation color after 1 second
				if (session != null) {
					session.start();
				}
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
		var previousSport = currentSport;
		currentSport = sport; //replace with getnext sport
		var actInfo = Activity.getActivityInfo();

		if (Toybox has :ActivityRecording) {
			if ((session != null) && session.isRecording()) {
				activityTime[previousSport] = actInfo.elapsedTime;
				session.stop();
				if (currentSport == SPORT_SWIM) {
					session = Record.createSession({:name=>"Swim", :sport=>Record.SPORT_SWIMMING});
				}
				else if (currentSport == SPORT_T1) {
					session = Record.createSession({:name=>"Transition", :sport=>Record.SPORT_TRANSITION});
				}
				else if (currentSport == SPORT_BIKE) {
					session = Record.createSession({:name=>"Bike", :sport=>Record.SPORT_CYCLING});
				}
				else if (currentSport == SPORT_T2) {
					session = Record.createSession({:name=>"Transition", :sport=>Record.SPORT_TRANSITION});
				}
				else if (currentSport == SPORT_RUN) {
					session = Record.createSession({:name=>"Run", :sport=>Record.SPORT_RUNNING});
				}
				else if (currentSport == SPORT_FINISH) {
					activityTime[previousSport] = actInfo.elapsedTime;
					session.stop();
					setState(ACTIVITY_FINISH);
					activityTime[SPORT_FINISH] = getTotalTime();
					return true;
				}
				session.start();
			}
		}
		return true;
	}

	function setPosition(info) {
		posnInfo = info;
		Ui.requestUpdate();
	}

	function setSnsr(info) {
		snsrInfo = info;
		Ui.requestUpdate();
	}

	function formatTime(ms) {
		if (ms != null) {
			var seconds = (ms / 1000) % 60;
			var minutes = (ms / 60000) % 60;
			var hours = ms / 3600000;
			if (hours > 0) {
				return Lang.format("$1$:$2$.$3$", [hours, minutes.format("%02d"), seconds.format("%02d")]);
			}
			else {
				return Lang.format("$1$:$2$", [minutes.format("%02d"), seconds.format("%02d")]);
			}
		}
		else {
			return "--:--";
		}
	}

	function getTotalTime() {
		var totalTime = 0.00;
		for (var i = 0; i < (activityTime.size() - 1); i++) {
			if (activityTime[i] != null) {
				totalTime = totalTime + activityTime[i];
			}
		}
		return totalTime.toLong();
	}

	function getData(label) {
		var actInfo = Activity.getActivityInfo();
		var fieldData = null;

		if (label == DATA_NA) {
			fieldData = ""; //blank
		}
		else if (label == DATA_SWIM_DISTANCE) {
			if (actInfo.elapsedDistance != null) {
				fieldData = actInfo.elapsedDistance.format("%d"); //meters
			}
			else {
				fieldData = "--";
			}
		}
		else if (label == DATA_ELAPSED_TIME) {
			if (actInfo.elapsedTime != null) {
				fieldData = formatTime(actInfo.elapsedTime); //add all the times together
			}
			else {
				fieldData = "00:00";
			}
		}
		else if (label == DATA_LAP_TIME) { //not accurate yet
			fieldData = "00:00.0";
		}
		else if (label == DATA_HR) {
			if (snsrInfo.heartRate != null) {
				fieldData = snsrInfo.heartRate.format("%d");
			}
			else {
				fieldData = "--";
			}
		}
		else if (label == DATA_CADENCE) {
			if (actInfo.currentCadence != null) {
				fieldData = actInfo.currentCadence.toString();
			}
			else {
				fieldData = "--";
			}
		}
		else if (label == DATA_10S_POWER) {
			fieldData = "215";
		}
		else if (label == DATA_30S_POWER) {
			fieldData = "222";
		}
		else if (label == DATA_LAP_PACE) {
			fieldData = "6:70";
		}

		return fieldData;
	}
}