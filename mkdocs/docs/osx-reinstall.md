## OSX reset

restart + Shift.

Later press WinKey + R   ( [%] + R)

http://www.howtogeek.com/186860/how-to-reinstall-os-x-on-your-mac-wipe-your-drive-and-create-usb-installation-media/

### Make Usb

```
sudo /Applications/Install\ OS\ X\ \ 
   Mavericks.app/Contents/Resources/createinstallmedia \
   volume /Volumes/Name \
   applicationpath /Applications/Install\ OS\ X\ \ 
   Mavericks.app nointeraction
```

### Log in installation progress

This instruction but not working:
Press Command + L. This brings up more information, such as the amount of time waiting to install. This is easier to view than the progress bar and may give you a better indication of the amount of time left.

## Mac doesn't finish update

http://www.macworld.co.uk/how-to/mac/what-do-if-your-mac-doesnt-finish-update-3624050/

What to do if you're positive OS X hasn't finished installing the update
We can't stress enough that you should wait before deciding that OS X isn't finishing your update. It can sometimes just take a while. But if you're sure that OS X has frozen during an update, there are some steps you can take.
Press Command + L to bring up the Log. Double-check that files are not being installed.
Hold down the power button to shut off the Mac.
Press the power button to start up the Mac.
Wait again to see if the bar progresses. Press Command + L to check the Log screen and ensure files are being installed.
If that doesn't work, hold the power button to force the Mac to switch off.
Press the power button and hold down the Shift key. See if the Mac will start up in Safe Mode. Open App Store and update your apps while in Safe mode. Reboot.
If Safe Mode doesn't work, restart the Mac and hold down Command, Option, P and R. This will reset the NVRAM. Wait until the computer restart and wait to see if it starts updating.
As a final measure, restart the Mac and hold down Command + R to enter recovery mode. This enables you to start the installation process again from scratch.

