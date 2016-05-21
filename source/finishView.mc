using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;

class finishBubbleView extends Ui.View {

	hidden var mSport;
	hidden var mSettings;
	const TEXT_MARGIN = 2;

	function initialize(sport, settings) {
		View.initialize();
		mSport = sport;
		mSettings = settings;
	}

    function onLayout(dc) {
		setLayout(Rez.Layouts.finishBubble(dc));
    }

	function onShow() {
	}

    function onUpdate(dc) {
    	var labels = getBubbleLabel();
    	var string;

    	var header = View.findDrawableById("header");
    	header.setColor(Gfx.COLOR_LT_GRAY);
    	var headerData = View.findDrawableById("header_Data");
    	string = mSport.formatTime(mSport.activityTime[SPORT_FINISH]);
    	headerData.setText(string);

    	var bubble1 = View.findDrawableById("bubble1");
    	bubble1.setColor(Gfx.COLOR_LT_GRAY);
		bubble1.setText(labels[0]);
		var bubble1Data = View.findDrawableById("bubble1_Data");
		string = mSport.formatTime(mSport.activityTime[mSettings.sportOrder[0]]); //need correct data for order
		bubble1Data.setText(string);

    	var bubble2 = View.findDrawableById("bubble2");
    	bubble2.setColor(Gfx.COLOR_LT_GRAY);
		bubble2.setText(labels[1]);
		var bubble2Data = View.findDrawableById("bubble2_Data");
		string = mSport.formatTime(mSport.activityTime[mSettings.sportOrder[1]]);
		bubble2Data.setText(string);

    	var bubble3 = View.findDrawableById("bubble3");
    	bubble3.setColor(Gfx.COLOR_LT_GRAY);
		bubble3.setText(labels[2]);
		var bubble3Data = View.findDrawableById("bubble3_Data");
		string = mSport.formatTime(mSport.activityTime[mSettings.sportOrder[2]]);
		bubble3Data.setText(string);

    	var bubble4 = View.findDrawableById("bubble4");
    	bubble4.setColor(Gfx.COLOR_LT_GRAY);
		bubble4.setText(labels[3]);
		var bubble4Data = View.findDrawableById("bubble4_Data");
		string = mSport.formatTime(mSport.activityTime[mSettings.sportOrder[3]]);
		bubble4Data.setText(string);

    	var bubble5 = View.findDrawableById("bubble5");
    	bubble5.setColor(Gfx.COLOR_LT_GRAY);
		bubble5.setText(labels[4]);
		var bubble5Data = View.findDrawableById("bubble5_Data");
		string = mSport.formatTime(mSport.activityTime[mSettings.sportOrder[4]]);
		bubble5Data.setText(string);

		lineColor = getBubbleColor();

		View.onUpdate(dc);
    }

	function onHide() {
	}

	function getBubbleColor() {
		var line = new [5];

		for (var i = 0; i < (mSettings.sportOrder.size() - 1); i++) {
			line[i] = mSettings.sportData[mSettings.sportOrder[i]][SPDAT_INFO][2];
		}
		return line;
	}

	function getBubbleLabel() {
		var label = new [5];

		for (var i = 0; i < (mSettings.sportOrder.size() - 1); i++) {
			label[i] = mSettings.sportData[mSettings.sportOrder[i]][SPDAT_INFO][0];
		}
		return label;
	}
}

class saveView extends Ui.View {
	hidden var mSport;
	hidden var mSettings;

	function initialize(sport, settings) {
		View.initialize();
		mSport = sport;
		mSettings = settings;
	}

    function onLayout(dc) {
		setLayout(Rez.Layouts.finishBubble(dc));
    }

    function onUpdate(dc) {

    }
}