local function ConfigurationWindow(configuration, customTheme)
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
    
    local animationDirList = {
      "Left",
      "Right"
    }
    
    
    -- General Settings
    if imgui.TreeNodeEx("General Settings", "DefaultOpen") then
      if imgui.Checkbox("Enable", _configuration.mcEnableWindow) then
        _configuration.mcEnableWindow = not _configuration.mcEnableWindow
        this.changed = true
      end
      
      if imgui.IsItemHovered() then
        imgui.SetTooltip("Turns the addon on or off.")
      end

      if customTheme then
        if imgui.Checkbox("Use custom theme", _configuration.useCustomTheme) then
            _configuration.useCustomTheme = not _configuration.useCustomTheme
            this.changed = true
        end
        
        if imgui.IsItemHovered() then
          imgui.SetTooltip("Uses the custom theme you defined when enabled.")
        end
      end

      if imgui.Checkbox("No title bar", _configuration.mcNoTitleBar == "NoTitleBar") then
        if _configuration.mcNoTitleBar == "NoTitleBar" then
          _configuration.mcNoTitleBar = ""
        else
          _configuration.mcNoTitleBar = "NoTitleBar"
        end
        this.changed = true
      end
      
      if imgui.IsItemHovered() then
        imgui.SetTooltip("Removes the title bar from the window.")
      end

      if imgui.Checkbox("No resize", _configuration.mcNoResize == "NoResize") then
        if _configuration.mcNoResize == "NoResize" then
          _configuration.mcNoResize = ""
        else
          _configuration.mcNoResize = "NoResize"
        end
        this.changed = true
      end

      if imgui.Checkbox("No move", _configuration.mcNoMove == "NoMove") then
        if _configuration.mcNoMove == "NoMove" then
          _configuration.mcNoMove = ""
        else
          _configuration.mcNoMove = "NoMove"
        end
        this.changed = true
      end
      
      if imgui.IsItemHovered() then
        imgui.SetTooltip("Removes the resize handle from the window.")
      end

      if imgui.Checkbox("Transparent window", _configuration.mcTransparent) then
        _configuration.mcTransparent = not _configuration.mcTransparent
        this.changed = true
      end
      
      if imgui.IsItemHovered() then
        imgui.SetTooltip("Removes the background from the window, leaving it transparent.")
      end

      imgui.PushItemWidth(100)
      success, _configuration.fontScale = imgui.InputFloat("Font Scale", _configuration.fontScale)
      imgui.PopItemWidth()
      if success then
        this.changed = true
      end
      
      if imgui.IsItemHovered() then
        imgui.SetTooltip("Changes the font size of the window.")
      end

      
      imgui.Text("\nPosition and Size")
      imgui.PushItemWidth(100)
      success, _configuration.mcX = imgui.InputInt("X", _configuration.mcX)
      imgui.PopItemWidth()
      if success then
        _configuration.mcChanged = true
        this.changed = true
      end
      
      if imgui.IsItemHovered() then
        imgui.SetTooltip("Moves the window left or right.")
      end

      imgui.SameLine(0, 38)
      imgui.PushItemWidth(100)
      success, _configuration.mcY = imgui.InputInt("Y", _configuration.mcY)
      imgui.PopItemWidth()
      if success then
        _configuration.mcChanged = true
        this.changed = true
      end
      
      if imgui.IsItemHovered() then
        imgui.SetTooltip("Moves the window up or down.")
      end

      imgui.PushItemWidth(100)
      success, _configuration.mcWidth = imgui.InputInt("Width", _configuration.mcWidth)
      imgui.PopItemWidth()
      if success then
        _configuration.mcChanged = true
        this.changed = true
      end
      
      if imgui.IsItemHovered() then
        imgui.SetTooltip("Adjusts the width of the window.")
      end

      imgui.SameLine(0, 10)
      imgui.PushItemWidth(100)
      success, _configuration.mcHeight = imgui.InputInt("Height", _configuration.mcHeight)
      imgui.PopItemWidth()
      if success then
        _configuration.mcChanged = true
        this.changed = true
      end
      
      if imgui.IsItemHovered() then
        imgui.SetTooltip("Adjusts the height of the window.")
      end
      
      imgui.Text("\n")
      imgui.TreePop()
    end
    
    
    -- Meseta Count Options
    if imgui.TreeNodeEx("Meseta Count Options", "DefaultOpen") then
      if imgui.Checkbox("Colorize Text", _configuration.mcColorizeText) then
        _configuration.mcColorizeText = not _configuration.mcColorizeText

        -- remove high contrast color if using goal colorization
        if _configuration.mcHighContrast == true then
          _configuration.mcHighContrast = false
        end

        this.changed = true
      end
      
      if imgui.IsItemHovered() then
        imgui.SetTooltip("Colorizes the Meseta count based on your goal progress. Goes from red to orange to yellow.")
      end

      imgui.SameLine(0, 84)
      if imgui.Checkbox("Use High Contrast Color", _configuration.mcHighContrast) then
        _configuration.mcHighContrast = not _configuration.mcHighContrast
        
        -- remove goal colorization if using high contrast color
        if _configuration.mcColorizeText == true then
          _configuration.mcColorizeText = false
        end
        
        this.changed = true
      end
      
      if imgui.IsItemHovered() then
        imgui.SetTooltip("Displays the Meseta count in a bright yellow to make reading it easier.")
      end

      if imgui.Checkbox("Use Digit Grouping", _configuration.mcDigitGrouping) then
        _configuration.mcDigitGrouping = not _configuration.mcDigitGrouping
        this.changed = true
      end
      
      if imgui.IsItemHovered() then
        imgui.SetTooltip("Toggles digit grouping, used to make numbers readable. For example 1000 to 1,000.")
      end

      if _configuration.mcDigitGrouping then
        imgui.SameLine(0, 49)
        imgui.PushItemWidth(50)
        success, _configuration.mcDigitSeparator = imgui.InputText("Digit Separator", _configuration.mcDigitSeparator, 2)
        imgui.PopItemWidth()
        if success then
          this.changed = true
        end
        
        if imgui.IsItemHovered() then
          imgui.SetTooltip("Changes the separator used for digit grouping. For example 1,000 to 1.000.")
        end
      end

      imgui.PushItemWidth(100)
      success, _configuration.mcMesetaLabel = imgui.InputText("Meseta Label", _configuration.mcMesetaLabel, 255)
      imgui.PopItemWidth()
      if success then
        this.changed = true
      end
      
      if imgui.IsItemHovered() then
        imgui.SetTooltip("Changes the text shown on the Meseta count.")
      end

      imgui.SameLine(0, 10)
      imgui.PushItemWidth(75)
      success, _configuration.mcMesetaLabelPos = imgui.Combo("Label Position", _configuration.mcMesetaLabelPos, labelPositionList, table.getn(labelPositionList))
      imgui.PopItemWidth()
      if success then
        this.changed = true
      end
      
      if imgui.IsItemHovered() then
        imgui.SetTooltip("Changes the position of the Meseta label from MESETA_LABEL to LABEL_MESETA.")
      end

      
      imgui.Text("\nGoals and Progress Bar")
      imgui.PushItemWidth(100)
      success, _configuration.mcMesetaGoal = imgui.InputInt("Meseta Goal", _configuration.mcMesetaGoal)
      imgui.PopItemWidth()
      if success then
        this.changed = true
      end
      
      if imgui.IsItemHovered() then
        imgui.SetTooltip("Defines your goal Meseta. Progress towards your goal is shown with text colorization and/or a progress bar.")
      end

      imgui.SameLine(0, 17)
      if imgui.Checkbox("Show Progress Bar", _configuration.mcMesetaGoalBar) then
        _configuration.mcMesetaGoalBar = not _configuration.mcMesetaGoalBar
        this.changed = true
      end
      
      if imgui.IsItemHovered() then
        imgui.SetTooltip("Toggles display of the progress bar used for the Meseta goal.")
      end

      if _configuration.mcMesetaGoalBar then
        imgui.PushItemWidth(100)
        success, _configuration.mcBarWidth = imgui.InputInt("Bar Width", _configuration.mcBarWidth)
        imgui.PopItemWidth()
        if success then
          this.changed = true
        end
        
        if imgui.IsItemHovered() then
          imgui.SetTooltip("Adjusts the width of the progress bar.")
        end

        imgui.SameLine(0, 31)
        imgui.PushItemWidth(100)
        success, _configuration.mcBarHeight = imgui.InputInt("Bar Height", _configuration.mcBarHeight)
        imgui.PopItemWidth()
        if success then
          this.changed = true
        end
        
        if imgui.IsItemHovered() then
          imgui.SetTooltip("Adjusts the height of the progress bar.")
        end
      end

      
      imgui.Text("\nGains and Losses")
      if imgui.Checkbox("Show Gains and Losses", _configuration.mcShowDiff) then
        _configuration.mcShowDiff = not _configuration.mcShowDiff
        this.changed = true
      end
      
      if imgui.IsItemHovered() then
        imgui.SetTooltip("Toggles the display of gains and losses shown when your Meseta value changes.")
      end

      if _configuration.mcShowDiff then
        imgui.SameLine(0, 28)
        imgui.PushItemWidth(100)
        success, _configuration.mcDiffDuration = imgui.InputInt("Gain/Loss Duration", _configuration.mcDiffDuration)
        imgui.PopItemWidth()
        if success then
          this.changed = true
        end
        
        if imgui.IsItemHovered() then
          imgui.SetTooltip("Defines how long gains and losses should remain on screen.")
        end

        if imgui.Checkbox("Enable Slide Animation", _configuration.mcAnimateDiff) then
          _configuration.mcAnimateDiff = not _configuration.mcAnimateDiff
          this.changed = true
        end
        
        if imgui.IsItemHovered() then
          imgui.SetTooltip("Toggles the sliding animation for gains and losses.")
        end

        if _configuration.mcAnimateDiff then
          imgui.SameLine(0, 21)
          imgui.PushItemWidth(100)
          success, _configuration.mcAnimateDiffDistance = imgui.InputInt("Slide Distance", _configuration.mcAnimateDiffDistance)
          imgui.PopItemWidth()
          if success then
            this.changed = true
          end
          
          if imgui.IsItemHovered() then
            imgui.SetTooltip("Defines how far losses and gains should slide.")
          end
          
          imgui.PushItemWidth(75)
          success, _configuration.mcDiffGainsDir = imgui.Combo("Gains Direction", _configuration.mcDiffGainsDir, animationDirList, table.getn(animationDirList))
          imgui.PopItemWidth()
          if success then
            this.changed = true
          end
          
          if imgui.IsItemHovered() then
            imgui.SetTooltip("Changes the slide direction of gains.")
          end
          
          imgui.SameLine(0, 14)
          imgui.PushItemWidth(75)
          success, _configuration.mcDiffLossesDir = imgui.Combo("Losses Direction", _configuration.mcDiffLossesDir, animationDirList, table.getn(animationDirList))
          imgui.PopItemWidth()
          if success then
            this.changed = true
          end
          
          if imgui.IsItemHovered() then
            imgui.SetTooltip("Changes the slide direction of losses.")
          end
          
          imgui.PushItemWidth(100)
          success, _configuration.mcDiffLeftOffset = imgui.InputInt("Left Offset", _configuration.mcDiffLeftOffset)
          imgui.PopItemWidth()
          if success then
            this.changed = true
          end
          
          if imgui.IsItemHovered() then
            imgui.SetTooltip("Sets the start position of the slide left animation.")
          end
          
          imgui.SameLine(0, 17)
          imgui.PushItemWidth(100)
          success, _configuration.mcDiffRightOffset = imgui.InputInt("Right Offset", _configuration.mcDiffRightOffset)
          imgui.PopItemWidth()
          if success then
            this.changed = true
          end
          
          if imgui.IsItemHovered() then
            imgui.SetTooltip("Sets the start position of the slide right animation.")
          end
        end
      end
      

      imgui.Text("\nMiscellaneous")
      if imgui.Checkbox("Show Placeholder", _configuration.mcShowPlaceholder) then
        _configuration.mcShowPlaceholder = not _configuration.mcShowPlaceholder
        this.changed = true
      end
      
      if imgui.IsItemHovered() then
        imgui.SetTooltip("Toggles display of the placeholder shown when character data is unavailable.")
      end
      
      imgui.TreePop()
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