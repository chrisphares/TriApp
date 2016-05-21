using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.ActivityRecording as Record;

class FourView extends Ui.View {

	hidden var mSport;
	hidden var mSettings;
	hidden var drawBorder;
	hidden var image;
	hidden var drawPlay;
	hidden var drawStop;
	const TEXT_MARGIN = 2;
	const BORDER_PADDING = 4;

	function initialize(sport, settings) {
		View.initialize();
		mSport = sport;
		mSettings = settings;
		drawBorder = new Rez.Drawables.border();
		image = Rez.Drawables.playIcon;
		drawPlay = Ui.loadResource(image);
		drawStop = new Rez.Drawables.stop();
	}

    //! Load your resources here
    function onLayout(dc) {
    	borderWidth = dc.getWidth() - 4;
		borderHeight = dc.getHeight() - 4;
		setLayout(Rez.Layouts.dataFields(dc));
    }
	//! Called when this View is brought to the foreground. Restore
	//! the state of this View and prepare it to be shown. This includes
	//! loading resources into memory.
	function onShow() {
	}

	//! Update the view
    function onUpdate(dc) {
    	var thisSport = mSport.getSport();
    	var string = new [2];
    	var hValue;

    	lineColor = getLineColor(thisSport);

		string = mSport.getData(mSettings.sportData[thisSport][SPDAT_DATA][0]);
    	var topLeft = View.findDrawableById("topLeft");
		topLeft.setText(string[1]);
		var topLeftData = View.findDrawableById("topLeftData");
		//get this value from activity monitoring functionality
		if (mSettings.sportData[thisSport][SPDAT_DATA][1] == DATA_NA){
			hValue = (dc.getWidth() / 2) + (dc.getTextWidthInPixels(string[0], Gfx.FONT_NUMBER_MEDIUM) / 2);
			lineColor[0] = Gfx.COLOR_TRANSPARENT;
		}
		else {
			hValue = ((dc.getWidth() / 2) - BORDER_PADDING - TEXT_MARGIN);
			string = mSport.getData(mSettings.sportData[thisSport][SPDAT_DATA][1]);
			var topRight = View.findDrawableById("topRight");
			topRight.setText(string[1]);
			var topRightData = View.findDrawableById("topRightData");
			hValue = (dc.getWidth() - BORDER_PADDING - TEXT_MARGIN);
			topRightData.setText(string[0]);
			topRightData.setLocation(hValue, (dc.getHeight() / 2 - dc.getTextDimensions(string[0], Gfx.FONT_NUMBER_MEDIUM)[1] - TEXT_MARGIN));
		}
		topLeftData.setText(string[0]);
		topLeftData.setLocation(hValue, (dc.getHeight() / 2 - dc.getTextDimensions(string[0], Gfx.FONT_NUMBER_MEDIUM)[1] - TEXT_MARGIN));

		string = mSport.getData(mSettings.sportData[thisSport][SPDAT_DATA][2]);
		var bottomLeft = View.findDrawableById("bottomLeft");
		bottomLeft.setText(string[1]);
		var bottomLeftData = View.findDrawableById("bottomLeftData");
		if (mSettings.sportData[thisSport][SPDAT_DATA][3] == DATA_NA) {
			hValue = (dc.getWidth() / 2) + (dc.getTextWidthInPixels(string[0], Gfx.FONT_NUMBER_MEDIUM) / 2);
			lineColor[1] = Gfx.COLOR_TRANSPARENT;
		}
		else {
			hValue = ((dc.getWidth() / 2) - BORDER_PADDING - TEXT_MARGIN);
			string = mSport.getData(mSettings.sportData[thisSport][SPDAT_DATA][3]);
			var bottomRight = View.findDrawableById("bottomRight");
			bottomRight.setText(string[1]);
			var bottomRightData = View.findDrawableById("bottomRightData");
			hValue = (dc.getWidth() - BORDER_PADDING - TEXT_MARGIN);
			bottomRightData.setText(string[0]);
			bottomRightData.setLocation(hValue, (dc.getHeight() - dc.getTextDimensions(string[0], Gfx.FONT_NUMBER_MEDIUM)[1] - TEXT_MARGIN));
		}
		bottomLeftData.setText(string[0]);
		bottomLeftData.setLocation(hValue, (dc.getHeight() - dc.getTextDimensions(string[0], Gfx.FONT_NUMBER_MEDIUM)[1] - TEXT_MARGIN));

		string = mSport.getData(mSettings.sportData[thisSport][SPDAT_DATA][3]);
		var bottomRight = View.findDrawableById("bottomRight");
		bottomRight.setText(string[1]);
		var bottomRightData = View.findDrawableById("bottomRightData");
		hValue = (dc.getWidth() - BORDER_PADDING - TEXT_MARGIN);
		bottomRightData.setText(string[0]);
		bottomRightData.setLocation(hValue, (dc.getHeight() - dc.getTextDimensions(string[0], Gfx.FONT_NUMBER_MEDIUM)[1] - TEXT_MARGIN));

    	View.onUpdate(dc);
		drawBorder.draw(dc);
		if (play) {
			dc.drawBitmap(dc.getWidth() / 2 - 25, dc.getHeight() / 2 - 24, drawPlay);
		}
		if (stop) {
			drawStop.draw(dc);
		}
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