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
		setLayout(Rez.Layouts.evenFields(dc));
    }
	//! Called when this View is brought to the foreground. Restore
	//! the state of this View and prepare it to be shown. This includes
	//! loading resources into memory.
	function onShow() {
	}

	//! Update the view
    function onUpdate(dc) {
    	var thisSport = mSport.getSport();
    	var string;
    	var hValue;

    	var topLeft = View.findDrawableById("topLeft");
		topLeft.setText(mSettings.sportData[thisSport][SPDAT_LABEL][0]);
		var topLeftData = View.findDrawableById("topLeftData");
		//get this value from activity monitoring functionality
		string = mSport.getData(mSettings.sportData[thisSport][SPDAT_DATA][0]);
		if ((thisSport == Record.SPORT_SWIMMING) || (thisSport == Record.SPORT_TRANSITION)){
			hValue = (dc.getWidth() / 2) + (dc.getTextWidthInPixels(string, Gfx.FONT_NUMBER_MEDIUM) / 2);
		}
		else {
			hValue = ((dc.getWidth() / 2) - BORDER_PADDING - TEXT_MARGIN);
		}
		topLeftData.setText(string);
		topLeftData.setLocation(hValue, (dc.getHeight() / 2 - dc.getTextDimensions(string, Gfx.FONT_NUMBER_MEDIUM)[1] - TEXT_MARGIN));

		var topRight = View.findDrawableById("topRight");
		topRight.setText(mSettings.sportData[thisSport][SPDAT_LABEL][1]);
		var topRightData = View.findDrawableById("topRightData");
		string = mSport.getData(mSettings.sportData[thisSport][SPDAT_DATA][1]);

		hValue = (dc.getWidth() - BORDER_PADDING - TEXT_MARGIN);
		topRightData.setText(string);
		topRightData.setLocation(hValue, (dc.getHeight() / 2 - dc.getTextDimensions(string, Gfx.FONT_NUMBER_MEDIUM)[1] - TEXT_MARGIN));

		var bottomLeft = View.findDrawableById("bottomLeft");
		bottomLeft.setText(mSettings.sportData[thisSport][SPDAT_LABEL][2]);
		var bottomLeftData = View.findDrawableById("bottomLeftData");
		string = mSport.getData(mSettings.sportData[thisSport][SPDAT_DATA][2]);
		if ((thisSport == Record.SPORT_SWIMMING) || (thisSport == Record.SPORT_TRANSITION)) { //replace with two/four view settings stuff
			hValue = (dc.getWidth() / 2) + (dc.getTextWidthInPixels(string, Gfx.FONT_NUMBER_MEDIUM) / 2);
		}
		else {
			hValue = ((dc.getWidth() / 2) - BORDER_PADDING - TEXT_MARGIN);
		}
		bottomLeftData.setText(string);
		bottomLeftData.setLocation(hValue, (dc.getHeight() - dc.getTextDimensions(string, Gfx.FONT_NUMBER_MEDIUM)[1] - TEXT_MARGIN));

		var bottomRight = View.findDrawableById("bottomRight");
		bottomRight.setText(mSettings.sportData[thisSport][SPDAT_LABEL][3]);
		var bottomRightData = View.findDrawableById("bottomRightData");
		string = mSport.getData(mSettings.sportData[thisSport][SPDAT_DATA][3]);
		hValue = (dc.getWidth() - BORDER_PADDING - TEXT_MARGIN);
		bottomRightData.setText(string);
		bottomRightData.setLocation(hValue, (dc.getHeight() - dc.getTextDimensions(string, Gfx.FONT_NUMBER_MEDIUM)[1] - TEXT_MARGIN));

		lineColor = mSettings.getLineColor(mSport.getSport());

    	View.onUpdate(dc);
		drawBorder.draw(dc);
		if (play) {
			dc.drawBitmap(dc.getWidth() / 2 - 25, dc.getHeight() / 2 - 24, drawPlay);
		}
		if (stop) {
			drawStop.draw(dc);
		}
    }

	function onHide() {
	}
}