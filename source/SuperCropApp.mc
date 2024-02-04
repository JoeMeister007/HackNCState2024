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
    var plantCountDict;
    var money;

    //currentPlantModel
    var currentPlantModel;
    //seed view thingy
    var plantGrown = false;

    //categories (in order of unlock)
    var categories = ["wildflowers", "crops", "trees"];
    var categoriesUnlocked;
    var categoryUnlockPrice = [0, 1000, 10000];
    var prestigePrice = 1000000;
    var catSymbols = [:cat1, :cat2, :cat3, :cat4, :cat5, :cat6, :cat7, :cat8, :cat9, :cat10];


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
                money = Properties.getValue("money");

                plantCountDict = Storage.getValue("plantCountDict");
                categoriesUnlocked = Storage.getValue("categoriesUnlocked");
            }
            else {
                lastSteps = getCurrentSteps();
                currentPlant = "marigold";
                currentCategory = "wildflowers";
                stepsOnPlant = 0;
                money = 0;
                Properties.setValue("firstTime", false);

                plantCountDict = {};
                categoriesUnlocked = [true, false, false];
            }

        } else{
            var firstTime = getProperty("firstTime");
            if (!firstTime) {
                lastSteps = getProperty("lastSteps");
                currentPlant = getProperty("currentPlant");
                currentCategory = getProperty("currentCategory");
                stepsOnPlant = getProperty("stepsOnPlant");
                money = getProperty("money");

                plantCountDict = getProperty("plantCountDict");
                categoriesUnlocked = getProperty("categoriesUnlocked");
            }
            else {
                lastSteps = ActivityMonitor.getInfo().steps;
                currentPlant = "marigold";
                currentCategory = "wildflowers";
                stepsOnPlant = 0;
                money = 0;
                setProperty("firstTime", false);

                plantCountDict = {};
                categoriesUnlocked = [true, false, false];
            }

        }

        // With the variables loaded, set the totals grown

        currentPlantModel = new SeedModel(currentPlant, Plictionary.plictionary[currentCategory][currentPlant]["stepsToCompletion"], stepsOnPlant);

    }

    function updateSeedAndMoney() {
        var currSteps = getCurrentSteps();
        var stepDiff = getStepDifference();

        if (stepDiff > 0) {
            //update steps
            lastSteps = currSteps;
            stepsOnPlant += stepDiff;
            currentPlantModel.onProgressUpdate(stepDiff);

            //update money
            //note: we won't care about plants that have technically grown, but haven't
            //been clicked on yet. The seed delegate can retroactively add the money for those
            for (var i = 0;i < plantCountDict.size(); i++) {
                //for each category
                var cat = plantCountDict.keys()[i];
                var categoryTalleys = plantCountDict[cat];
                for (var j = 0; j < categoryTalleys.size(); j++) {
                    var plnt = categoryTalleys.keys()[j];
                    //for each plant
                    money += categoryTalleys[plnt] * stepDiff * Plictionary.plictionary[cat][plnt]["moneyPerStep"];
                    //money is num plants * money per step for plant * steps
                }
            }
        }
        else if (stepDiff < 0) {
            //find something better than this, but hacky solution
            //for hacky competition for now
            lastSteps = 0;
            updateSeedAndMoney();      
        }
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
        //load in our properties
        if (Toybox.Application has :Properties){
            Properties.setValue("lastSteps", lastSteps);
            Properties.setValue("currentPlant", currentPlant);
            Properties.setValue("currentCategory", currentCategory);
            Properties.setValue("stepsOnPlant", stepsOnPlant);

            Storage.setValue("plantCountDict", plantCountDict);

        } else{
            setProperty("lastSteps", lastSteps);
            setProperty("currentPlant", currentPlant);
            setProperty("currentCategory", currentCategory);
            setProperty("stepsOnPlant", stepsOnPlant);

            setProperty("plantCountDict", plantCountDict);
        }
    }

    // Return the initial view of your application here
    function getInitialView() as Array<Views or InputDelegates>? {
        return [ new InitialView(), new BehaviorDelegate() ] as Array<Views or InputDelegates>;
    }

    function getShopMenu() {
        var shopMenu = new WatchUi.Menu();
        shopMenu.setTitle("Bal - " + money.format("%.2f"));
        var updated = false;
        for (var i = 0; i < categories.size(); i++) {
            if (categoriesUnlocked[i] != true) {
                updated = true;
                shopMenu.addItem("" +categoryUnlockPrice[i] + "-" + categories[i], catSymbols[i]);
                break;
            }
        }
        if (!updated) {
            shopMenu.addItem("" + prestigePrice + "- Prestige", :prestige);
        }
        return shopMenu;
    }

}

function getApp() as SuperCropApp {
    return Application.getApp() as SuperCropApp;
}