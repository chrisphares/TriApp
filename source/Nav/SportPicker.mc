using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;

class PickerChooser extends Ui.Picker {

	hidden var mSettings;

	function initialize(settings) {
		mSettings = settings;
		var title = new Ui.Text({:text=>"Change Order", :locX =>Ui.LAYOUT_HALIGN_CENTER, :locY=>Ui.LAYOUT_VALIGN_BOTTOM, :color=>Gfx.COLOR_WHITE});
		var factory = [	new SportFactory(getFactory(mSettings.sportOrder[0]), 1, mSettings),
						new SportFactory(getFactory(mSettings.sportOrder[1]), 2, mSettings),
						new SportFactory(getFactory(mSettings.sportOrder[2]), 3, mSettings),
						new SportFactory(getFactory(mSettings.sportOrder[3]), 4, mSettings),
						new SportFactory(getFactory(mSettings.sportOrder[4]), 5, mSettings)];
		Picker.initialize({:title=>title, :pattern=>factory});
	}

	function getFactory(activity) {
		var order = [5, 2, 1, 3];
		while (order[0] != activity) {
			var firstValue = order[0];
			for (var i = 0; i < order.size() - 1; i++) {
				order[i] = order[i + 1];
			}
			order[order.size() - 1] = firstValue;
		}

		return order;
	}

	function onUpdate(dc) {
		dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_BLACK);
		dc.clear();
		Picker.onUpdate(dc);
	}
}

class PickerChooserDelegate extends Ui.PickerDelegate {

	hidden var mSettings;

	function initialize(settings) {
		PickerDelegate.initialize();
		mSettings = settings;
	}

	function onCancel() {
		Ui.popView(Ui.SLIDE_IMMEDIATE);
	}

	function onAccept(values) {
		for (var i = 0; i < values.size(); i++) {
			if (values[i] != mSettings.sportOrder[i]) {
				mSettings.sportOrder[i] = values[i];
			}
		}
		Ui.popView(Ui.SLIDE_IMMEDIATE);
	}
}