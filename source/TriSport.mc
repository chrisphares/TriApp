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
				checkPower(currentSport);
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
					session.save();
					return true;
				}
				else {
					session = Record.createSession({:name=>"MulstiSport", :sport=>currentSport});
					session.start(); //handle this better.
					checkPower(currentSport);
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
		var sensInfo = Sensor.getInfo();
		var sportData = new [2];

		if (label == DATA_NA) {
			sportData[0] = ""; //blank
			sportData[1] = ""; //blank
		}
		else if (label == DATA_SWIM_DISTANCE) {
			if (actInfo.elapsedDistance != null) {
				sportData[0] = actInfo.elapsedDistance.format("%d"); //meters
			}
			else {
				sportData[0] = "--";
			}
			sportData[1] = "Distance";
		}
		else if (label == DATA_ELAPSED_TIME) {
			if (actInfo.elapsedTime != null) {
				sportData[0] = formatTime(actInfo.elapsedTime); //add all the times together
			}
			else {
				sportData[0] = "00:00";
			}
			sportData[1] = "Timer";
		}
		else if (label == DATA_LAP_TIME) { //not accurate yet
			sportData[0] = "80:08.5";
			sportData[1] = "Lap Time";
		}
		else if (label == DATA_HR) {
			if (sensInfo.heartRate != null) {
				sportData[0] = sensInfo.heartRate.format("%d");
			}
			else {
				sportData[0] = "--";
			}
			sportData[1] = "Heart Rate";
		}
		else if (label == DATA_RUN_CADENCE) {
			if (actInfo.currentCadence != null) {
				sportData[0] = actInfo.currentCadence.toString();
			}
			else {
				sportData[0] = "--";
			}
			sportData[1] = "Cadence";
		}
		else if (label == DATA_BIKE_CADENCE) {
			sportData[0] = "--";
			sportData[1] = "Cadence";
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
				sportData[0] = (power / count).toString();
			}
			else {
				sportData[0] = "--";
			}
			sportData[1] = "10s Power";
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
				sportData[0] = (power / count).toString();
			}
			else {
				sportData[0] = "--";
			}
			sportData[1] = "30s Power";
		}
		else if (label == DATA_LAP_PACE) {
			sportData[0] = "6:70";
			sportData[1] = "Lap Pace";
		}

		return sportData;
	}

	function checkPower(sport) {
		if (sport == Record.SPORT_CYCLING) {
			powerTimer.start(method(:getPowerData), 1000, true);
		}
		else {
			powerTimer.stop();
		}
	}

	function getPowerData() { //create array of 30 seconds of power data
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