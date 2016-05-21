using Toybox.System as Sys;
using Toybox.WatchUi as Ui;

class CD extends Ui.ConfirmationDelegate {

	hidden var mSport;

	function initialize(sport) {
		mSport = sport;
		ConfirmationDelegate.initialize();
	}

    function onResponse(value) {
        if (value == 0) { //cancel
        }
        else { //confirm
			if (Toybox has :ActivityRecording) {
				if (mSport.session != null) {
					mSport.session.discard();
					Sys.exit();
				}
			}
		}
        return true;
    }
}