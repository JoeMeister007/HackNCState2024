import Toybox.WatchUi;
import Toybox.Graphics;

class PlantListingView extends WatchUi.View {

    var plvMenu;
    var cat;
    var firstTime = true;
    var app = Application.getApp();


    function initialize(title, category) {
        WatchUi.View.initialize();
        plvMenu = new WatchUi.Menu();
        plvMenu.setTitle(title);
        cat = category;

        var plantsOfCat = Plictionary.plictionary[category];
        //get keys and iterate through them
        var plantNames = plantsOfCat.keys();

        for (var i = 0; i < plantNames.size(); i++) {


            if (app.plantCountDict != null and
                app.plantCountDict[category] != null and
                app.plantCountDict[category][plantNames[i]] != null and 
                app.plantCountDict[category][plantNames[i]] > 0) 
            {
                plvMenu.addItem(plantsOfCat[plantNames[i]]["displayName"], plantNames[i]);
            }
        }
    }

    function onShow() {
        if (firstTime) {
            WatchUi.pushView(plvMenu, new PlantListingDelegate(cat), WatchUi.SLIDE_IMMEDIATE);
            firstTime = false;
        }
        else {
            WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        }
    }
}