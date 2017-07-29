-- imports
local core_mainmenu = require("core_mainmenu")
local cfg = require("Meseta Count.configuration")

-- options
local optionsLoaded, options = pcall(require, "Meseta Count.options")
local optionsFileName = "addons/Meseta Count/options.lua"
local ConfigurationWindow


if optionsLoaded then
  options.configurationEnableWindow = options.configurationEnableWindow == nil and true or options.configurationEnableWindow
  options.enable = options.enable == nil and true or options.enable
  options.mcEnableWindow = options.mcEnableWindow == nil and true or options.mcEnableWindow
  options.mcNoTitleBar = options.mcNoTitleBar or ""
  options.mcNoResize = options.mcNoResize or ""
  options.mcTransparent = options.mcTransparent == nil and true or options.mcTransparent
  options.fontScale = options.fontScale or 1.0
  options.mcMesetaGoal = options.mcMesetaGoal or 100000
  options.mcMesetaGoalBar = options.mcMesetaGoalBar == nil and true or options.mcMesetaGoalBar
  options.mcColorizeText = options.mcColorizeText == nil and true or options.mcColorizeText
else
  options = {
    configurationEnableWindow = true,
    enable = true,
    mcEnableWindow = true,
    mcNoTitleBar = "",
    mcNoResize = "",
    mcTransparent = false,
    fontScale = 1.0,
    mcMesetaGoal = 100000,
    mcMesetaGoalBar = true,
    mcColorizeText = true,
  }
end


local function SaveOptions(options)
  local file = io.open(optionsFileName, "w")
  if file ~= nil then
    io.output(file)

    io.write("return {\n")
    io.write(string.format("  configurationEnableWindow = %s,\n", tostring(options.configurationEnableWindow)))
    io.write(string.format("  enable = %s,\n", tostring(options.enable)))
    io.write("\n")
    io.write(string.format("  mcEnableWindow = %s,\n", tostring(options.mcEnableWindow)))
    io.write(string.format("  mcNoTitleBar = \"%s\",\n", options.mcNoTitleBar))
    io.write(string.format("  mcNoResize = \"%s\",\n", options.mcNoResize))
    io.write(string.format("  mcTransparent = %s,\n", tostring(options.mcTransparent)))
    io.write(string.format("  fontScale = %s,\n", tostring(options.fontScale)))
    io.write(string.format("  mcMesetaGoal = %s,\n", tostring(options.mcMesetaGoal)))
    io.write(string.format("  mcMesetaGoalBar = %s,\n", tostring(options.mcMesetaGoalBar)))
    io.write(string.format("  mcColorizeText = %s,\n", tostring(options.mcColorizeText)))
    io.write("}\n")

    io.close(file)
  end
end

-- player data
local _PlayerArray = 0x00A94254
local _PlayerIndex = 0x00A9C4F4

-- shows the meseta count
local showMesetaCount = function()
  local playerIndex = pso.read_u32(_PlayerIndex)
  local playerAddr = pso.read_u32(_PlayerArray + 4 * playerIndex)
  
  if playerAddr ~= 0 then
    local inventory = pso.read_u32(playerAddr + 0x2B4)
    local meseta = pso.read_u32(inventory + 0x20)
    
    local mesetaStr = string.format("%i Meseta", meseta)
    local progress = meseta / options.mcMesetaGoal
    
    -- don't let progress exceed 100%
    if progress > 1 then
      progress = 1
    end

    -- show the meseta count colorized or as plaintext
    if options.mcColorizeText then
      -- text will be yellow if meseta > 100000||goal otherwise it'll go from yellow to orange to red
      imgui.TextColored(1, progress, 0, 1, mesetaStr)
    else
      imgui.Text(mesetaStr)
    end
    
    -- display a progress bar if enabled
    if options.mcMesetaGoalBar then
      -- progress bar will change color based on state
      local color = progress == 1 and {0, 0.7, 0} or {1, 0.7, 0}
      -- yellow (incomplete)
      -- green (complete)
      
      imgui.PushStyleColor("PlotHistogram", color[1], color[2], color[3], 1)
      imgui.ProgressBar(progress, 100, 3)
      imgui.PopStyleColor()
    end
    
  -- show a placeholder until the data can be retrieved
  else
    local placeholder = "0 Meseta"
    
    if options.mcColorizeText then
      imgui.TextColored(1, 0, 0, 1, placeholder)
    else
      imgui.Text(placeholder)
    end
  end
end

-- config setup and drawing
local function present()
  if options.configurationEnableWindow then
    ConfigurationWindow.open = true
    options.configurationEnableWindow = false
  end

  ConfigurationWindow.Update()
  if ConfigurationWindow.changed then
    ConfigurationWindow.changed = false
    SaveOptions(options)
  end

  if options.enable == false then
    return
  end
  
  if options.mcTransparent == true then
    imgui.PushStyleColor("WindowBg", 0.0, 0.0, 0.0, 0.0)
  end

  if options.mcEnableWindow then
    imgui.SetNextWindowSize(130, 50, "Always");
    
    if imgui.Begin("Meseta Count", nil, { options.mcNoTitleBar, options.mcNoResize }) then
      imgui.SetWindowFontScale(options.fontScale)
      showMesetaCount();
    end
    imgui.End()
  end
  
  if options.mcTransparent == true then
    imgui.PopStyleColor()
  end
end


local function init()
  ConfigurationWindow = cfg.ConfigurationWindow(options)

  local function mainMenuButtonHandler()
    ConfigurationWindow.open = not ConfigurationWindow.open
  end

  core_mainmenu.add_button("Meseta Count", mainMenuButtonHandler)
  
  return {
    name = "Meseta Count",
    version = "1.1.1",
    author = "Seth Clydesdale",
    description = "Displays the total Meseta you're carrying.",
    present = present
  }
end

return {
  __addon = {
    init = init
  }
}