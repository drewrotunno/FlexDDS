%%%
%%% This Gui is a stable release for all the functions it seems to have. 
%%%
%%% All CFR settings and STP profile stuff works fine on 6 slots afaik.
%%%

% [ ? ] button on top left might help.
% Units and offsets can be set in the top left corner. 
% starting values can be edited in the .fig with MATLAB's guide
% type 'guide' in the command line, and open the .fig to edit

% Enter Flex's IP Address in the top left corner
% Select desired Slot to connect to (slot0 default)
% Press the Red [ Connect ] button. It should turn green. 

% All commands (CFR, Profile changes, STP Freq/phase/amps) are only stored 
% locally until a [ Flush ] button is pressed. 

% TO USE:
% Connect to any slot, selected at the top middle. 
% Select profiles to write data to in the top right. (0 default)
% Change current profile with buttons, individually or both

% Enter desired frequency, phase, and amplitude in the central boxes
% Set with button, individually or both.  
% Values should store when changing between Slots and Profiles

% [ Edit CFR's ] button brings a list of all CFR bits. You can set by 
% radio options and save the Hex code for future use. 

% Press [ Flush One Slot ] button. The DCP instructions, in order, should
% be executed. 

% If phase continuous behavior is desired between Channels/Slots,
% the [Re-Lock Phase] button can be flushed, 
% which turns off both phase accumulators, and turns both on simultaneously 
% with a Rack Trigger A (or its button).
% A typical procedure is to [set both] STP Channels, 
% (same freq, different phase) , pressing [Re-Lock Phase],
% then [Flush One Slot]. On Trigger Rack A , the two channels 
% should give the desired phase relationship
