using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;

class BikeView extends Ui.View {

	hidden var mSport;
	hidden var drawBorder;
	hidden var image;
	hidden var drawPlay;
	hidden var drawStop;
	const TEXT_MARGIN = 2;
	const BORDER_PADDING = 4;

	function initialize(sport) {
		mSport = sport;
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
    	//labels = ["10s Power","30s Power","Heart Rate","Cadence"]; //get this from settings data
    	var string;
    	var hValue;

    	var topLeft = View.findDrawableById("topLeft");
		topLeft.setText(labels[0]);
		var topLeftData = View.findDrawableById("topLeftData");
		//get this value from activity monitoring functionality
		string = "220";
		hValue = ((dc.getWidth() / 2) - BORDER_PADDING - TEXT_MARGIN);
		topLeftData.setText(string);
		topLeftData.setLocation(hValue, (dc.getHeight() / 2 - dc.getTextDimensions(string, Gfx.FONT_NUMBER_MEDIUM)[1] - TEXT_MARGIN));

		var topRight = View.findDrawableById("topRight");
		topRight.setText(labels[1]);
		var topRightData = View.findDrawableById("topRightData");
		string = "223";
		hValue = (dc.getWidth() - BORDER_PADDING - TEXT_MARGIN);
		topRightData.setText(string);
		topRightData.setLocation(hValue, (dc.getHeight() / 2 - dc.getTextDimensions(string, Gfx.FONT_NUMBER_MEDIUM)[1] - TEXT_MARGIN));

		var bottomLeft = View.findDrawableById("bottomLeft");
		bottomLeft.setText(labels[2]);
		var bottomLeftData = View.findDrawableById("bottomLeftData");
		//get this value from activity monitoring functionality
		string = "155";
		hValue = ((dc.getWidth() / 2) - BORDER_PADDING - TEXT_MARGIN);
		bottomLeftData.setText(string);
		bottomLeftData.setLocation(hValue, (dc.getHeight() - dc.getTextDimensions(string, Gfx.FONT_NUMBER_MEDIUM)[1] - TEXT_MARGIN));

		var bottomRight = View.findDrawableById("bottomRight");
		bottomRight.setText(labels[3]);
		var bottomRightData = View.findDrawableById("bottomRightData");
		string = "92";
		hValue = (dc.getWidth() - BORDER_PADDING - TEXT_MARGIN);
		bottomRightData.setText(string);
		bottomRightData.setLocation(hValue, (dc.getHeight() - dc.getTextDimensions(string, Gfx.FONT_NUMBER_MEDIUM)[1] - TEXT_MARGIN));

		horizonLine = Gfx.COLOR_YELLOW;
		vertLine = Gfx.COLOR_YELLOW;

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