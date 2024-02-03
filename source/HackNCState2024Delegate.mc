import Toybox.Lang;
import Toybox.WatchUi;

class HackNCState2024Delegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onMenu() as Boolean {
        WatchUi.pushView(new Rez.Menus.MainMenu(), new HackNCState2024MenuDelegate(), WatchUi.SLIDE_UP);
        return true;
    }

}