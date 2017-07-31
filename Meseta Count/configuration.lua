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
    local labelPositionList = {
      "Before",
      "After"
    }
    
    imgui.Text("General Settings")
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
    
    
    imgui.Text("\nPosition and Size")
    imgui.PushItemWidth(100)
    success, _configuration.mcX = imgui.InputInt("X", _configuration.mcX)
    imgui.PopItemWidth()
    if success then
      _configuration.mcChanged = true
      this.changed = true
    end
    
    imgui.SameLine(0, 38)
    imgui.PushItemWidth(100)
    success, _configuration.mcY = imgui.InputInt("Y", _configuration.mcY)
    imgui.PopItemWidth()
    if success then
      _configuration.mcChanged = true
      this.changed = true
    end
    
    imgui.PushItemWidth(100)
    success, _configuration.mcWidth = imgui.InputInt("Width", _configuration.mcWidth)
    imgui.PopItemWidth()
    if success then
      _configuration.mcChanged = true
      this.changed = true
    end
    
    imgui.SameLine(0, 10)
    imgui.PushItemWidth(100)
    success, _configuration.mcHeight = imgui.InputInt("Height", _configuration.mcHeight)
    imgui.PopItemWidth()
    if success then
      _configuration.mcChanged = true
      this.changed = true
    end
    
    
    imgui.Text("\nMeseta Count Options")
    if imgui.Checkbox("Colorize Text", _configuration.mcColorizeText) then
      _configuration.mcColorizeText = not _configuration.mcColorizeText
      
      -- remove high contrast color if using goal colorization
      if _configuration.mcHighContrast == true then
        _configuration.mcHighContrast = false
      end
      
      this.changed = true
    end
    
    if _configuration.mcColorizeText == false then
      imgui.SameLine(0, 84)
      if imgui.Checkbox("Use High Contrast Color", _configuration.mcHighContrast) then
        _configuration.mcHighContrast = not _configuration.mcHighContrast
        this.changed = true
      end
    end
    
    if imgui.Checkbox("Use Digit Grouping", _configuration.mcDigitGrouping) then
      _configuration.mcDigitGrouping = not _configuration.mcDigitGrouping
      this.changed = true
    end
    
    if _configuration.mcDigitGrouping then
      imgui.SameLine(0, 49)
      imgui.PushItemWidth(50)
      success, _configuration.mcDigitSeparator = imgui.InputText("Digit Separator", _configuration.mcDigitSeparator, 2)
      imgui.PopItemWidth()
      if success then
        this.changed = true
      end
    end
    
    imgui.PushItemWidth(100)
    success, _configuration.mcMesetaLabel = imgui.InputText("Meseta Label", _configuration.mcMesetaLabel, 255)
    imgui.PopItemWidth()
    if success then
      this.changed = true
    end
    
    imgui.SameLine(0, 10)
    imgui.PushItemWidth(75)
    success, _configuration.mcMesetaLabelPos = imgui.Combo("Label Position", _configuration.mcMesetaLabelPos, labelPositionList, table.getn(labelPositionList))
    imgui.PopItemWidth()
    if success then
      this.changed = true
    end
    
    imgui.PushItemWidth(100)
    success, _configuration.mcMesetaGoal = imgui.InputInt("Meseta Goal", _configuration.mcMesetaGoal)
    imgui.PopItemWidth()
    if success then
      this.changed = true
    end
    
    imgui.SameLine(0, 17)
    if imgui.Checkbox("Show Progress Bar", _configuration.mcMesetaGoalBar) then
      _configuration.mcMesetaGoalBar = not _configuration.mcMesetaGoalBar
      this.changed = true
    end
    
    if _configuration.mcMesetaGoalBar then
      imgui.PushItemWidth(100)
      success, _configuration.mcBarWidth = imgui.InputInt("Bar Width", _configuration.mcBarWidth)
      imgui.PopItemWidth()
      if success then
        this.changed = true
      end

      imgui.SameLine(0, 31)
      imgui.PushItemWidth(100)
      success, _configuration.mcBarHeight = imgui.InputInt("Bar Height", _configuration.mcBarHeight)
      imgui.PopItemWidth()
      if success then
        this.changed = true
      end
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