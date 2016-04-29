using Toybox.System as Sys;
using Toybox.WatchUi as Ui;

class CD extends Ui.ConfirmationDelegate {

	function initialize() {
		ConfirmationDelegate.initialize();
		Sys.println("made it in here");
	}

    function onResponse(value) {
        if (value == 0) {
        	Sys.println("nope out");
        }
        else {
        	Sys.println("confirm: ");
			//Sys.exit();
			//un-fuck this at some point
		}
        return true;
    }
}