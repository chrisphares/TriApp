using Toybox.WatchUi as Ui;
using Toybox.System as Sys;
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
            Ui.pushView(new SportPickerView(mSport, mSettings), new SportPickerInputDelegate(mSport, mSettings, NEXT_SPORT), Ui.SLIDE_UP);
		}
        else if (item == :display) {
            Ui.pushView(new SportPickerView(mSport, mSettings), new SportPickerInputDelegate(mSport, mSettings, NEXT_DATA), Ui.SLIDE_UP);
		}
		return true;
    }
}

class SportPickerInputDelegate extends Ui.InputDelegate {

 	hidden var mSport;
	hidden var mSettings;
	hidden var mNextAction;

	function initialize(sport, settings, nextAction) {
		InputDelegate.initialize();
		mSport = sport;
		mSettings = settings;
		mNextAction = nextAction;
	}

	function onTap(evt) {
		var clickEvent = evt.getType();
		if (clickEvent == CLICK_TYPE_TAP) {
			var coords = evt.getCoordinates();
			var sportPicker = null;
			if ((coords[0] > 71) && (coords[0] < 141) && (coords[1] > 99)) {
	        	sportPicker = 4;
			}
			else if ((coords[0] < 70) && (coords[1] > 99)) {
	        	sportPicker = 3;
			}
			else if ((coords[0] > 142) && (coords[1] > 33) && (coords[1] < 98)) {
	        	sportPicker = 2;
			}
			else if ((coords[0] > 71)  && (coords[0] < 141) && (coords[1] > 33)) {
	        	sportPicker = 1;
			}
			else if ((coords[0] < 70) && (coords[1] > 33)) {
				sportPicker = 0;
			}

			nextAction(sportPicker);
		}
	}

    function getSportMenu(sport) {
		var menu = new Ui.Menu();
		menu.setTitle("Current: " + mSettings.sportData[sport][SPDAT_INFO][1]);
		for (var i = 0; i < mSettings.sportData.size(); i++) {
			if (mSettings.sportData[i] != null) {
				var sportName = mSettings.sportData[i][SPDAT_INFO][1];
				menu.addItem(sportName, i);
			}
		}
		return menu;
    }

    function nextAction(sport) {
		if (sport != null) {
			if (mNextAction == NEXT_SPORT) {
				var nextMenu;
				nextMenu = getSportMenu(mSettings.sportOrder[sport]);
				Ui.pushView(nextMenu, new OrderMenuDelegate(mSport, mSettings, sport), Ui.SLIDE_UP);
			}
			else if (mNextAction == NEXT_DATA) {
				var thisSport = mSettings.sportOrder[sport];
				Ui.pushView(new DisplayPickerView(mSport, mSettings, thisSport), new DisplayPickerInputDelegate(mSport, mSettings, thisSport), Ui.SLIDE_UP);
			}
		}
		return true;
	}
}

class OrderMenuDelegate extends Ui.MenuInputDelegate {

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
		if (mSportPicker != null) {
			for (var i = 0; i < mSettings.sportData.size(); i++) {
				if (i == item) {
					mSettings.sportOrder[mSportPicker] = i; //change to object.setvalue thingy
					mSportPicker = null;
				}
			}
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
			if ((coords[0] > 103) && (coords[1] > 75)) {
				quadrant = 3;
			}
			else if ((coords[0] < 102) && (coords[1] > 75)) {
				quadrant = 2;
			}
			else if ((coords[0] > 103) && (coords[1] < 74)) {
				quadrant = 1;
			}
			else if ((coords[0] < 102) && (coords[1] < 74)) {
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