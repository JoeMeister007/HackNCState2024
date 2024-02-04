import Toybox.WatchUi;
import Toybox.Graphics;
import Toybox.Math;

class PlantInfoView extends WatchUi.View {
    var drawable;
    var category;
    var plantName;
    

    function initialize(cat, name) {
        WatchUi.View.initialize();
        category = cat;
        plantName = name;
        var plantImages = Plictionary.plictionary[category][plantName]["images"];
        drawable = Application.loadResource(plantImages[plantImages.size() - 1]);
    }

    function onUpdate(dc) {
        //clear the screen
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        dc.clear();

        //draw plant
        dc.drawBitmap(dc.getWidth() / 2 - drawable.getWidth() / 2,dc.getHeight() / 2 - drawable.getHeight() /2 - dc.getHeight() / 10, drawable);
        //draw text
        dc.drawText(dc.getWidth() / 2, 10, Graphics.FONT_MEDIUM, 
        Plictionary.plictionary[category][plantName]["displayName"],Graphics.TEXT_JUSTIFY_CENTER);
        dc.drawText(dc.getWidth() / 2, 
        dc.getHeight() - 2*(10 + dc.getFontHeight(Graphics.FONT_MEDIUM)), 
        Graphics.FONT_MEDIUM,
        Plictionary.plictionary[category][plantName]["funFact"],
        Graphics.TEXT_JUSTIFY_CENTER);
        WatchUi.requestUpdate();
    }
}