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
  options.mcMesetaGoal = options.mcMesetaGoal or 1000
  options.fontScale = options.fontScale or 1.0
else
  options = {
    configurationEnableWindow = true,
    enable = true,
    mcEnableWindow = true,
    mcNoTitleBar = "",
    mcNoResize = "",
    mcTransparent = false,
    mcMesetaGoal = 1000,
    fontScale = 1.0,
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
    io.write(string.format("  mcMesetaGoal = %s,\n", tostring(options.mcMesetaGoal)))
    io.write(string.format("  fontScale = %s,\n", tostring(options.fontScale)))
    io.write("}\n")

    io.close(file)
  end
end


-- pointer
local _MesetaPtr = 0x00A94254

-- shows the meseta count
local showMesetaCount = function()
  local ptrAddr = pso.read_u32(_MesetaPtr)
  
  if ptrAddr ~= 0 then
    local mesetaAddr = pso.read_u32(ptrAddr + 0x2B4)
    local meseta = pso.read_u32(mesetaAddr + 0x20)

    -- text will be yellow if meseta > 1000||goal otherwise it'll go from yellow to orange to red
    imgui.TextColored(1, meseta / options.mcMesetaGoal, 0.0, 1, string.format("%i Meseta", meseta))
  else
    imgui.TextColored(1, 0, 0, 1, "0 Meseta")
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
    imgui.SetNextWindowSize(130, 50, "FirstUseEver");
    
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
    version = "1.0.1",
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