local function ConfigurationWindow(configuration)
  local this = {
    title = "Meseta Count - Configuration",
    fontScale = 1.0,
    open = false,
    changed = false,
  }

  local _configuration = configuration

  local _showWindowSettings = function()
    local success

    if imgui.Checkbox("Enable", _configuration.mcEnableWindow) then
      _configuration.mcEnableWindow = not _configuration.mcEnableWindow
      this.changed = true
    end

    if imgui.Checkbox("No title bar", _configuration.mcNoTitleBar == "NoTitleBar") then
      if _configuration.mcNoTitleBar == "NoTitleBar" then
        _configuration.mcNoTitleBar = ""
      else
        _configuration.mcNoTitleBar = "NoTitleBar"
      end
      this.changed = true
    end

    if imgui.Checkbox("No resize", _configuration.mcNoResize == "NoResize") then
      if _configuration.mcNoResize == "NoResize" then
        _configuration.mcNoResize = ""
      else
        _configuration.mcNoResize = "NoResize"
      end
      this.changed = true
    end
    
    if imgui.Checkbox("Transparent window", _configuration.mcTransparent) then
      _configuration.mcTransparent = not _configuration.mcTransparent
      this.changed = true
    end
    
    success, _configuration.fontScale = imgui.InputFloat("Font Scale", _configuration.fontScale)
    if success then
      this.changed = true
    end
    
    success, _configuration.mcMesetaGoal = imgui.InputInt("Meseta Goal", _configuration.mcMesetaGoal)
    if success then
      this.changed = true
    end
    
    if imgui.Checkbox("Meseta Goal Progress Bar", _configuration.mcMesetaGoalBar) then
      _configuration.mcMesetaGoalBar = not _configuration.mcMesetaGoalBar
      this.changed = true
    end
    
    if imgui.Checkbox("Colorize Text", _configuration.mcColorizeText) then
      _configuration.mcColorizeText = not _configuration.mcColorizeText
      this.changed = true
    end
  end

  this.Update = function()
    if this.open == false then
      return
    end

    local success

    imgui.SetNextWindowSize(500, 400, 'FirstUseEver')
    success, this.open = imgui.Begin(this.title, this.open)
    imgui.SetWindowFontScale(this.fontScale)

    _showWindowSettings()

    imgui.End()
  end

  return this
end

return {
  ConfigurationWindow = ConfigurationWindow,
}