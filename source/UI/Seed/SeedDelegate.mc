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
        //if the plant isn't grown, macht nichts
        if (!Application.getApp().plantGrown) {
            return true;
        }

        //eventually do some encyclopedia stuff
        
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

        //reset stepsOnPlant
        app.stepsOnPlant = 0;
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