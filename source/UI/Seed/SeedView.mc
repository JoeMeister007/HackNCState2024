import Toybox.WatchUi;
import Toybox.Graphics;
import Toybox.Math;

class SeedView extends WatchUi.View {
    var drawable;
    var lastPlantStage = -1;
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

        if (plantModel.stage != lastPlantStage) {
            switch (plantModel.stage) {
                case 1:
                    drawable = Application.loadResource(Rez.Drawables.Wildflower_Phlox_1);
                    break;
                case 2:
                    drawable = Application.loadResource(Rez.Drawables.Wildflower_Phlox_2);
                    break;
                case 3:
                    drawable = Application.loadResource(Rez.Drawables.Wildflower_Phlox_3);
                    break;
                case 4:
                    drawable = Application.loadResource(Rez.Drawables.Wildflower_Phlox_4);
                    break;
                case 5:
                    drawable = Application.loadResource(Rez.Drawables.Wildflower_Phlox_5);
                    break;
                default:
                    break;
            }
        }
        dc.drawBitmap(dc.getWidth() / 2 - drawable.getWidth() / 2,dc.getHeight() / 2 - drawable.getHeight() / 2,drawable);
        dc.drawText(dc.getWidth() / 2, 10, Graphics.FONT_SMALL, "Seed",Graphics.TEXT_JUSTIFY_CENTER);
        WatchUi.requestUpdate();
    }
}