# FlexDDS
 Control via MATLAB for the WieserLabs FlexDDS
 
* In the MATLAB directory, right-click the top folder FlexDDS, Add to Path >> Selected Folders and Subfolders to access all functions. Or, Home >> Set Path >> Add with Subfolders ...

* This depends on the tcpip() function in the Instrument Control Toolbox add-on for MATLAB

Connection relies on a static local IP set on the SD card. Default is DHCP, or 192.168.11.99

A folder of functions to communicate in the command line hopefully covers everything but RAM, lmk if something else should be added. 

Generally, functions are added to a 'stack', and then flushed all at once to the Flex's DCP.

A GUI That controls STP's and CFR's is available. Generally each profile and Slot keeps a record of its current state. These values can be saved, edited and loaded from the MATLAB workspace. 


### Useful links
---
[AD9910 Documentation](https://www.analog.com/media/en/technical-documentation/data-sheets/AD9910.pdf)

[WieserLabs FlexDDS User Manual](https://www.wieserlabs.com/prods/radio-frequency/flexdds-ng/FlexDDS-NG_Manual.pdf)
