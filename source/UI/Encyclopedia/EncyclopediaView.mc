import Toybox.WatchUi;
import Toybox.Graphics;

class EncyclopediaView extends WatchUi.View {
    var firstTime = true;
    var encMenu;
    function initialize() {
        WatchUi.View.initialize();
        encMenu = new WatchUi.Menu();
        encMenu.setTitle("Encyclopedia");
        encMenu.addItem("Wildflowers", :wildflowers);
        encMenu.addItem("Cultivated Flowers", :flowers);
        encMenu.addItem("Ferns and Shrubs", :ferns_shrubs);
        encMenu.addItem("Agriculture", :crops);
        encMenu.addItem("Trees", :trees);
    }

    function onShow() {
        if (firstTime) {
            WatchUi.pushView(encMenu, new EncyclopediaDelegate(), WatchUi.SLIDE_IMMEDIATE);
            firstTime = false;
        }
        else {
            WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        }
    }
}