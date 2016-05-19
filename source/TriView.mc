using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;

class TriView extends Ui.View {

	hidden var mSport;
	hidden var mSettings;
	hidden var flash = true;

	function initialize(sport, settings) {
		View.initialize();
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
	}

	function drawGps(signal, dc) {
		if (signal == 0) {
			dc.fillPolygon([[25,25],[27,27],[10,57],[8,55]]);
			flash = true;
	    }
		if (signal > 0) {
	    	dc.drawArc(21, 30, 8, Gfx.ARC_COUNTER_CLOCKWISE, 350, 100);
	    	dc.drawArc(21, 30, 9, Gfx.ARC_COUNTER_CLOCKWISE, 350, 100);
	    }
	    if (signal > 1) {
	    	dc.drawArc(21, 30, 13, Gfx.ARC_COUNTER_CLOCKWISE, 350, 100);
	    	dc.drawArc(21, 30, 14, Gfx.ARC_COUNTER_CLOCKWISE, 350, 100);
	    }
	    if (signal > 2) {
	    	dc.drawArc(21, 30, 18, Gfx.ARC_COUNTER_CLOCKWISE, 350, 100);
	    	dc.drawArc(21, 30, 19, Gfx.ARC_COUNTER_CLOCKWISE, 350, 100);
	    }
	}

	function onHide() {
	}
}