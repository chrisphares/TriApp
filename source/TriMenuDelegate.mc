using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;

class TriMenuDelegate extends Ui.MenuInputDelegate {

    function initialize() {
        MenuInputDelegate.initialize();
    }

    function onMenuItem(item) {
		if (item == :restart) { // restart for testing purposes
            aSport.setSport(SPORT_SWIM);
            aSport.setState(ACTIVITY_STOP);
		}
        else if (item == :second) {
            Ui.pushView(new Rez.Menus.secondMenu(), new TriMenuDelegate(), Ui.SLIDE_UP);
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
		return true;
    }

}