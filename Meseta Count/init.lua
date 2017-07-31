-- imports
local core_mainmenu = require("core_mainmenu")
local cfg = require("Meseta Count.configuration")

-- options
local optionsLoaded, options = pcall(require, "Meseta Count.options")
local optionsFileName = "addons/Meseta Count/options.lua"
local firstPresent = true
local ConfigurationWindow


if optionsLoaded then
  options.configurationEnableWindow = options.configurationEnableWindow == nil and true or options.configurationEnableWindow
  options.enable = options.enable == nil and true or options.enable
  options.mcEnableWindow = options.mcEnableWindow == nil and true or options.mcEnableWindow
  options.mcNoTitleBar = options.mcNoTitleBar or ""
  options.mcNoResize = options.mcNoResize or ""
  options.mcTransparent = options.mcTransparent == nil and false or options.mcTransparent
  options.fontScale = options.fontScale or 1.0
  
  options.mcColorizeText = options.mcColorizeText == nil and true or options.mcColorizeText
  options.mcHighContrast = options.mcHighContrast == nil and false or options.mcHighContrast
  
  options.mcDigitGrouping = options.mcDigitGrouping == nil and true or options.mcDigitGrouping
  options.mcDigitSeparator = options.mcDigitSeparator or ","
  
  options.mcMesetaLabel = options.mcMesetaLabel or " Meseta"
  options.mcMesetaLabelPos = options.mcMesetaLabelPos or 2
  
  options.mcMesetaGoal = options.mcMesetaGoal or 100000
  options.mcMesetaGoalBar = options.mcMesetaGoalBar == nil and true or options.mcMesetaGoalBar 
  options.mcBarWidth = options.mcBarWidth or 100
  options.mcBarHeight = options.mcBarHeight or 3
  
  options.mcX = options.mcX or 100
  options.mcY = options.mcY or 100
  options.mcWidth = options.mcWidth or 130
  options.mcHeight = options.mcHeight or 55
  options.mcChanged = options.mcChanged or false

else
  options = {
    configurationEnableWindow = true,
    enable = true,
    mcEnableWindow = true,
    mcNoTitleBar = "",
    mcNoResize = "",
    mcTransparent = false,
    fontScale = 1.0,
    
    mcColorizeText = true,
    mcHighContast = false,
    
    mcDigitGrouping = true,
    mcDigitSeparator = ",",
    
    mcMesetaLabel = " Meseta",
    mcMesetaLabelPos = 2,
    
    mcMesetaGoal = 100000,
    mcMesetaGoalBar = true,
    mcBarWidth = 100,
    mcBarHeight = 3,
    
    mcX = 100,
    mcY = 100,
    mcWidth = 130,
    mcHeight = 55,
    mcChanged = false
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
    
    io.write(string.format("  mcColorizeText = %s,\n", tostring(options.mcColorizeText)))
    io.write(string.format("  mcHighContrast = %s,\n", tostring(options.mcHighContrast)))
    
    io.write(string.format("  mcDigitGrouping = %s,\n", tostring(options.mcDigitGrouping)))
    io.write(string.format("  mcDigitSeparator = \"%s\",\n", tostring(options.mcDigitSeparator)))
    
    io.write(string.format("  mcMesetaLabel = \"%s\",\n", tostring(options.mcMesetaLabel)))
    io.write(string.format("  mcMesetaLabelPos = %s,\n", tostring(options.mcMesetaLabelPos)))
    
    io.write(string.format("  mcMesetaGoal = %s,\n", tostring(options.mcMesetaGoal)))
    io.write(string.format("  mcMesetaGoalBar = %s,\n", tostring(options.mcMesetaGoalBar)))
    io.write(string.format("  mcBarWidth = %s,\n", tostring(options.mcBarWidth)))
    io.write(string.format("  mcBarHeight = %s,\n", tostring(options.mcBarHeight)))
    
    io.write(string.format("  mcX = %s,\n", tostring(options.mcX)))
    io.write(string.format("  mcY = %s,\n", tostring(options.mcY)))
    io.write(string.format("  mcWidth = %s,\n", tostring(options.mcWidth)))
    io.write(string.format("  mcHeight = %s,\n", tostring(options.mcHeight)))
    io.write(string.format("  mcChanged = %s,\n", tostring(options.mcChanged)))

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
  local label = options.mcMesetaLabel
  
  if playerAddr ~= 0 then
    local inventory = pso.read_u32(playerAddr + 0x2B4)
    local meseta = pso.read_u32(inventory + 0x20)
    
    local mesetaStr = string.format(
      options.mcMesetaLabelPos == 1 and "%s%i" or "%i%s", 
      options.mcMesetaLabelPos == 1 and label or meseta, 
      options.mcMesetaLabelPos == 1 and meseta or label
    )
    local progress = meseta / options.mcMesetaGoal
    local tooltip = string.format("%i/%i Meseta (%.2f%%%%)", meseta, options.mcMesetaGoal, progress > 1 and 100 or progress * 100)
    
    -- don't let progress exceed 100%
    if progress > 1 then
      progress = 1
    end
    
    -- group digits so they're easier to read (1000 --> 1,000)
    if options.mcDigitGrouping then
      mesetaStr = string.gsub(mesetaStr, "(%d+)(%d%d%d)", string.format("%%1%s%%2", options.mcDigitSeparator))
      tooltip = string.gsub(tooltip, "(%d+)(%d%d%d)", string.format("%%1%s%%2", options.mcDigitSeparator))
    end
    

    -- show the meseta count colorized or as plaintext
    if options.mcColorizeText or options.mcHighContrast then
      -- text will be yellow if meseta > 100000||goal||HighContrast=true, otherwise it'll go from red to orange to yellow
      imgui.TextColored(1, options.mcHighContrast and 1 or progress, 0, 1, mesetaStr)
    else
      imgui.Text(mesetaStr)
    end
    
    -- show tooltip when hovering the Meseta count
    if imgui.IsItemHovered() then
      imgui.SetTooltip(tooltip)
    end
    
    -- display a progress bar if enabled
    if options.mcMesetaGoalBar then
      -- progress bar will change color based on state
      local color = progress == 1 and {0, 0.7, 0} or {1, 0.7, 0}
      -- yellow (incomplete)
      -- green (complete)
      
      imgui.PushStyleColor("PlotHistogram", color[1], color[2], color[3], 1)
      imgui.ProgressBar(progress, options.mcBarWidth, options.mcBarHeight)
      imgui.PopStyleColor()
      
      -- show tooltip when hovering the progress bar
      if imgui.IsItemHovered() then
        imgui.SetTooltip(tooltip)
      end
    end
    
    
  -- show a placeholder until the data can be retrieved
  else
    local placeholder = string.format(options.mcMesetaLabelPos == 1 and "%s0" or "0%s", label)
    
    if options.mcColorizeText or options.mcHighContrast then
      imgui.TextColored(1, options.mcHighContrast and 1 or 0, 0, 1, placeholder)
    else
      imgui.Text(placeholder)
    end
    
    if options.mcMesetaGoalBar then
      imgui.ProgressBar(0, options.mcBarWidth, options.mcBarHeight)
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
    
    if firstPresent or options.mcChanged then
      options.mcChanged = false
      
      imgui.SetNextWindowPos(options.mcX, options.mcY, "Always")
      imgui.SetNextWindowSize(options.mcWidth, options.mcHeight, "Always");
    end
    
    if imgui.Begin("Meseta Count", nil, { options.mcNoTitleBar, options.mcNoResize }) then
      imgui.SetWindowFontScale(options.fontScale)
      showMesetaCount();
    end
    imgui.End()
  end
  
  if options.mcTransparent == true then
    imgui.PopStyleColor()
  end
  
  if firstPresent then
    firstPresent = false
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
    version = "1.2.0",
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