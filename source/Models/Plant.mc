import Toybox.Math;

/*
    Represents a Seed the user is currently growing.

*/
class SeedModel {

    public var seedType;               // The seed's type, represented by a string of all lowercase letters.
    public var progress;                // An integer representing the progress the plant has made through its life cycle.
    public var completionThreshold;     // An integer representing the total amount of time until the plant is fully grown.
    public var stage;                   // An integer between 1 and 5 representing the plant's stage of life.
    public var currentFilename;         // A string generated from self.seedType and self.stage that corresponds to the filename of the plant at the given stage.

    public function initialize(species, threshold) {
        self.seedType = species;
        self.completionThreshold = threshold;
        self.progress = 0;
        self.stage = 1;
        self.currentFilename = self.seedType + "_" + self.stage + ".png";
    }

    public function onProgressUpdate(addedProgress) {
        
        // Update progress counter
        self.progress += addedProgress;

        // In case progress exceeds the completion threshold, no it doesn't
        if (self.completionThreshold <= self.progress) {
            self.progress = self.completionThreshold;
        }

        // Update the current stage based off of current progress.
        self.stage = 5 * Math.floor(self.progress / self.completionThreshold);

        self.currentFilename = self.seedType + "_" + self.stage + ".png";
    }

}