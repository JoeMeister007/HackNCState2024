import Toybox.Math;

/*
    Represents a Seed the user is currently growing.

*/
class SeedModel {

    public var seedType;               // The seed's type, represented by a string of all lowercase letters.
    public var progress;                // An integer representing the progress the plant has made through its life cycle.
    public var completionThreshold;     // An integer representing the total amount of time until the plant is fully grown.
    public var stage;                   // An integer between 1 and 5 representing the plant's stage of life.

    public function initialize(species, threshold, progress) {
        self.seedType = species;
        self.completionThreshold = threshold;
        self.progress = progress;
        self.stage = 1;
    }

    public function onProgressUpdate(addedProgress) {
        
        // Update progress counter
        self.progress += addedProgress;

        //Let's go over so we know how much to give the next one
        // // In case progress exceeds the completion threshold, no it doesn't
        // if (self.completionThreshold <= self.progress) {
        //     self.progress = self.completionThreshold;
        // }

        // Update the current stage based off of current progress.
        self.stage = 1 + Math.floor( 4 * self.progress / self.completionThreshold);
        if (self.stage > 5) {
            self.stage = 5;
        }
    }

}