using Toybox.Graphics as Gfx;
using Toybox.WatchUi as Ui;
using Toybox.System as Sys;

class rectangle extends Ui.Drawable {

    hidden var mActivity;
    hidden var mSettings;
    hidden var mOrder;
    hidden var color;
    hidden var text;

    function initialize(activity, order, settings) {
        Drawable.initialize({});
        mActivity = activity;
        mSettings = settings;
        mOrder = order;
    }

    function draw(dc) {
        color = mSettings.sportData[mActivity][SPDAT_INFO][2];
        dc.setColor(color, color);
        dc.setPenWidth(2);

        text = mSettings.sportData[mActivity][SPDAT_INFO][0];

        if (dc.getHeight() > dc.getWidth()) {
        	dc.drawLine(4, dc.getHeight() / 2, dc.getWidth() - 4, dc.getHeight() / 2);
        	dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_BLACK);
        	dc.drawText(dc.getWidth() / 2, dc.getHeight() / 2 - dc.getTextDimensions(mOrder.toString(), Gfx.FONT_TINY)[1] - 3, Gfx.FONT_TINY, mOrder.toString(), Gfx.TEXT_JUSTIFY_CENTER);
        	dc.drawText(dc.getWidth() / 2, dc.getHeight() / 2, Gfx.FONT_TINY, text, Gfx.TEXT_JUSTIFY_CENTER);
        }
        else {
        	dc.drawLine(6, 6, dc.getWidth() - 6, 6);
        	dc.drawLine(6, dc.getHeight() - 6, dc.getWidth() - 6, dc.getHeight() - 6);
        	dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_BLACK);
        	text = mOrder.toString() + ": " + text;
        	dc.drawText(5, dc.getHeight() / 2 - (dc.getTextDimensions(text, Gfx.FONT_TINY)[1] / 2), Gfx.FONT_TINY, text, Gfx.TEXT_JUSTIFY_LEFT);
        }
    }
}