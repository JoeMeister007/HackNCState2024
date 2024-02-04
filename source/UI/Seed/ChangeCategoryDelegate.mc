import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class ChangeCategoryDelegate extends WatchUi.MenuInputDelegate {
    const MAX_NUMBER_SIZE = 2147483647;

    function initialize() {
        MenuInputDelegate.initialize();
    }

    function onMenuItem(item as Symbol) as Void {
        var app = Application.getApp();
        //get latest money values
        app.updateSeedAndMoney();
        var jeff = 0;
        switch (item) {
            case :cat1:
                jeff = 0;
                break;
            case :cat2:
                jeff = 1;
                break;
            case :cat3:
                jeff = 2;
                break;
            case :cat4:
                jeff = 3;
                break;
            default:
                return;
        }
        app.currentCategory = app.categories[jeff];

        //generate new plant
        var prob = 1.0 * Math.rand() / MAX_NUMBER_SIZE;
        var plantsOfCat = Plictionary.plictionary[app.currentCategory];
        //get keys and iterate through them
        var plantNames = plantsOfCat.keys();

        var chosenPlant = "";
        for (var i = 0; i < plantNames.size(); i++) {
            var plantProb = plantsOfCat[plantNames[i]]["probability"];
            if (prob <= plantProb) {
                chosenPlant = plantNames[i];
                break;
            }
            prob -= plantProb;
        }

        // //Remove stepsOnPlant for this plant (allow extra
        // //to remain though in case they've been gone a while)
        // app.stepsOnPlant -= app.currentPlantModel.completionThreshold;

        // //The now grown plant existed for the remaining app.StepsOnPlant so update the money
        // app.money += app.stepsOnPlant * Plictionary.plictionary[app.currentCategory][app.currentPlant]["moneyPerStep"];

        //update plant unless error
        if (chosenPlant != "") {
            app.currentPlant = chosenPlant;
        }
        app.plantGrown = false;
        //update plant model
        app.currentPlantModel = new SeedModel(app.currentPlant, Plictionary.plictionary[app.currentCategory][app.currentPlant]["stepsToCompletion"], app.stepsOnPlant);


    }

}