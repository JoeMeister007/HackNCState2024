import Toybox.WatchUi;
import Toybox.Graphics;
import Toybox.Math;
import Toybox.Attention;

class GrowtificationView extends WatchUi.View {

    function initialize() {
        WatchUi.View.initialize();
    }

    function onShow() {
        if (Attention has :vibrate) {
            //vibrate at 100% power for 1 second
            Attention.vibrate([new Attention.VibeProfile(100, 1000)]);
        }
    }

    function onUpdate(dc) {
        //clear the screen
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        dc.clear();

        var message = "Your plant has grown.\nTap/Select on it\nto grow another.";
        dc.drawText(dc.getWidth() / 2, dc.getHeight() / 2, Graphics.FONT_SMALL, message,Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
    }
}