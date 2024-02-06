import Toybox.WatchUi;
import Toybox.Graphics;
import Toybox.Math;
import Toybox.Timer;

class SeedView extends WatchUi.View {
    var drawable;
    var lastPlantStage = 1;
    var lastPlantName = "jeff";
    var updateTimer;
    function initialize() {
        WatchUi.View.initialize();
        updateTimer = new Timer.Timer();
    }

    function callOnUpdate() {
        WatchUi.requestUpdate();
    }

    function onShow() {
        updateTimer.start(method(:callOnUpdate), 1000, true);
    }

    function onHide() {
        updateTimer.stop();
    }



    function onUpdate(dc) {
        //clear the screen
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        dc.clear();

        var plantModel = Application.getApp().currentPlantModel;
        //update steps
        Application.getApp().updateSeedAndMoney();

        if (plantModel.stage != lastPlantStage || plantModel.seedType != lastPlantName) {
            lastPlantStage = plantModel.stage;
            lastPlantName = plantModel.seedType;
            drawable = Application.loadResource(Plictionary.plictionary[Application.getApp().currentCategory][lastPlantName]["images"][lastPlantStage - 1]);
        }

        if (lastPlantStage == 5 && !Application.getApp().plantGrown) {
            WatchUi.pushView(new GrowtificationView(), new GrowtificationDelegate(), WatchUi.SLIDE_IMMEDIATE);
            Application.getApp().plantGrown = true;
        }

        //figure out percent complete to display
        var completionPct = 1.0 * plantModel.progress / plantModel.completionThreshold;
        if (completionPct > 1) {
            completionPct = 1;
        }
        completionPct *= 100;
        var completionString = "" + Math.floor(completionPct).toNumber() + "%";

        //draw plant
        dc.drawBitmap(dc.getWidth() / 2 - drawable.getWidth() / 2,dc.getHeight() / 2 - drawable.getHeight() / 2,drawable);
        //draw text
        dc.drawText(dc.getWidth() / 2, 10, Graphics.FONT_MEDIUM, "Growing",Graphics.TEXT_JUSTIFY_CENTER);
        dc.drawText(dc.getWidth() / 2, dc.getHeight() - 10 - dc.getFontHeight(Graphics.FONT_MEDIUM), Graphics.FONT_MEDIUM, completionString,Graphics.TEXT_JUSTIFY_CENTER);
    }
}