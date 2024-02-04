import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class MainMenuDelegate extends WatchUi.MenuInputDelegate {

    function initialize() {
        MenuInputDelegate.initialize();
    }

    function onMenuItem(item as Symbol) as Void {
        switch (item) {
            case :seed:
                WatchUi.pushView(new SeedView(), new SeedDelegate(), WatchUi.SLIDE_IMMEDIATE);
                break;
            case :encyclopedia:
                WatchUi.pushView(new EncyclopediaView(), new WatchUi.BehaviorDelegate(), WatchUi.SLIDE_IMMEDIATE);
                break;
            case :shop:
                WatchUi.pushView(Application.getApp().getShopMenu(), new ShopDelegate(), WatchUi.SLIDE_IMMEDIATE);
                break;
            case :stats:
                WatchUi.pushView(new StatsView(), new WatchUi.BehaviorDelegate(), WatchUi.SLIDE_IMMEDIATE);
                break;
            default:
                WatchUi.pushView(new WatchUi.View(), new WatchUi.BehaviorDelegate(), WatchUi.SLIDE_IMMEDIATE);
                break;
        }

    }

}