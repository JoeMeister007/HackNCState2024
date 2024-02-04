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
                drawable = Application.loadResource(Rez.Drawables.Wildflower_Poppy_1);
                break;
            case 1:
                drawable = Application.loadResource(Rez.Drawables.Wildflower_Poppy_2);
                break;
            case 2:
                drawable = Application.loadResource(Rez.Drawables.Wildflower_Poppy_3);
                break;
            case 3:
                drawable = Application.loadResource(Rez.Drawables.Wildflower_Poppy_4);
                break;
            case 4:
                drawable = Application.loadResource(Rez.Drawables.Wildflower_Poppy_5);
                break;
            default:
                break;
        }
    }

    function onUpdate(dc) {
        //clear the screen
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        dc.clear();

        dc.drawBitmap(0,0,drawable);
        dc.drawText(dc.getWidth() / 2, 10, Graphics.FONT_SMALL, "Seed",Graphics.TEXT_JUSTIFY_CENTER);
    }
}