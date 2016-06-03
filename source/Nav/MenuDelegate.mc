using Toybox.System as Sys;
using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.ActivityRecording as Record;

class TriMenuDelegate extends Ui.MenuInputDelegate {

	hidden var mSport;
	hidden var mSettings;

    function initialize(sport, settings) {
		mSport = sport;
		mSettings = settings;
        MenuInputDelegate.initialize();
    }

    function onMenuItem(item) {
		if (item == :order) {
            Ui.pushView(new PickerChooser(mSettings), new PickerChooserDelegate(mSettings), Ui.SLIDE_UP);
		}
        else if (item == :display) {
            Ui.pushView(new Rez.Menus.sportMenu(), new SportMenuDelegate(mSport, mSettings), Ui.SLIDE_IMMEDIATE);
		}
		return true;
    }
}
class SportMenuDelegate extends Ui.MenuInputDelegate {

	hidden var mSport;
	hidden var mSettings;

    function initialize(sport, settings) {
		mSport = sport;
		mSettings = settings;
        MenuInputDelegate.initialize();
    }

    function onMenuItem(item) {
		if (item == :swim) {
            Ui.pushView(new DisplayPickerView(mSport, mSettings, Record.SPORT_SWIMMING), new DisplayPickerInputDelegate(mSport, mSettings, Record.SPORT_SWIMMING), Ui.SLIDE_UP);
		}
        else if (item == :bike) {
            Ui.pushView(new DisplayPickerView(mSport, mSettings, Record.SPORT_CYCLING), new DisplayPickerInputDelegate(mSport, mSettings, Record.SPORT_CYCLING), Ui.SLIDE_UP);
		}
        else if (item == :run) {
            Ui.pushView(new DisplayPickerView(mSport, mSettings, Record.SPORT_RUNNING), new DisplayPickerInputDelegate(mSport, mSettings, Record.SPORT_RUNNING), Ui.SLIDE_UP);
		}
        else if (item == :transition) {
            Ui.pushView(new DisplayPickerView(mSport, mSettings, Record.SPORT_TRANSITION), new DisplayPickerInputDelegate(mSport, mSettings, Record.SPORT_TRANSITION), Ui.SLIDE_UP);
		}
		return true;
    }
}

class DisplayPickerInputDelegate extends Ui.InputDelegate {

 	hidden var mSport;
	hidden var mSettings;
	hidden var mThisSport;

	function initialize(sport, settings, thisSport) {
		InputDelegate.initialize();
		mSport = sport;
		mSettings = settings;
		mThisSport = thisSport;
	}

	function onTap(evt) {
		var clickEvent = evt.getType();
		if (clickEvent == CLICK_TYPE_TAP) {
			var quadrant = null;
			var coords = evt.getCoordinates();
			Sys.println(coords[0] + " : " + coords[1]);
			Sys.println(screenCenter[0] + " : " + screenCenter[1]);
			if ((coords[0] > screenCenter[0]) && (coords[1] > screenCenter[1])) {
				quadrant = 3;
			}
			else if ((coords[0] < screenCenter[0]) && (coords[1] > screenCenter[1])) {
				quadrant = 2;
			}
			else if ((coords[0] > screenCenter[0]) && (coords[1] < screenCenter[1])) {
				quadrant = 1;
			}
			else if ((coords[0] < screenCenter[0]) && (coords[1] < screenCenter[1])) {
				quadrant = 0;
			}

			nextAction(quadrant);
		}
	}

	function getSportMenu(quadrant) { //needs work
		var menu = new Ui.Menu();
		menu.addItem(mSport.getData(DATA_ELAPSED_TIME)[1], DATA_ELAPSED_TIME);
		menu.addItem(mSport.getData(DATA_LAP_TIME)[1], DATA_LAP_TIME);
		if (mThisSport == Record.SPORT_SWIMMING) {
			menu.addItem(mSport.getData(DATA_SWIM_DISTANCE)[1], DATA_SWIM_DISTANCE);
		}
		else if (mThisSport == Record.SPORT_CYCLING) {
			menu.addItem(mSport.getData(DATA_BIKE_CADENCE)[1], DATA_BIKE_CADENCE);
			menu.addItem(mSport.getData(DATA_10S_POWER)[1], DATA_10S_POWER);
			menu.addItem(mSport.getData(DATA_30S_POWER)[1], DATA_30S_POWER);
			menu.addItem(mSport.getData(DATA_HR)[1], DATA_HR);
		}
		else if (mThisSport == Record.SPORT_RUNNING) {
			menu.addItem(mSport.getData(DATA_RUN_CADENCE)[1], DATA_RUN_CADENCE);
			menu.addItem(mSport.getData(DATA_LAP_PACE)[1], DATA_LAP_PACE);
			menu.addItem(mSport.getData(DATA_HR)[1], DATA_HR);
		}
		if ((quadrant == 1) || (quadrant == 3)) {
			menu.addItem("Empty", DATA_NA);
		}
		menu.setTitle("Current: " + mSport.getData(mSettings.sportData[mThisSport][SPDAT_DATA][quadrant])[1]);
		return menu;
    }

	function nextAction(quadrant) {
		if (quadrant != null) {
			var nextMenu = getSportMenu(quadrant);
			var newField = [mThisSport, quadrant];
			Ui.pushView(nextMenu, new DataMenuDelegate(mSport, mSettings, newField), Ui.SLIDE_UP); //make better
		}
	}
}

class DataMenuDelegate extends Ui.MenuInputDelegate {

	hidden var mSport;
	hidden var mSettings;
	hidden var mNewField;

    function initialize(sport, settings, newField) {
		mSport = sport;
		mSettings = settings;
		mNewField = newField;
        MenuInputDelegate.initialize();
    }

    function onMenuItem(item) {
		var newData;
		for (var i = 0; i < 9; i++) {
			if (item == i) {
				newData = i;
				mSettings.sportData[mNewField[0]][SPDAT_DATA][mNewField[1]] = newData;
			}
		}
		return true;
    }
}