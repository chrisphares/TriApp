using Toybox.Application as App;
using Toybox.Graphics as Gfx;
using Toybox.WatchUi as Ui;
using Toybox.Sensor as Snsr;

// Globals *********************************
enum {
	ACTIVITY_STOP,
	ACTIVITY_RECORD,
	ACTIVITY_FINISH
}

enum {
	SPORT_SWIM,
	SPORT_T1,
	SPORT_BIKE,
	SPORT_T2,
	SPORT_RUN,
	SPORT_FINISH
}

enum {
	DATA_NA,
	DATA_SWIM_DISTANCE,
	DATA_ELAPSED_TIME,
	DATA_LAP_TIME,
	DATA_HR,
	DATA_CADENCE,
	DATA_10S_POWER,
	DATA_30S_POWER,
	DATA_LAP_PACE
}

var lineColor;
var borderLine = Gfx.COLOR_TRANSPARENT;
var borderWidth;
var borderHeight;
var play = false; //play animation visible
var stop = false; //stop animation visible
var t1 = true; //t1 or t2; remove with correct order function

// *****************************************

class TriApp extends App.AppBase {

	var mSport;

    function initialize() {
        AppBase.initialize();
    }

    //! onStart() is called on application start up
    function onStart() {
    	mSport = new TriSport();
    	mSettings = new TriSettings();
    	Position.enableLocationEvents(Position.LOCATION_CONTINUOUS, method(:onPosition));
		Snsr.setEnabledSensors([Snsr.SENSOR_HEARTRATE], [Snsr.SENSOR_FOOTPOD]);
		Snsr.enableSensorEvents(method(:onSnsr));
    }

    //! onStop() is called when your application is exiting
    function onStop() {
    	Position.enableLocationEvents(Position.LOCATION_DISABLE, method(:onPosition));
    }

    function onPosition(info) {
        mSport.setPosition(info);
    }

	function onSnsr(sensor_info) {
		mSport.setSnsr(sensor_info);
	}

    //! Return the initial view of your application here
    function getInitialView() {
        return [new TriView(mSport, mSettings), new TriInputDelegate(mSport, mSettings)];
    }

}