using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;

class finishBubbleView extends Ui.View {

	hidden var mSport;
	hidden var mSettings;
	const TEXT_MARGIN = 2;

	function initialize(sport, settings) {
		mSport = sport;
		mSettings = settings;
	}

    //! Load your resources here
    function onLayout(dc) {
		setLayout(Rez.Layouts.finishBubble(dc));
    }
	//! Called when this View is brought to the foreground. Restore
	//! the state of this View and prepare it to be shown. This includes
	//! loading resources into memory.
	function onShow() {
	}

	//! Update the view
    function onUpdate(dc) {
    	var labels = mSettings.getLabelText(mSport.getSport());
    	var string;

    	var header = View.findDrawableById("header");
    	header.setColor(Gfx.COLOR_LT_GRAY);

    	var bubble1 = View.findDrawableById("bubble1");
    	bubble1.setColor(Gfx.COLOR_LT_GRAY);
		bubble1.setText(labels[0]); //change all of these to standard text, add real labels
		var bubble1Data = View.findDrawableById("bubble1_Data");
		//get this value from activity monitoring functionality
		string = "45:15";
		bubble1Data.setText(string);

    	var bubble2 = View.findDrawableById("bubble2");
    	bubble2.setColor(Gfx.COLOR_LT_GRAY);
		bubble2.setText(labels[1]);
		var bubble2Data = View.findDrawableById("bubble2_Data");
		//get this value from activity monitoring functionality
		string = "2:35";
		bubble2Data.setText(string);

    	var bubble3 = View.findDrawableById("bubble3");
    	bubble3.setColor(Gfx.COLOR_LT_GRAY);
		bubble3.setText(labels[2]);
		var bubble3Data = View.findDrawableById("bubble3_Data");
		//get this value from activity monitoring functionality
		string = "3:02:03";
		bubble3Data.setText(string);

    	var bubble4 = View.findDrawableById("bubble4");
    	bubble4.setColor(Gfx.COLOR_LT_GRAY);
		bubble4.setText(labels[3]);
		var bubble4Data = View.findDrawableById("bubble4_Data");
		//get this value from activity monitoring functionality
		string = "1:56";
		bubble4Data.setText(string);

    	var bubble5 = View.findDrawableById("bubble5");
    	bubble5.setColor(Gfx.COLOR_LT_GRAY);
		bubble5.setText(labels[4]);
		var bubble5Data = View.findDrawableById("bubble5_Data");
		//get this value from activity monitoring functionality
		string = "1:33:22";
		bubble5Data.setText(string);

		lineColor = mSettings.getLineColor(mSport.getSport());

		View.onUpdate(dc);
    }

	function onHide() {
	}
}