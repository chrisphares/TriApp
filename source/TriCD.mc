using Toybox.System as Sys;
using Toybox.WatchUi as Ui;

class CD extends Ui.ConfirmationDelegate {

	hidden var mSport;

	function initialize(sport) {
		ConfirmationDelegate.initialize();
		mSport = sport;
	}

    function onResponse(value) {
        if (value == 1) { //confirm
			if (Toybox has :ActivityRecording) {
				if (mSport.session != null) {
					Sys.exit();
				}
			}
		}
        return true;
    }
}