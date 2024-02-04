import Toybox.WatchUi;
import Toybox.Math;

//Delegate that goes to next plant if the current plant is done
class SeedDelegate extends WatchUi.BehaviorDelegate {
    const MAX_NUMBER_SIZE = 2147483647;
    function initialize() {
        WatchUi.BehaviorDelegate.initialize();
    }

    function onSelect() {
        var app = Application.getApp();
        //if the plant isn't grown show the change category menu
        if (!Application.getApp().plantGrown) {
            WatchUi.pushView(app.getCurrentCategoryMenu(), new ChangeCategoryDelegate(), WatchUi.SLIDE_IMMEDIATE);
            return true;
        }

        //eventually do some encyclopedia stuff

        // Increment the corresponding plant stat with a cursed switch statement
        if (!app.plantCountDict.hasKey(app.currentCategory)) {
            app.plantCountDict.put(app.currentCategory, {});
        }
        if (!app.plantCountDict[app.currentCategory].hasKey(app.currentPlant)) {
            app.plantCountDict[app.currentCategory].put(app.currentPlant, 0);
        }
        app.plantCountDict[app.currentCategory][app.currentPlant] += 1;
        
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

        //Remove stepsOnPlant for this plant (allow extra
        //to remain though in case they've been gone a while)
        app.stepsOnPlant -= app.currentPlantModel.completionThreshold;

        //The now grown plant existed for the remaining app.StepsOnPlant so update the money
        app.money += app.stepsOnPlant * Plictionary.plictionary[app.currentCategory][app.currentPlant]["moneyPerStep"];

        //update plant unless error
        if (chosenPlant != "") {
            app.currentPlant = chosenPlant;
        }
        app.plantGrown = false;
        //update plant model
        app.currentPlantModel = new SeedModel(app.currentPlant, Plictionary.plictionary[app.currentCategory][app.currentPlant]["stepsToCompletion"], app.stepsOnPlant);


        return true;
    }
}