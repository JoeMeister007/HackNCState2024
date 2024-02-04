import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class PlantListingDelegate extends WatchUi.MenuInputDelegate {

    var app;
    var cat;

    function initialize(category) {
        MenuInputDelegate.initialize();
        app = Application.getApp();
        cat = category;
    }

 function onMenuItem(item as Symbol) as Void {

        WatchUi.pushView(new PlantInfoView(cat, item), new WatchUi.BehaviorDelegate(), 
        WatchUi.SLIDE_IMMEDIATE);
    }

}