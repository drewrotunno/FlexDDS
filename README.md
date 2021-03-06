# FlexDDS
 Control via MATLAB for the WieserLabs FlexDDS
 
* In the MATLAB directory, right-click the top folder FlexDDS, Add to Path >> Selected Folders and Subfolders to access all functions. Or,  permanently with  Home >> Set Path >> Add with Subfolders ...
* This depends on the tcpip() function in the Instrument Control Toolbox add-on for MATLAB.
* If anyone can make this into a small executable without all of MATLAB on its back I'll send you a gift basket

[Live Working Sessions](https://github.com/drewrotunno/FlexDDS/releases)  can be initiated using the 0.1 Release. It is incompatable with the master version.

Connection relies on a static local IP set on the Flex's SD card config. Default is DHCP, or 192.168.11.99

This version hopefully covers everything but RAM, i.e. Full STP profile control, DRG Frequency ramps, accessible CFR Registers, TTL triggers and output pulses from FlexDDS-NG's DCP, per slot and on the rack. This is a lot of 3-letter acronyms. 

Careful applications of the commands is advised. Generally, functions are added to a 'stack', and then flushed all at once to the Flex's DCP. See the Examples for my best practices. 

Bounty out on fixing the down-then-down ramping issue. See /ramp/multifreqtime.m . Everything else works there, it's not as BROKEN as it seems. 

A GUI That controls STP's and CFR's is available. Generally each profile and Slot keeps a record of its current state. These values can be saved, edited and loaded from the MATLAB workspace. 

Feel free to ask any questions! I can be reached for the rest of 2020 at
aprotunno [at] email.wm.edu

### Useful links
---
[AD9910 Documentation](https://www.analog.com/media/en/technical-documentation/data-sheets/AD9910.pdf)

[WieserLabs FlexDDS User Manual](https://www.wieserlabs.com/products/radio-frequency/flexdds-ng/FlexDDS-NG_Manual.pdf)
