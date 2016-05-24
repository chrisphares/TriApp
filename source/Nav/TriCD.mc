using Toybox.System as Sys;
using Toybox.WatchUi as Ui;

class CD extends Ui.ConfirmationDelegate {

	function initialize() {
		ConfirmationDelegate.initialize();
	}

    function onResponse(value) {
        if (value == 1) { //confirm
			Sys.exit();
		}
        return true;
    }
}