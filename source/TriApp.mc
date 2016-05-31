using Toybox.WatchUi as Ui;
using Toybox.Sensor as Snsr;
using Toybox.Graphics as Gfx;
using Toybox.Application as App;

// Globals *********************************
enum {
	ACTIVITY_STOP,
	ACTIVITY_RECORD
}

enum {
	NEXT_SPORT,
	NEXT_DATA
}

enum {
	SPDAT_INFO,
	SPDAT_DATA
}

enum {
	DATA_NA,
	DATA_SWIM_DISTANCE,
	DATA_ELAPSED_TIME,
	DATA_LAP_TIME,
	DATA_HR,
	DATA_RUN_CADENCE,
	DATA_BIKE_CADENCE,
	DATA_10S_POWER,
	DATA_30S_POWER,
	DATA_LAP_PACE
}

const SPORT_FINISH = 20; //add a type in the enum
var lineColor; //seperator line color
var borderLine = Gfx.COLOR_TRANSPARENT; //hide it unless explicitly changed
var borderWidth;
var borderHeight;
var play = false; //play animation visible
var stop = false; //stop animation visible

// *****************************************

class TriApp extends App.AppBase {

	var mSport;
	var mSettings;

    function initialize() {
        AppBase.initialize();
    }

    //! onStart() is called on application start up
    function onStart() {
    	mSport = new TriSport();
    	mSettings = new TriSettings();
    	Position.enableLocationEvents(Position.LOCATION_CONTINUOUS, method(:onPosition));
		Snsr.setEnabledSensors([Snsr.SENSOR_HEARTRATE], [Snsr.SENSOR_FOOTPOD], [Snsr.SENSOR_BIKECADENCE], [Snsr.SENSOR_BIKEPOWER]);
		Snsr.enableSensorEvents(method(:onSnsr));
    }

    function onStop() {
    	Position.enableLocationEvents(Position.LOCATION_DISABLE, method(:onPosition));
    }

    function onPosition(info) {
        mSport.setPosition(info);
    }

	function onSnsr(sensor_info) {
		mSport.setSnsr(sensor_info);
	}

    function getInitialView() {
        return [new TriView(mSport, mSettings), new TriInputDelegate(mSport, mSettings)];
    }

}