using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;

class TriView extends Ui.View {

	hidden var mSport;
	hidden var mSettings;
	hidden var flash = true;
	hidden var bpm;
	hidden var cadence;

	function initialize(sport, settings) {
		View.initialize();
		mSport = sport;
		mSettings = settings;
		bpm = new Rez.Drawables.bpm();
		cadence = new Rez.Drawables.cadence();
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
		if (mSport.posnInfo != null) {
			if (mSport.posnInfo.accuracy == 4) {
				dc.setColor(Gfx.COLOR_DK_GREEN, Gfx.COLOR_TRANSPARENT);
				flash = true;
			}
			else if (mSport.posnInfo.accuracy == 3) {
				dc.setColor(Gfx.COLOR_DK_GREEN, Gfx.COLOR_TRANSPARENT);
			}
			else if (mSport.posnInfo.accuracy == 2) {
				dc.setColor(Gfx.COLOR_YELLOW, Gfx.COLOR_TRANSPARENT);
			}
			else if (mSport.posnInfo.accuracy == 1) {
				dc.setColor(Gfx.COLOR_DK_RED, Gfx.COLOR_TRANSPARENT);
			}
			else {
				dc.setColor(Gfx.COLOR_DK_RED, Gfx.COLOR_TRANSPARENT);
			}

			if (flash == true) {
				flash = false;
				drawGps(mSport.posnInfo.accuracy, dc);
			}
			else {
				flash = true;
			}
		}
		else {
			dc.setColor(Gfx.COLOR_DK_RED, Gfx.COLOR_TRANSPARENT);
			drawGps(0, dc);
		}

		bpm.draw(dc);
		var hr = View.findDrawableById("hr");
		hr.setText(mSport.getData(DATA_HR));

		cadence.draw(dc);
	}

	function drawGps(signal, dc) {
		if (signal == 0) {
			dc.fillPolygon([[25,5],[27,7],[10,37],[8,35]]);
			flash = true;
	    }
		if (signal > 0) {
			dc.setPenWidth(2);
	    	dc.drawLine(33, 31, 33, 26);
	    }
	    if (signal > 1) {
	    	dc.drawLine(37, 31, 37, 21);
	    }
	    if (signal > 2) {
	    	dc.drawLine(41, 31, 41, 16);
	    }
	    if (signal > 3) {
	    	dc.drawLine(45, 31, 45, 11);
	    }
	}

	function onHide() {
	}
}