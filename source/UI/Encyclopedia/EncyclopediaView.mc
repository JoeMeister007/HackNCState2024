import Toybox.WatchUi;
import Toybox.Graphics;

class EncyclopediaView extends WatchUi.View {
    function initialize() {
        WatchUi.View.initialize();
    }

    function onUpdate(dc) {
        //clear the screen
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        dc.clear();

        dc.drawText(dc.getWidth() / 2, dc.getHeight() / 2, Graphics.FONT_SMALL, "Encyclopedia",Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
    }
}