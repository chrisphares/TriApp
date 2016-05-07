using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;

class ThreeView extends Ui.View {

	hidden var mSport;
	hidden var mSettings;
	hidden var drawBorder;
	hidden var image;
	hidden var drawPlay;
	hidden var drawStop;
	const TEXT_MARGIN = 2;

	function initialize(sport, settings) {
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
		setLayout(Rez.Layouts.threeFields(dc));
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
    	var hValue;

    	var top_ = View.findDrawableById("top_");
		top_.setText(labels[0]);
		var top_Data = View.findDrawableById("top_Data");
		//get this value from the activity monitoring functionality
		string = "350"; //god damm lock nesss monstuh
		hValue = (dc.getWidth() / 2) + (dc.getTextWidthInPixels(string, Gfx.FONT_NUMBER_MEDIUM) / 2);
		top_Data.setText(string);
		top_Data.setLocation(hValue, (dc.getHeight() / 3 - dc.getTextDimensions(string, Gfx.FONT_NUMBER_MEDIUM)[1] - TEXT_MARGIN));

		var middle_ = View.findDrawableById("middle_");
		middle_.setText(labels[1]);
		var middle_Data = View.findDrawableById("middle_Data");
		//get this value from the activity monitoring functionality
		string = "140.3";
		hValue = (dc.getWidth() / 2) + (dc.getTextWidthInPixels(string, Gfx.FONT_NUMBER_MEDIUM) / 2);
		middle_Data.setText(string);
		middle_Data.setLocation(hValue, (dc.getHeight() / 3 * 2 - dc.getTextDimensions(string, Gfx.FONT_NUMBER_MEDIUM)[1] - TEXT_MARGIN));

		var bottom_ = View.findDrawableById("bottom_");
		bottom_.setText(labels[2]);
		var bottom_Data = View.findDrawableById("bottom_Data");
		//get this value from the activity monitoring functionality
		string = "00:00.0";
		hValue = (dc.getWidth() / 2) + (dc.getTextWidthInPixels(string, Gfx.FONT_NUMBER_MEDIUM) / 2);
		bottom_Data.setText(string);
		bottom_Data.setLocation(hValue, (dc.getHeight() - dc.getTextDimensions(string, Gfx.FONT_NUMBER_MEDIUM)[1] - TEXT_MARGIN));

		lineColor = getLineColor();

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

	function getLineColor() {
		var sport = mSport.getSport();
		var line = new [5];

		if (sport == SPORT_FINISH) {
			line[0] = Gfx.COLOR_WHITE;
			line[1] = Gfx.COLOR_WHITE;
		}

		return line;
	}
}