# PSOBB Meseta Count
This is a simple addon for https://github.com/HybridEidolon/psobbaddonplugin. It displays the Meseta you're currently carrying along with an option to set a goal amount. The count will display in red, orange, or yellow depending on how close you are to your goal.

### Installation
1. Install the [addon plugin](https://github.com/HybridEidolon/psobbaddonplugin) for PSOBB.
2. Download this repository by clicking [**here**](https://github.com/SethClydesdale/psobb-meseta-count/archive/master.zip).
3. Drag and drop the **Meseta Count** addon into the /addons directory in your PSOBB folder.

### Preview
[![](https://i11.servimg.com/u/f11/18/21/41/30/pso13118.jpg)](https://i11.servimg.com/u/f11/18/21/41/30/pso13118.jpg)

### Change Log

#### v1.2.0
- Added High Contrast Color option to configuration. You can choose to enable this option when "Colorize Text" is disabled.
- Added digit grouping configuration option to make reading the Meseta value easier. (100000 --> 100,000 when enabled)
- Added Meseta label and label position configuration options. This'll let you change the display from "N Meseta" to "Meseta: N" or "$N" and so on.
- Added position and size options to configuration.
- Added height and width options for the progress bar.
- Added progress bar to placeholder.
- Added tooltip to Meseta count and progress bar. The tooltip will show your CURRENT_MESETA/GOAL_MESETA.
- Fixed window width and height not being maintained.

#### v1.1.2
- Fixed not being able to resize the window.

#### v1.1.1
- Fixed incorrect Meseta value displaying when the player was the 2nd, 3rd, etc.. player in the lobby. (thanks to soly and staphen for helping me find the correct index)

#### v1.1.0
- Added Meseta Goal progress bar to help visualize how close you are to your goal. The bar will turn green when you've hit your goal.
- Added Colorize Text so the user can choose between the standard white text or colored text.
- Fixed initial window height and width.
- Increased initial Meseta goal from 1,000 to 100,000.