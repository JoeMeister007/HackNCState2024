import Toybox.WatchUi;
import Toybox.Graphics;
import Toybox.Math;

class SeedView extends WatchUi.View {
    var drawable;
    function initialize() {
        WatchUi.View.initialize();
        var jeff = Math.rand() % 5;
        switch (jeff) {
            case 0:
                drawable = Application.loadResource(Rez.Drawables.Wildflower_Phlox_1);
                break;
            case 1:
                drawable = Application.loadResource(Rez.Drawables.Wildflower_Phlox_2);
                break;
            case 2:
                drawable = Application.loadResource(Rez.Drawables.Wildflower_Phlox_3);
                break;
            case 3:
                drawable = Application.loadResource(Rez.Drawables.Wildflower_Phlox_4);
                break;
            case 4:
                drawable = Application.loadResource(Rez.Drawables.Wildflower_Phlox_5);
                break;
            default:
                break;
        }
    }

    function onUpdate(dc) {
        //clear the screen
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        dc.clear();
        dc.drawBitmap(dc.getWidth() / 2 - drawable.getWidth() / 2,dc.getHeight() / 2 - drawable.getHeight() / 2,drawable);
        dc.drawText(dc.getWidth() / 2, 10, Graphics.FONT_SMALL, "Seed",Graphics.TEXT_JUSTIFY_CENTER);
    }
}