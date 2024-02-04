import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class MainMenuDelegate extends WatchUi.MenuInputDelegate {

    function initialize() {
        MenuInputDelegate.initialize();
    }

    function onMenuItem(item as Symbol) as Void {
        var app = Application.getApp();
        switch (item) {
            case :cat1:
                break;
            case :cat2:
                WatchUi.pushView(new EncyclopediaView(), new WatchUi.BehaviorDelegate(), WatchUi.SLIDE_IMMEDIATE);
                break;
            case :cat3:
                WatchUi.pushView(Application.getApp().getShopMenu(), new WatchUi.BehaviorDelegate(), WatchUi.SLIDE_IMMEDIATE);
                break;
            case :cat4:
                WatchUi.pushView(new StatsView(), new WatchUi.BehaviorDelegate(), WatchUi.SLIDE_IMMEDIATE);
                break;
            default:
                WatchUi.pushView(new WatchUi.View(), new WatchUi.BehaviorDelegate(), WatchUi.SLIDE_IMMEDIATE);
                break;
        }

    }

}