using Toybox.System as Sys;
using Toybox.WatchUi as Ui;

class TriInputDelegate extends Ui.InputDelegate {

	hidden var mSport;
	hidden var mSettings;

	function initialize(sport, settings) {
		InputDelegate.initialize();
		mSport = sport;
		mSettings = settings;
	}

	function onKey(evt) {
		var key = evt.getKey();

		if (key == KEY_ESC) {
    		Sys.exit;
		}
		else if (evt.getKey() == Ui.KEY_ENTER) {
			mSport.startRecord(mSettings.sportOrder[0]);
			Ui.switchToView(new FourView(mSport, mSettings), new SportInputDelegate(mSport, mSettings), Ui.SLIDE_IMMEDIATE);
		}
		else if (evt.getKey() == Ui.KEY_MENU) {
			Ui.pushView(new Rez.Menus.mainMenu(), new TriMenuDelegate(mSport, mSettings), Ui.SLIDE_IMMEDIATE);
		}
	}

	function onHold(evt) {
		Ui.pushView(new Rez.Menus.mainMenu(), new TriMenuDelegate(mSport, mSettings), Ui.SLIDE_IMMEDIATE);
	}
}