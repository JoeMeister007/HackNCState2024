import Toybox.Graphics;
import Toybox.WatchUi;

class Page2 extends WatchUi.View {
    var kermitBitMap;
    function initialize() {
        View.initialize();
        kermitBitMap = Application.loadResource(Rez.Drawables.KermitImage);
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        dc.clear();
        dc.drawBitmap(0,0, kermitBitMap);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

}
