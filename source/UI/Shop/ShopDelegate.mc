import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class ShopDelegate extends WatchUi.MenuInputDelegate {

    function initialize() {
        MenuInputDelegate.initialize();
    }

    function onMenuItem(item as Symbol) as Void {
        var app = Application.getApp();
        //get latest money values
        app.updateSeedAndMoney();
        var i = 0;
        switch (item) {
            case :prestige:
                if (app.money < app.prestigePrice) {
                    return;
                }
                app.lastSteps = app.getCurrentSteps();
                app.currentPlant = "marigold";
                app.currentCategory = "wildflowers";
                app.stepsOnPlant = 0;
                app.money = 0;

                app.plantCountDict = {};
                app.categoriesUnlocked = [true, false, false];

                app.currentPlantModel = new SeedModel(app.currentPlant, Plictionary.plictionary[app.currentCategory][app.currentPlant]["stepsToCompletion"], app.stepsOnPlant);
                return;
            //don't have to do checks to see if we already bought things
            //cause if we did they wouldn't show up
            case :cat1:
                i = 0;
                break;
            case :cat2:
                i = 1;
                break;
            case :cat3:
                i = 2;
                break;
            case :cat4:
                i = 3;
                break;
            default:
                return;
        }
        if (app.money >= app.categoryUnlockPrice[i]) {
            app.categoriesUnlocked[i] = true;
            app.money -= app.categoryUnlockPrice[i];
            WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
            WatchUi.pushView(app.getShopMenu(), new ShopDelegate(), WatchUi.SLIDE_IMMEDIATE);
        }

    }

}