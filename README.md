# PSOBB Meseta Count
This addon displays the Meseta you're currently carrying along with an option to set a goal amount.

### Installation
1. Install the [addon plugin](https://github.com/HybridEidolon/psobbaddonplugin) for PSOBB.
2. Download this repository by clicking [**here**](https://github.com/SethClydesdale/psobb-meseta-count/archive/master.zip).
3. Drag and drop the **Meseta Count** addon into the /addons directory in your PSOBB folder.

### Preview
#### Basic display and configuration
[![](https://i11.servimg.com/u/f11/18/21/41/30/pso13122.jpg)](https://i11.servimg.com/u/f11/18/21/41/30/pso13122.jpg)

#### Gaining and Losing Meseta
When you gain or lose Meseta it'll be shown next to the Meseta count. This display can be toggled on or off with the **Show Gains and Losses** config option. It is enabled by default.

[![](https://i11.servimg.com/u/f11/18/21/41/30/56uhyf10.gif)](https://i11.servimg.com/u/f11/18/21/41/30/56uhyf10.gif) (default animation)

[![](https://i11.servimg.com/u/f11/18/21/41/30/rtchg410.gif)](https://i11.servimg.com/u/f11/18/21/41/30/rtchg410.gif) (optional slide animation)

### Extra Notes

#### Meseta Icon
The closest ASCII character that I found which almost looks like a Diamond (or Meseta) is ALT+7 : "`•`", the bullet character. You can use this character as an alternative to the dollar sign in the Meseta Label configuration option, if you want something that closely resembles Meseta.

### Change Log

#### v1.3.1
- Added option to block window movement (special thanks to [raohmaru](https://github.com/SethClydesdale/psobb-meseta-count/pull/1) for adding this).

#### v1.3.0
- Added Gains and Losses indicator. For example : picking up 100 meseta will show +100, and buying an item worth 500 will show -500. This can be toggled in the configuration. You may need to increase the width of the Meseta Count window to about 180 if you're currently using this addon.
- Added **Show Placeholder** configuration option. This will let you turn the placeholder that shows when your Meseta isn't available on or off.
- Added support for Solybum's [Theme Editor](https://github.com/Solybum/PSOBBMod-Addons) addon.
- Cleaned up and organized the configuration menu, added collapsible groups, tooltips, and made minor optimizations to some options.
- Changed the default state of **Colorize Text** on new installations to be disabled by default.
- Removed percentage value displaying on the progress bar. That wasn't supposed to be there.
- Fixed Font Scale affecting the title bar.

#### v1.2.0
- Added High Contrast Color option to configuration. You can choose to enable this option when **Colorize Text** is disabled.
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
