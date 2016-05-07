using Toybox.Application as App;
using Toybox.Graphics as Gfx;
using Toybox.WatchUi as Ui;

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
    }

    //! onStop() is called when your application is exiting
    function onStop() {
    }

    //! Return the initial view of your application here
    function getInitialView() {
        return [new TriView(mSport, mSettings), new TriInputDelegate(mSport, mSettings)];
    }

}