using Toybox.System as Sys;
using Toybox.Graphics as Gfx;
using Toybox.WatchUi as Ui;
using Toybox.Activity as Act;
using Toybox.ActivityRecording as Record;

class TriSport {

	hidden var currentSport = null;
	hidden var mTimer;
	hidden var powerTimer;
	var posnInfo = null;
	var snsrInfo = null;
	var distance = 0.00;
	var session = null;
	var activityTime = new [32];
	var powerData = new [30];

	function initialize() {
		mTimer = new Timer.Timer();
		powerTimer = new Timer.Timer();
	}

	function setPosition(info) {
		posnInfo = info;
		Ui.requestUpdate();
	}

	function setSnsr(sensor_info) {
		snsrInfo = sensor_info;
		Ui.requestUpdate();
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

	function startRecord(sport) {
		currentSport = sport;
		if (Toybox has :ActivityRecording) {
			if (session == null) {
				session = Record.createSession({:name=>"MultiSport", :sport=>currentSport});
				setState(ACTIVITY_RECORD);
			}
		}
	}

	function getState() {
		if (Toybox has :ActivityRecording) {
			if ((session == null) || (session.isRecording() == false)) {
				return ACTIVITY_STOP;
			}
			else if ((session != null) && (session.isRecording() == true)) {
				return ACTIVITY_RECORD;
			}
		}
	}

	function setState(state) {
		if (getState() != state) {
			if (state == ACTIVITY_STOP) {
				borderLine = Gfx.COLOR_DK_RED;
				stop = true;
				play = false;
				if (session != null) {
					session.stop();
				}
			}
			else if (state == ACTIVITY_RECORD) {
				borderLine = Gfx.COLOR_DK_GREEN;
				play = true;
				stop = false;
				if (session != null) {
					session.start();
				}
			}
			mTimer.stop();
			mTimer.start(method(:clearAnim), 1000, false); //clear animation color after 1 second
			Ui.requestUpdate();
		}
		return true;
	}

	function getSport() {
		return currentSport;
	}

	function setSport(sport) {
		var previousSport = currentSport;
		currentSport = sport;
		if (Toybox has :ActivityRecording) {
			var actInfo = Activity.getActivityInfo();
			if ((session != null) && session.isRecording()) { //see below; re: handling
				activityTime[previousSport] = actInfo.elapsedTime;
				session.stop();
				if (currentSport == SPORT_FINISH) {
					activityTime[SPORT_FINISH] = getTotalTime();
					return true;
				}
				else {
					session = Record.createSession({:name=>"MulstiSport", :sport=>currentSport});
					session.start(); //handle this better.
					if (currentSport == Record.SPORT_CYCLING) {
						powerTimer.start(method(:getPowerData), 1000, true);
					}
					else {
						powerTimer.stop();
					}
				}
			}
		}
		return true;
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
				return Lang.format("$1$:$2$", [minutes.format("%d"), seconds.format("%02d")]);
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
			fieldData = "80:08.5";
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
			var count = 0;
			var power = 0;
			for (var i = 0; i < 10; i++) {
				if (powerData[i] != null) {
					count ++;
					power = power + powerData[i];
				}
			}
			if (count > 0) {
				fieldData = (power / count).toString();
			}
			else {
				fieldData = "--";
			}
		}
		else if (label == DATA_30S_POWER) {
			var count = 0;
			var power = 0;
			for (var i = 0; i < 30; i++) {
				if (powerData[i] != null) {
					count ++;
					power = power + powerData[i];
				}
			}
			if (count > 0) {
				fieldData = (power / count).toString();
			}
			else {
				fieldData = "--";
			}
		}
		else if (label == DATA_LAP_PACE) {
			fieldData = "6:70";
		}

		return fieldData;
	}

	function getPowerData() {
		var actInfo = Activity.getActivityInfo();
		var currentPower = actInfo.currentPower;
		if (currentPower != null) {
			for (var i = 28; i >= 0; i--) {
				powerData[i + 1] = powerData[i];
			}
			powerData[0] = currentPower;
		}
	}
}