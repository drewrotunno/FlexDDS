# FlexDDS
 Control via MATLAB for the WieserLabs FlexDDS
 
depends on the tcpip() function in the Instrument Control Toolbox 

In the MATLAB directory, right-click the top folder FlexDDS, Add to Path >> Selected Folders and Subfolders to access all functions. Will need to similarly remove and re-add if any subsequent folder management happens. 
 
Used Matlab's TCPIP to open a connection, then prints and scans like a file or something. 

Connection relies on a static local IP set on the SD card. We use 192.168.0.45 here. Default is DHCP, or 192.168.11.99

A folder of functions to communicate in the command line hopefully covers everything but RAM, lmk if something else should be added. 
The GUI is on the way which utilizes these functions. 


### Useful links
---
[AD9910 Documentation](https://www.analog.com/media/en/technical-documentation/data-sheets/AD9910.pdf)

[WieserLabs FlexDDS User Manual](https://www.wieserlabs.com/prods/radio-frequency/flexdds-ng/FlexDDS-NG_Manual.pdf)
