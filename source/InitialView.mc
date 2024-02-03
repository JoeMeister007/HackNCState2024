import Toybox.WatchUi;

/*
All this view does is push the main menu the first time it is
shown and if shown again (i.e. someone pressed back from 
the main menu) pops the view, exiting the app. Some watches 
don't support having the main menu as the initial view so this 
is why we're doing this. If we add a background service we may 
remove all of those watches anyways, but might as well include it
for now.
*/
class InitialView extends WatchUi.View {
    var firstLoad = true;
    var mainMenu;
    function initialize() {
        WatchUi.View.initialize();
        mainMenu = new WatchUi.Menu();
        mainMenu.setTitle("Menu");
        mainMenu.addItem("Current Seed", :seed);
        mainMenu.addItem("Encyclopedia", :encyclopedia);
        mainMenu.addItem("Shop", :shop);
        mainMenu.addItem("Stats", :stats);
    }

    function onShow() {
        if (firstLoad == true) {
            firstLoad = false;
            WatchUi.pushView(mainMenu, new MainMenuDelegate(), WatchUi.SLIDE_IMMEDIATE);
        }
        else {
            WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        }
    }
}