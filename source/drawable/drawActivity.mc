using Toybox.System as Sys;
using Toybox.Graphics as Gfx;

class drawActivity {

	var width, height, borderWidth, borderHeight;

	function initialize() {
	}

	function drawBorder(dc, color) {

		height = dc.getHeight();
		borderWidth = dc.getWidth() - 4;
		borderHeight = dc.getHeight() - 4;

		//wrap in loop for transparency
		dc.setColor(color, Gfx.COLOR_TRANSPARENT);

		dc.setPenWidth(4);
		dc.drawLine(0, 2, dc.getWidth() - 2, 2);
		dc.drawLine(2, 0, 2, dc.getHeight() - 2);
		dc.drawLine(0, dc.getHeight() - 2, dc.getWidth(), dc.getHeight() - 2);
		dc.drawLine(dc.getWidth() - 2, 0, dc.getWidth() - 2, dc.getHeight());
	}

	function drawPlay(dc) {
		var x1 = dc.getWidth() / 2 + 28;
		var x2 = dc.getWidth() / 2 - 29;
		var y1 = dc.getHeight() / 2 + 1;
		var y2 = dc.getHeight() / 2 - 1;
		var y3 = dc.getHeight() / 2 - 30;
		var y4 = dc.getHeight() / 2 + 30;

		dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_TRANSPARENT);
		var pts1 = new [4];
		pts1[0] = [x1, y1];
		pts1[1] = [x1, y2];
		pts1[2] = [x2, y3];
		pts1[3] = [x2, y4];
		dc.fillPolygon(pts1);

		dc.setColor(Gfx.COLOR_DK_GREEN, Gfx.COLOR_TRANSPARENT);
		var pts2 = new [3];
		pts2[0] = [x1 - 5, dc.getHeight() / 2];
		pts2[1] = [x2 + 3, y3 + 5];
		pts2[2] = [x2 + 3, y4 - 5];
		dc.fillPolygon(pts2);
	}

	function drawStop(dc) {
		dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_TRANSPARENT);
		dc.fillRectangle(dc.getWidth() / 2 - 26, dc.getHeight() / 2 - 26, 52, 52);

		dc.setColor(Gfx.COLOR_DK_RED, Gfx.COLOR_TRANSPARENT);
		dc.fillRectangle(dc.getWidth() / 2 - 22, dc.getHeight() / 2 - 22, 44, 44);
	}
}