using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;

class TriView extends Ui.View {

	hidden var mSport;
	hidden var mSettings;

	function initialize(sport, settings) {
		mSport = sport;
		mSettings = settings;
	}

    //! Load your resources here
    function onLayout(dc) {
		setLayout(Rez.Layouts.initialLayout(dc));
    }
	//! Called when this View is brought to the foreground. Restore
	//! the state of this View and prepare it to be shown. This includes
	//! loading resources into memory.
	function onShow() {

	}

	//! Update the view
    function onUpdate(dc) {
    	View.onUpdate(dc);
    }

	function onHide() {
	}
}