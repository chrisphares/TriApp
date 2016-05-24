using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;

class TriView extends Ui.View {

	hidden var mSport;
	hidden var mSettings;
	hidden var flash = true;
	hidden var bpm;
	hidden var cadence;
	hidden var mTimer;

	function initialize(sport, settings) {
		View.initialize();
		mSport = sport;
		mSettings = settings;
		bpm = new Rez.Drawables.bpm();
		mTimer = new Timer.Timer();
	}

	function onLayout(dc) {
		setLayout(Rez.Layouts.initialLayout(dc));
	}

	function onShow() {
		mTimer.start(method(:flipFlash), 1000, true);
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
				dc.setColor(Gfx.COLOR_RED, Gfx.COLOR_TRANSPARENT);
			}
			else {
				dc.setColor(Gfx.COLOR_RED, Gfx.COLOR_TRANSPARENT);
			}

			if (flash == true) {
				drawGps(mSport.posnInfo.accuracy, dc);
			}
		}
		else {
			dc.setColor(Gfx.COLOR_DK_RED, Gfx.COLOR_TRANSPARENT);
			drawGps(0, dc);
		}

		bpm.draw(dc);
		var hr = View.findDrawableById("hr");
		hr.setText(mSport.getData(DATA_HR)[0]);
	}

	function drawGps(signal, dc) {
		if (signal == 0) {
			dc.fillPolygon([[25,5],[27,7],[10,37],[8,35]]);
			flash = true;
	    }
		if (signal > 0) {
			dc.setPenWidth(2);
	    	dc.drawLine(33, 31, 33, 26);
	    	dc.drawLine(37, 31, 37, 21);
	    }
	    if (signal > 2) {
	    	dc.drawLine(41, 31, 41, 16);
	    }
	    if (signal > 3) {
	    	dc.drawLine(45, 31, 45, 11);
	    }
	}

	function flipFlash() {
		if (flash == true) {
			flash = false;
		}
		else {
			flash = true;
		}
	}

	function onHide() {
		mTimer.stop();
	}
}