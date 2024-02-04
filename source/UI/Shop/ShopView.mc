import Toybox.WatchUi;
import Toybox.Graphics;

class ShopView extends WatchUi.View {
    function initialize() {
        WatchUi.View.initialize();
    }

    function onShow() {
    }

    function onUpdate(dc) {
        //clear the screen
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        dc.clear();

        Application.getApp().updateSeedAndMoney();


        dc.drawText(dc.getWidth() / 2, dc.getHeight() / 2, Graphics.FONT_SMALL, "Shop\n" + Application.getApp().money.format("%.2f"),Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);

        WatchUi.requestUpdate();
    }
}