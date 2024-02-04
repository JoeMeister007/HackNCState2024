import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class EncyclopediaDelegate extends WatchUi.MenuInputDelegate {

    // var app;

    function initialize() {
        MenuInputDelegate.initialize();
        // app = Application.getApp();
    }

    function onMenuItem(item as Symbol) as Void {
        switch (item) {
            case :wildflowers:
                WatchUi.pushView(new PlantListingView("Wildflowers", "wildflowers"), new PlantListingDelegate("wildflowers"), 
                WatchUi.SLIDE_IMMEDIATE);
                break;
            case :flowers:
                WatchUi.pushView(new PlantListingView("Cultivated Flowers", "flowers"), new PlantListingDelegate("wildflowers"), 
                WatchUi.SLIDE_IMMEDIATE);
                break;
            case :ferns_shrubs:
                WatchUi.pushView(new PlantListingView("Ferns and Shrubs", "ferns_shrubs"), new PlantListingDelegate("ferns_shrubs"), 
                WatchUi.SLIDE_IMMEDIATE);
                break;
            case :crops:
                WatchUi.pushView(new PlantListingView("Agriculture", "crops"), new PlantListingDelegate("crops"), 
                WatchUi.SLIDE_IMMEDIATE);
                break;
            case :trees:
                WatchUi.pushView(new PlantListingView("Trees", "trees"), new PlantListingDelegate("trees"),
                WatchUi.SLIDE_IMMEDIATE);
                break;
            default:
                WatchUi.pushView(new WatchUi.View(), new WatchUi.BehaviorDelegate(), 
                WatchUi.SLIDE_IMMEDIATE);
                break;
        }

    }

}