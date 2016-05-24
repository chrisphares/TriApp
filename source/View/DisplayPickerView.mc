using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;

class DisplayPickerView extends Ui.View {

	hidden var mSport;
	hidden var mSettings;
	hidden var thisSport;
	const TEXT_MARGIN = 2;
	const BORDER_PADDING = 4;

	function initialize(sport, settings, displayPicker) {
		View.initialize();
		mSport = sport;
		mSettings = settings;
		thisSport = displayPicker;
	}

    function onLayout(dc) {
		setLayout(Rez.Layouts.dataFields(dc));
	}

	function onShow() {
	}

	//! Update the view
	function onUpdate(dc) {
    	var string;
    	var hValue;

    	lineColor = getLineColor(thisSport);

		string = mSettings.sportData[thisSport][SPDAT_INFO][1];
		var topLeft = View.findDrawableById("topLeft");
		topLeft.setText(string);

		string = mSport.getData(mSettings.sportData[thisSport][SPDAT_DATA][0])[1];
		var topLeftData = View.findDrawableById("topLeftData");
		topLeftData.setFont(Gfx.FONT_MEDIUM);
		topLeftData.setText(string);
		hValue = ((dc.getWidth() / 2) - BORDER_PADDING - TEXT_MARGIN);
		topLeftData.setLocation(hValue, (dc.getHeight() / 2 - dc.getTextDimensions(string, Gfx.FONT_MEDIUM)[1] - TEXT_MARGIN));

		var topRightData = View.findDrawableById("topRightData");
		hValue = (dc.getWidth() - BORDER_PADDING - TEXT_MARGIN);
		topRightData.setFont(Gfx.FONT_MEDIUM);
		if (mSettings.sportData[thisSport][SPDAT_DATA][1] == DATA_NA){
			string = "Empty";
		}
		else {
			string = mSport.getData(mSettings.sportData[thisSport][SPDAT_DATA][1])[1];
		}
		topRightData.setText(string);
		topRightData.setLocation(hValue, (dc.getHeight() / 2 - dc.getTextDimensions(string, Gfx.FONT_MEDIUM)[1] - TEXT_MARGIN));

		string = mSport.getData(mSettings.sportData[thisSport][SPDAT_DATA][2])[1];
		var bottomLeftData = View.findDrawableById("bottomLeftData");
		bottomLeftData.setFont(Gfx.FONT_MEDIUM);
		bottomLeftData.setText(string);
		hValue = ((dc.getWidth() / 2) - BORDER_PADDING - TEXT_MARGIN);
		bottomLeftData.setLocation(hValue, (dc.getHeight() - dc.getTextDimensions(string, Gfx.FONT_MEDIUM)[1] - TEXT_MARGIN));

		var bottomRightData = View.findDrawableById("bottomRightData");
		hValue = (dc.getWidth() - BORDER_PADDING - TEXT_MARGIN);
		bottomRightData.setFont(Gfx.FONT_MEDIUM);
		if (mSettings.sportData[thisSport][SPDAT_DATA][3] == DATA_NA){
			string = "Empty";
		}
		else {
			string = mSport.getData(mSettings.sportData[thisSport][SPDAT_DATA][3])[1];
		}
		bottomRightData.setText(string);
		bottomRightData.setLocation(hValue, (dc.getHeight() - dc.getTextDimensions(string, Gfx.FONT_MEDIUM)[1] - TEXT_MARGIN));

    	View.onUpdate(dc);
    }

   	function getLineColor(sport) {
   		var line = new [3];
   		for (var i = 0; i < 3; i++) {
			line[i] = mSettings.sportData[sport][SPDAT_INFO][2];
		}
		return line;
	}

	function onHide() {
	}
}