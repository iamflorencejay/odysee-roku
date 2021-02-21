' ********** Copyright 2020 Roku Corp.  All Rights Reserved. **********

' entry point of videoScreen
function Init()
    ' set rectangle fields
    m.top.width = 1280
    m.top.height = 720
    m.top.color="0x000000"
    ' store reference for playerTask so we can use it in other functions
    m.playerTask = m.top.FindNode("PlayerTask")
    m.playerTask.ObserveField("state", "OnPlayerTaskStateChange")   ' close screen once exited
end function

sub OnIndexChanged(event as Object) ' invoked when "startIndex" field is changed
    content = m.top.content
    index = event.GetData()
    ' check if content was populated
    if content <> invalid
        ' set playlist data and start task
        m.playerTask.content = content
        m.playerTask.startIndex = index
        m.playerTask.control = "RUN"
    end if
end sub

' close videoScreen once playerTask finished or stopped
sub OnPlayerTaskStateChange(event as Object)
    state = event.GetData()
    if state = "done" or state = "stop"
        m.top.close = true
    end if
end sub

' The OnKeyEvent() function receives remote control key events
function OnKeyEvent(key as String, press as Boolean) as Boolean
    result = false
    if press
        ' handle "back" key press
        if key = "back" and m.playerTask <> invalid
            ' we should stop playback and close this screen when user press "back" button
            m.playerTask.control = "STOP" ' as a result OnPlayerTaskStateChange is invoked
            result = true
        end if
    end if
    return result
end function

sub OnVideoPlayerStateChange() ' invoked when video state is changed
    state = videoScreen.state
    ' close video screen in case of error or end of playback
    if state = "error" or state = "finished"
        CloseScreen(videoScreen)
    end if
end sub

sub OnVideoVisibleChange() ' invoked when video node visibility is changed
    if videoScreen.visible = false and m.top.visible = true
        ' the index of the video in the video playlist that is currently playing.
        currentIndex = videoScreen.contentIndex
        videoScreen.control = "stop" ' stop playback
        'clear video player content, for proper start of next video player
        videoScreen.content = invalid
        m.GridScreen.SetFocus(true) ' return focus to grid screen
        ' navigate to the last played item
        m.GridScreen.jumpToRowItem = [m.selectedIndex[0], currentIndex + m.selectedIndex[1]]
    end if
end sub