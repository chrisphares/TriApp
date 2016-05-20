using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;

class TriMenuDelegate extends Ui.MenuInputDelegate {

	hidden var mSport;
	hidden var mSettings;
	hidden var mSportPicker;

    function initialize(sport, settings, sportPicker) {
		mSport = sport;
		mSettings = settings;
		mSportPicker = sportPicker;
        MenuInputDelegate.initialize();
    }

    function onMenuItem(item) {
		if (item == :order) {
            Ui.pushView(new Rez.Menus.orderMenu(), new TriMenuDelegate(mSport, mSettings), Ui.SLIDE_UP);
		}
        else if (item == :second) {
            Ui.pushView(new Rez.Menus.secondMenu(), new TriMenuDelegate(mSport, mSettings), Ui.SLIDE_UP);
            Sys.println("second");
		}
        else if (item == :one) {
            Sys.println("one");
            Ui.popView(Ui.SLIDE_IMMEDIATE);
		}
        else if (item == :two) {
            Sys.println("two");
            Ui.popView(Ui.SLIDE_IMMEDIATE);
		}
        else if (item == :firstSport) {
        	mSportPicker = 0;
        	var sportMenu = getSportMenu(mSettings.sportOrder[0]);
            Ui.pushView(sportMenu, new TriMenuDelegate(mSport, mSettings, mSportPicker), Ui.SLIDE_UP);
		}
        else {
			for (var i = 0; i < mSettings.sportData.size(); i++) {
				if (i == item) {
					mSettings.sportOrder[mSportPicker] = i; //change to object.setvalue thingy
				}
			}
		}

		return true;
    }

    function getSportMenu(sport) {
		var menu = new Ui.Menu();
		menu.setTitle("Current: " + mSettings.sportData[sport][SPDAT_ABBR][1]);
		for (var i = 0; i < mSettings.sportData.size(); i++) {
			if (mSettings.sportData[i] != null) {
				var sportName = mSettings.sportData[i][SPDAT_ABBR][1];
				menu.addItem(sportName, i);
			}
		}
		return menu;
    }
}