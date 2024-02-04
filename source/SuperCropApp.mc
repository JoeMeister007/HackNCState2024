import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.ActivityMonitor;

class SuperCropApp extends Application.AppBase {
    //properties as variables
    var lastSteps;
    var currentPlant;
    var currentCategory;
    var stepsOnPlant;
    //currentPlantModel
    var currentPlantModel;
    //seed view thingy
    var plantGrown = false;

    function initialize() {
        AppBase.initialize();
    }

    //gets the current steps
    //should only be called once per code block
    //to avoid changing values (although the code will
    //hopefully be fast enough for that to not be an issue)
    function getCurrentSteps() {
        return ActivityMonitor.getInfo().steps;
    }

    //Gets the difference in steps between the current steps
    //and the last steps
    //doesn't work if there have been multiple days in betweem
    function getStepDifference() {
        var currSteps = getCurrentSteps();
        var diff = 0;
        //weird edge case of midnight and such
        //burn that bridge once we get there
        if (currSteps < lastSteps) {
            //figure out some shenanigans here
            var yesterday = ActivityMonitor.getHistory();
            System.println(yesterday);
            System.println(yesterday[1]);
            diff = -1;
        }
        else {
            diff = currSteps - lastSteps;
        }
        return diff;
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
        //load in our properties
        if (Toybox.Application has :Properties){
            var firstTime = Properties.getValue("firstTime");
            if (!firstTime) {
                lastSteps = Properties.getValue("lastSteps");
                currentPlant = Properties.getValue("currentPlant");
                currentCategory = Properties.getValue("currentCategory");
                stepsOnPlant = Properties.getValue("stepsOnPlant");
            }
            else {
                lastSteps = getCurrentSteps();
                currentPlant = "marigold";
                currentCategory = "wildflowers";
                stepsOnPlant = 0;
                Properties.setValue("firstTime", false);
            }

        } else{
            var firstTime = getProperty("firstTime");
            if (!firstTime) {
                lastSteps = getProperty("lastSteps");
                currentPlant = getProperty("currentPlant");
                currentCategory = getProperty("currentCategory");
                stepsOnPlant = getProperty("stepsOnPlant");
            }
            else {
                lastSteps = ActivityMonitor.getInfo().steps;
                currentPlant = "marigold";
                currentCategory = "wildflowers";
                stepsOnPlant = 0;
                setProperty("firstTime", false);
            }

        }

        currentPlantModel = new SeedModel(currentPlant, Plictionary.plictionary[currentCategory][currentPlant]["stepsToCompletion"], stepsOnPlant);

    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
        //load in our properties
        if (Toybox.Application has :Properties){
            Properties.setValue("lastSteps", lastSteps);
            Properties.setValue("currentPlant", currentPlant);
            Properties.setValue("currentCategory", currentCategory);
            Properties.setValue("stepsOnPlant", stepsOnPlant);
<<<<<<< Updated upstream
=======
            Properties.setValue("money", money);


            Storage.setValue("plantCountDict", plantCountDict);
            Storage.setValue("categoriesUnlocked", categoriesUnlocked);

>>>>>>> Stashed changes
        } else{
            setProperty("lastSteps", lastSteps);
            setProperty("currentPlant", currentPlant);
            setProperty("currentCategory", currentCategory);
            setProperty("stepsOnPlant", stepsOnPlant);
        }
    }

    // Return the initial view of your application here
    function getInitialView() as Array<Views or InputDelegates>? {
        return [ new InitialView(), new BehaviorDelegate() ] as Array<Views or InputDelegates>;
    }

}

function getApp() as SuperCropApp {
    return Application.getApp() as SuperCropApp;
}