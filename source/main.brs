' ********** Copyright 2020 Roku Corp.  All Rights Reserved. **********

' Channel entry point
sub Main()
  showChannelSGScreen()
end sub

sub showChannelSGScreen()
screen = CreateObject("roSGScreen")
scene  = screen.CreateScene("LoadingScreen")
screen.show()
end sub
