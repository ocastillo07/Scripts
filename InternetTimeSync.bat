@echo off

w32tm /resync

schtasks /Change /TN "Event Viewer Tasks\RunInternetTimeSync" /DISABLE