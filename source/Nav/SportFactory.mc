using Toybox.Graphics as Gfx;
using Toybox.WatchUi as Ui;
using Toybox.System as Sys;

class SportFactory extends Ui.PickerFactory {
    hidden var mActivity;
    hidden var mSettings;
    hidden var mOrder;

    function initialize(activity, order, settings) {
        mActivity = activity;
		mSettings = settings;
		mOrder = order;
    }

    function getIndex(value) {
		for(var i = 0; i < mActivity.size(); ++i) {
			if(mActivity[i].equals(value)) {
				return i;
				}
			}
        return 0;
    }

    function getSize() {
        return mActivity.size();
    }

    function getValue(index) {
        return mActivity[index];
    }

    function getDrawable(index, selected) {
        return new rectangle(mActivity[index], mOrder, mSettings);
    }
}
