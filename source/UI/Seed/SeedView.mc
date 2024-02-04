import Toybox.WatchUi;
import Toybox.Graphics;
import Toybox.Math;

class SeedView extends WatchUi.View {
    var drawable;
    var lastPlantStage = 1;
    var lastPlantName = "jeff";
    function initialize() {
        WatchUi.View.initialize();
    }

    function onUpdate(dc) {
        //clear the screen
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        dc.clear();

        var plantModel = Application.getApp().currentPlantModel;
        //update steps
        var currSteps = Application.getApp().getCurrentSteps();
        var stepDiff = Application.getApp().getStepDifference();

        if (stepDiff > 0) {
            Application.getApp().lastSteps = currSteps;
            Application.getApp().stepsOnPlant += stepDiff;
            plantModel.onProgressUpdate(stepDiff);
        }
        else if (stepDiff < 0) {
            //find something better than this, but hacky solution
            //for hacky competition for now
            Application.getApp().lastSteps = 0;         
        }

        if (plantModel.stage != lastPlantStage || plantModel.seedType != lastPlantName) {
            lastPlantStage = plantModel.stage;
            lastPlantName = plantModel.seedType;
            drawable = Application.loadResource(Plictionary.plictionary[Application.getApp().currentCategory][lastPlantName]["images"][lastPlantStage - 1]);
        }

        if (lastPlantStage == 5 && !Application.getApp().plantGrown) {
            WatchUi.pushView(new GrowtificationView(), new GrowtificationDelegate(), WatchUi.SLIDE_IMMEDIATE);
            Application.getApp().plantGrown = true;
        }
        dc.drawBitmap(dc.getWidth() / 2 - drawable.getWidth() / 2,dc.getHeight() / 2 - drawable.getHeight() / 2,drawable);
        dc.drawText(dc.getWidth() / 2, 10, Graphics.FONT_SMALL, "Seed",Graphics.TEXT_JUSTIFY_CENTER);
        WatchUi.requestUpdate();
    }
}