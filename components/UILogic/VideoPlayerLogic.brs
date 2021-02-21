sub ShowVideoScreen(rowContent as Object, selectedItem as Integer, isSeries = false as Boolean)
    videoScreen = CreateObject("roSGNode", "VideoScreen") ' create an instance of videoScreen
    videoScreen.observeField("close", "OnVideoScreenClose")
    ' populate videoScreen data
    videoScreen.isSeries = isSeries
    videoScreen.content = rowContent
    videoScreen.startIndex = selectedItem
    ' append videoScreen to scene and show it
    ShowScreen(videoScreen)
end sub

sub OnVideoScreenClose(event as Object) ' invoked once videoScreen's close field is changed
    m.GridScreen = CreateObject("roSGNode", "GridScreen")
    videoScreen = event.GetRoSGNode()
    close = event.GetData()
    if close = true
        CloseScreen(videoScreen) ' remove videoScreen from scene and close it
        m.GridScreen.SetFocus(true) ' return focus to grid screen
        ' navigate to the last played item
        m.GridScreen.jumpToRowItem = [m.selectedIndex[0], currentIndex + m.selectedIndex[1]]
    end if
end sub