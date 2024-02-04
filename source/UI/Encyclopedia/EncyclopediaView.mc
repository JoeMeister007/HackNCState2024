import Toybox.WatchUi;
import Toybox.Graphics;

class EncyclopediaView extends WatchUi.View {

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

    function onUpdate(dc) {
        WatchUi.pushView(encMenu, new EncyclopediaDelegate(), WatchUi.SLIDE_IMMEDIATE);
    }
}