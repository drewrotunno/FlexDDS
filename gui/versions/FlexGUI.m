function varargout = FlexGUI(varargin)
% FLEXGUI MATLAB code for FlexGUI.fig
%      FLEXGUI, by itself, creates a new FLEXGUI or raises the existing
%      singleton*.
%
%      H = FLEXGUI returns the handle to a new FLEXGUI or the handle to
%      the existing singleton*.
%
%      FLEXGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FLEXGUI.M with the given input arguments.
%
%      FLEXGUI('Property','Value',...) creates a new FLEXGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before FlexGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to FlexGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help FlexGUI

% Last Modified by GUIDE v2.5 24-Sep-2019 15:36:01

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @FlexGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @FlexGUI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

function FlexGUI_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;

% make tabs
handles.tgroup = uitabgroup('Parent', handles.sweepholder,'TabLocation', 'top');
handles.tab0 = uitab('Parent', handles.tgroup, 'Title', 'Slot 0');
handles.tab1 = uitab('Parent', handles.tgroup, 'Title', 'Slot 1');
handles.tab2 = uitab('Parent', handles.tgroup, 'Title', 'Slot 2');
handles.tab3 = uitab('Parent', handles.tgroup, 'Title', 'Slot 3');
handles.tab4 = uitab('Parent', handles.tgroup, 'Title', 'Slot 4');
handles.tab5 = uitab('Parent', handles.tgroup, 'Title', 'Slot 5');
%Place panels into each tab
set(handles.slot0pan,'Parent',handles.tab0);
set(handles.slot1pan,'Parent',handles.tab1);
set(handles.slot2pan,'Parent',handles.tab2);
set(handles.slot3pan,'Parent',handles.tab3);
set(handles.slot4pan,'Parent',handles.tab4);
set(handles.slot5pan,'Parent',handles.tab5);
%Reposition each panel to same location as panel 1
set(handles.slot1pan,'position',get(handles.slot0pan,'position'));
set(handles.slot2pan,'position',get(handles.slot0pan,'position'));
set(handles.slot3pan,'position',get(handles.slot0pan,'position'));
set(handles.slot4pan,'position',get(handles.slot0pan,'position'));
set(handles.slot5pan,'position',get(handles.slot0pan,'position'));

handles.sweepholder.UserData = {...
    handles.swtabs0c0, handles.swtabs0c1;
    handles.swtabs1c0, handles.swtabs1c1;
    handles.swtabs2c0, handles.swtabs2c1;
    handles.swtabs3c0, handles.swtabs3c1;
    handles.swtabs4c0, handles.swtabs4c1;
    handles.swtabs5c0, handles.swtabs5c1    };

% handles.tgroup


% set units
unitfreq_Callback(hObject, eventdata, handles)
unittime_Callback(hObject, eventdata, handles)
% set table numbers
rownum_Callback(hObject, eventdata, handles)
copydest_Callback(hObject, eventdata, handles)
%load saved data
update_FPA_values(hObject, eventdata, handles)
update_CFR_values(hObject, eventdata, handles)
% Update handles structure
guidata(hObject, handles);
function varargout = FlexGUI_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function flush_Callback(hObject, eventdata, handles)
[slot, thisslot] = getslot(hObject, eventdata, handles);
% is it already open? 
t = get(handles.conn, 'UserData');
if isa( t{slot+1}, 'tcpip') && strcmp(t{slot+1}.status, 'open')
    thisslot.UserData = flexflush(t{slot+1}, thisslot.UserData);
    handles.flush.BackgroundColor = [0 1 0];
else
    handles.flush.BackgroundColor = [1 0 0];
end
function flushall_Callback(hObject, eventdata, handles)
t = get(handles.conn, 'UserData');
success = [];

% slot 0
if isa( t{1}, 'tcpip') && strcmp(t{1}.status, 'open')
    handles.slot0.UserData = flexflush(t{1}, handles.slot0.UserData);
    handles.flushall.BackgroundColor = [0 1 0];
    success(1) = true;
elseif isa( t{1}, 'tcpip') && ~(strcmp(t{1}.status, 'open'))
     handles.flushall.BackgroundColor = [1 0 0];
     success(1) = false;
end

% slot 1
if isa( t{2}, 'tcpip') && strcmp(t{2}.status, 'open')
    handles.slot1.UserData = flexflush(t{2}, slot1.UserData);
    handles.flushall.BackgroundColor = [0 1 0];
    success(2) = true;
elseif isa( t{2}, 'tcpip') && ~(strcmp(t{2}.status, 'open'))
     handles.flushall.BackgroundColor = [1 0 0];
     success(2) = false;
end

% slot 2
if isa( t{3}, 'tcpip') && strcmp(t{3}.status, 'open')
    slot2.UserData = flexflush(t{3}, handles.slot2.UserData);
    handles.flushall.BackgroundColor = [0 1 0];
    success(3) = true;
elseif isa( t{3}, 'tcpip') && ~(strcmp(t{3}.status, 'open'))
     handles.flushall.BackgroundColor = [1 0 0];
     success(3) = false;
end
% slot 3
if isa( t{4}, 'tcpip') && strcmp(t{4}.status, 'open')
    handles.slot3.UserData = flexflush(t{4}, handles.slot3.UserData);
    handles.flushall.BackgroundColor = [0 1 0];
    success(4) = true;
elseif isa( t{4}, 'tcpip') && ~(strcmp(t{4}.status, 'open'))
     handles.flushall.BackgroundColor = [1 0 0];
     success(4) = false;
end
% slot 4
if isa( t{5}, 'tcpip') && strcmp(t{5}.status, 'open')
    handles.slot4.UserData = flexflush(t{5}, handles.slot4.UserData);
    handles.flushall.BackgroundColor = [0 1 0];
    success(5) = true;
elseif isa( t{5}, 'tcpip') && ~(strcmp(t{5}.status, 'open'))
     handles.flushall.BackgroundColor = [1 0 0];
     success(5) = false;
end
% slot 5
if isa( t{6}, 'tcpip') && strcmp(t{6}.status, 'open')
    handles.slot5.UserData = flexflush(t{6}, handles.slot5.UserData);
    handles.flushall.BackgroundColor = [0 1 0];
    success(6) = true;
elseif isa( t{6}, 'tcpip') && ~(strcmp(t{6}.status, 'open'))
     handles.flushall.BackgroundColor = [1 0 0];
     success(6) = false;
end

function connectbutton_Callback(hObject, eventdata, handles)

[slot, thisslot] = getslot(hObject, eventdata, handles);
% is it already open? 
t = get(handles.conn, 'UserData');
if isa( t{slot+1}, 'tcpip')
    if strcmp(t{slot+1}.status, 'open')
        disp(['Slot ', num2str(slot), ' is already open'])
        set(thisslot, 'ForegroundColor', [0,.8,0]);
        set(handles.connectbutton, 'BackgroundColor', [.94,.94,.94]);
        return
    end
else
% connect    
ipstring = get(handles.iptext, 'String');
t{slot+1} = openconn(ipstring, slot);
pause(.1);
response = flexlst(t{slot+1});
set(handles.conn, 'UserData', t);

if strcmp(response, 'Auth OK')
%     disp(response);
    if strcmp(t{slot+1}.status, 'open')
        set(thisslot, 'ForegroundColor', [0,.8,0]);
        set(handles.connectbutton, 'BackgroundColor', [.94,.94,.94]);
        return
    end
else
    disp('something went wrong.')
end

end

function setchan0_Callback(hObject, eventdata, handles)
[prof0, profhandle] = getprof0(hObject, eventdata, handles);
[slot, thisslot] = getslot(hObject, eventdata, handles);

amp0 = str2double(handles.amp0.String);
phase0 = str2double(handles.phase0.String);
freq0 = ( str2double(handles.freq0.String) + str2double(handles.offset.String) )*freqmult(handles);

thisslot.UserData = onesingletone(thisslot.UserData, 0, prof0, amp0,  phase0, freq0);
thisslot.UserData = flexupdateone(thisslot.UserData, 0);

newstack(hObject, eventdata, handles);
handles.lastprofc0.Enable = 'on';
handles.nextprofc0.Enable = 'on';
function setchan1_Callback(hObject, eventdata, handles)
[prof1, profhandle] = getprof1(hObject, eventdata, handles);
[slot, thisslot] = getslot(hObject, eventdata, handles);

amp1 = str2double(handles.amp1.String);
phase1 = str2double(handles.phase1.String);
freq1 = ( str2double(handles.freq1.String) + str2double(handles.offset.String) )*freqmult(handles);

thisslot.UserData = onesingletone(thisslot.UserData, 1, prof1, amp1,  phase1, freq1);
thisslot.UserData = flexupdateone(thisslot.UserData, 1);

newstack(hObject, eventdata, handles);
handles.lastprofc1.Enable = 'on';
handles.nextprofc1.Enable = 'on';
function setbothbutton_Callback(hObject, eventdata, handles)
[prof0, profhandle] = getprof0(hObject, eventdata, handles);
[prof1, profhandle] = getprof1(hObject, eventdata, handles);
[slot, thisslot] = getslot(hObject, eventdata, handles);

amp0 = str2double(handles.amp0.String);
amp1 = str2double(handles.amp1.String);
phase0 = str2double(handles.phase0.String);
phase1 = str2double(handles.phase1.String);
freq0 =( str2double(handles.freq0.String) + str2double(handles.offset.String) ) *freqmult(handles);
freq1 =( str2double(handles.freq1.String) + str2double(handles.offset.String) ) *freqmult(handles);

% twosingletones(t{slot+1}, prof0,amp0,phase0,freq0,amp1,phase1,freq1);
thisslot.UserData = onesingletone(thisslot.UserData, 0, prof0, amp0,  phase0, freq0);
thisslot.UserData = onesingletone(thisslot.UserData, 1, prof1, amp1,  phase1, freq1);
thisslot.UserData = flexupdateboth(thisslot.UserData);

newstack(hObject, eventdata, handles);
handles.lastprofc0.Enable = 'on';
handles.nextprofc0.Enable = 'on';
handles.lastprofc1.Enable = 'on';
handles.nextprofc1.Enable = 'on';

function sendramps0_Callback(hObject, eventdata, handles)
[prof0, prof0handle] = getprof0(hObject, eventdata, handles);
[slot, thisslot] = getslot(hObject, eventdata, handles);

ch0 = handles.sweepholder.UserData{slot+1,1}.Data;
ch0lines = size(ch0,1);

% quick parse: all same type of sweep? 
numfreq=0;numphase=0;numamp=0;mix=0;first=0;startfreq=0;
for row = 1:1:ch0lines
%         ch0{row,2}
    if strcmpi(ch0{row,1}, 'ramp')
        if strcmpi(ch0{row,2}, 'freq')
            if ~logical(first); first='freq';startfreq=ch0{row,3}; end
            numfreq = numfreq +1;
        elseif strcmpi(ch0{row,2}, 'phase')
            if ~logical(first); first='phase';end
            numphase = numphase +1;
        elseif strcmpi(ch0{row,2}, 'amp')
            if ~logical(first); first='amp';end
            numamp = numamp +1;        
        end
    end
end
if numfreq && ~numphase && ~ numamp
%     disp('freq only');
    handles.cfr2DRGdestc0.Value = 1;
    handles.cfr2b19c0.Value = 1;
    setcfrc0_Callback(hObject, eventdata, handles)
elseif ~numfreq && numphase && ~numamp
%     disp('phase only');
    handles.cfr2DRGdestc0.Value = 2;
    handles.cfr2b19c0.Value = 1;
    setcfrc0_Callback(hObject, eventdata, handles)
elseif ~numfreq && ~numphase && numamp
%     disp('amp only');
    handles.cfr2DRGdestc0.Value = 3;
    handles.cfr2b19c0.Value = 1;
    setcfrc0_Callback(hObject, eventdata, handles)
else
%     disp('mix');
    mix = 1;
    if strcmpi(first, 'freq')
        handles.cfr2DRGdestc0.Value = 1;
    elseif strcmpi(first, 'phase')
        handles.cfr2DRGdestc0.Value = 2;
    elseif strcmpi(first, 'amp')
        handles.cfr2DRGdestc0.Value = 3;
    end
    handles.cfr2b19c0.Value = 1;
    setcfrc0_Callback(hObject, eventdata, handles)
end

for row = 1:1:ch0lines
    if strcmpi(ch0{row,1}, 'lock')
        handles.cfr1b11c0.Value = 1;handles.cfr1b11c1.Value = 1;
        [CFR1c0, CFR2c0] = generate_CFR_c0(hObject, eventdata, handles);
        [CFR1c1, CFR2c1] = generate_CFR_c1(hObject, eventdata, handles);
        thisslot.UserData = setCFRreg(thisslot.UserData,0,1,CFR1c0);
        thisslot.UserData = setCFRreg(thisslot.UserData,0,2,CFR2c0);
        thisslot.UserData = setCFRreg(thisslot.UserData,1,1,CFR1c1);
        thisslot.UserData = setCFRreg(thisslot.UserData,1,2,CFR2c1);
        thisslot.UserData = flexupdateboth(thisslot.UserData);
        handles.cfr1b11c0.Value = 0;handles.cfr1b11c1.Value = 0;
        [CFR1c0, CFR2c0] = generate_CFR_c0(hObject, eventdata, handles);
        [CFR1c1, CFR2c1] = generate_CFR_c1(hObject, eventdata, handles);
        thisslot.UserData = setCFRreg(thisslot.UserData,0,1,CFR1c0);
        thisslot.UserData = setCFRreg(thisslot.UserData,0,2,CFR2c0);
        thisslot.UserData = setCFRreg(thisslot.UserData,1,1,CFR1c1);
        thisslot.UserData = setCFRreg(thisslot.UserData,1,2,CFR2c1);
        if strcmpi(ch0{row,2}, 'rackA')
            thisslot.UserData = waitforRackA(thisslot.UserData, 0);
            thisslot.UserData = flexupdateone(thisslot.UserData, 0);
        elseif strcmpi(ch0{row,2}, 'rackB')
            thisslot.UserData = waitforRackB(thisslot.UserData, 0);
            thisslot.UserData = flexupdateone(thisslot.UserData, 0);
        elseif strcmpi(ch0{row,2}, 'slotA')
            thisslot.UserData = waitSlotTrig(thisslot.UserData, 0, 1,1);
            thisslot.UserData = flexupdateone(thisslot.UserData, 0);
        elseif strcmpi(ch0{row,2}, 'slotB')
            thisslot.UserData = waitSlotTrig(thisslot.UserData, 0, 2,1);
            thisslot.UserData = flexupdateone(thisslot.UserData, 0);
        elseif strcmpi(ch0{row,2}, 'slotC')
            thisslot.UserData = waitSlotTrig(thisslot.UserData, 0, 3,1);
            thisslot.UserData = flexupdateone(thisslot.UserData, 0);
        else
            handles.errep.String = ['problem in row ', num2str(row), ' column 2'];
            return
        end
        thisslot.UserData = flexupdateboth(thisslot.UserData);
    elseif strcmpi(ch0{row,1}, 'wait')
        if strcmpi(ch0{row,2}, 'rackA')
            thisslot.UserData = waitforRackA(thisslot.UserData, 0);
            thisslot.UserData = flexupdateone(thisslot.UserData, 0);
        elseif strcmpi(ch0{row,2}, 'rackB')
            thisslot.UserData = waitforRackB(thisslot.UserData, 0);
            thisslot.UserData = flexupdateone(thisslot.UserData, 0);
        elseif strcmpi(ch0{row,2}, 'slotA')
            thisslot.UserData = waitSlotTrig(thisslot.UserData, 0, 1,1);
            thisslot.UserData = flexupdateone(thisslot.UserData, 0);
        elseif strcmpi(ch0{row,2}, 'slotB')
            thisslot.UserData = waitSlotTrig(thisslot.UserData, 0, 2,1);
            thisslot.UserData = flexupdateone(thisslot.UserData, 0);
        elseif strcmpi(ch0{row,2}, 'slotC')
            thisslot.UserData = waitSlotTrig(thisslot.UserData, 0, 3,1);
            thisslot.UserData = flexupdateone(thisslot.UserData, 0);
        elseif strcmpi(ch0{row,2}, 'timeus')
            thisslot.UserData = waitus(thisslot.UserData, 0, str2double(ch0{row,5}) );
            thisslot.UserData = flexupdateone(thisslot.UserData, 0);
        elseif strcmpi(ch0{row,2}, 'timens')
            thisslot.UserData = waitns(thisslot.UserData, 0, str2double(ch0{row,5}) );
            thisslot.UserData = flexupdateone(thisslot.UserData, 0);
        else
            handles.errep.String = ['problem in row ', num2str(row), ' column 2'];
            return
        end
    elseif strcmpi(ch0{row,1}, 'ramp')
        if strcmpi(ch0{row,2}, 'freq')
            [thisslot.UserData, freqstep, timestep, timediff] = ...
                rampfreqtime(thisslot.UserData,     0,  ...
                (str2double(ch0{row,3}) + str2double(handles.offset.String) )*freqmult(handles) ,...
                (str2double(ch0{row,4}) + str2double(handles.offset.String) )*freqmult(handles),...
                str2double(ch0{row,5}) * timemult(handles) );
            if str2double(ch0{row,3}) > str2double(ch0{row,4})  % high to low
                thisslot.UserData = rampup(  thisslot.UserData,0 );
            else 
                thisslot.UserData = rampdown(thisslot.UserData,0 );
            end
            thisslot.UserData = flexupdateone(thisslot.UserData,0);
            ch0{row,6} = num2str(freqstep);
            ch0{row,7} = num2str(timestep);
            ch0{row,8} = num2str(timediff);
            handles.sweepholder.UserData{slot+1,1}.Data = ch0;
        elseif strcmpi(ch0{row,2}, 'phase')
            
        elseif strcmpi(ch0{row,2}, 'amp')
            
        else
            handles.errep.String = ['problem in row ', num2str(row), ' column 2'];
            return
        end
            
    else
        disp(['problem in row ', num2str(row), ' column 1'])
        return
    end
end

newstack(hObject, eventdata, handles);

function freq0_Callback(hObject, eventdata, handles)
[slot, thisslot] = getslot(hObject, eventdata, handles);
[prof0, profhandle] = getprof0(hObject, eventdata, handles);
data = handles.freq0.UserData;
data{slot+1,prof0+1} = handles.freq0.String;
handles.freq0.UserData  =  data;
function freq1_Callback(hObject, eventdata, handles)
[slot, thisslot] = getslot(hObject, eventdata, handles);
[prof1, profhandle] = getprof1(hObject, eventdata, handles);
data = handles.freq1.UserData;
data{slot+1,prof1+1} = handles.freq1.String;
handles.freq1.UserData  =  data;
function phase0_Callback(hObject, eventdata, handles)
[slot, thisslot] = getslot(hObject, eventdata, handles);
[prof0, profhandle] = getprof0(hObject, eventdata, handles);
data = handles.phase0.UserData;
data{slot+1,prof0+1} = handles.phase0.String;
handles.phase0.UserData  =  data;
function phase1_Callback(hObject, eventdata, handles)
[slot, thisslot] = getslot(hObject, eventdata, handles);
[prof1, profhandle] = getprof1(hObject, eventdata, handles);
data = handles.phase1.UserData;
data{slot+1,prof1+1} = handles.phase1.String;
handles.phase1.UserData  =  data;
function amp0_Callback(hObject, eventdata, handles)
[slot, thisslot] = getslot(hObject, eventdata, handles);
[prof0, profhandle] = getprof0(hObject, eventdata, handles);
data = handles.amp0.UserData;
data{slot+1,prof0+1} = handles.amp0.String;
handles.amp0.UserData  =  data;
function amp1_Callback(hObject, eventdata, handles)
[slot, thisslot] = getslot(hObject, eventdata, handles);
[prof1, profhandle] = getprof1(hObject, eventdata, handles);
data = handles.amp1.UserData;
data{slot+1,prof1+1} = handles.amp1.String;
handles.amp1.UserData  =  data;

function update_FPA_values(hObject, eventdata, handles)
[slot, thisslot] = getslot(hObject, eventdata, handles);
[prof0, profhandle] = getprof0(hObject, eventdata, handles);
[prof1, profhandle] = getprof1(hObject, eventdata, handles);

fdata0 = handles.freq0.UserData;
fdata1 = handles.freq1.UserData;
handles.freq0.String = fdata0{slot+1,prof0+1} ;
handles.freq1.String = fdata1{slot+1,prof1+1};

pdata0 = handles.phase0.UserData;
pdata1 = handles.phase1.UserData;
handles.phase0.String = pdata0{slot+1,prof0+1} ;
handles.phase1.String = pdata1{slot+1,prof1+1};

adata0 = handles.amp0.UserData;
adata1 = handles.amp1.UserData;
handles.amp0.String = adata0{slot+1,prof0+1} ;
handles.amp1.String = adata1{slot+1,prof1+1};
function update_CFR_values(hObject, eventdata, handles)
[slot, thisslot] = getslot(hObject, eventdata, handles);

CFR1c0data = handles.CFR1c0.UserData;
CFR2c0data = handles.CFR2c0.UserData;
CFR1c1data = handles.CFR1c1.UserData;
CFR2c1data = handles.CFR2c1.UserData;

handles.CFR1c0.String = CFR1c0data{slot+1};
handles.CFR2c0.String = CFR2c0data{slot+1};
handles.CFR1c1.String = CFR1c1data{slot+1};
handles.CFR2c1.String = CFR2c1data{slot+1};

function unitfreq_Callback(hObject, eventdata, handles)
unitname = {'Hz'; 'kHz'; 'MHz'; 'GHz' };
newunit = unitname{handles.unitfreq.Value};
handles.freqtext.String = ['Frequency (',newunit,')'];
tablenames = handles.swtabs0c0.ColumnName;
tablenames{3} = ['Start (',newunit,'/�)'];
tablenames{4} = ['Fin (',newunit,'/�)'];

for slot = 1:1:6
handles.sweepholder.UserData{slot,1}.ColumnName = tablenames;
handles.sweepholder.UserData{slot,2}.ColumnName = tablenames;
end
function unittime_Callback(hObject, eventdata, handles)
unitname = {'sec'; 'ms'; 'us'; 'ns' };
newunit = unitname{handles.unittime.Value};
tablenames = handles.swtabs0c0.ColumnName;
tablenames{5} = ['Time (',newunit,')'];
tablenames{8} = ['tDiff (',newunit,')'];
for slot = 1:1:6
handles.sweepholder.UserData{slot,1}.ColumnName = tablenames;
handles.sweepholder.UserData{slot,2}.ColumnName = tablenames;
end
function outmult = freqmult(handles)
power = 10^(3*(handles.unitfreq.Value-1));
multiplier = str2double(handles.multiplier.String);
outmult = multiplier*power;
function timeunit = timemult(handles)
timeunit = 10^(-3*(handles.unittime.Value-1));

function nextprofc0_Callback(hObject, eventdata, handles)
[slot, thisslot] = getslot(hObject, eventdata, handles);
[prof0, profhandle] = getprof0(hObject, eventdata, handles);

switch prof0
    case 0
        handles.stp0c0.Value = 0;
        handles.stp1c0.Value = 1;
        thisslot.UserData = setprof(thisslot.UserData, 0, 1);
    case 1
        handles.stp1c0.Value = 0;
        handles.stp3c0.Value = 1;
        thisslot.UserData = setprof(thisslot.UserData, 0, 3);
    case 2    
        handles.stp2c0.Value = 0;
        handles.stp6c0.Value = 1;
        thisslot.UserData = setprof(thisslot.UserData, 0, 6);
    case 3
        handles.stp3c0.Value = 0;
        handles.stp2c0.Value = 1;
        thisslot.UserData = setprof(thisslot.UserData, 0, 2);
    case 4
        handles.stp4c0.Value = 0;
        handles.stp0c0.Value = 1;
        thisslot.UserData = setprof(thisslot.UserData, 0, 0);
    case 5
        handles.stp5c0.Value = 0;
        handles.stp4c0.Value = 1;
        thisslot.UserData = setprof(thisslot.UserData, 0, 4);
    case 6
        handles.stp6c0.Value = 0;
        handles.stp7c0.Value = 1;
        thisslot.UserData = setprof(thisslot.UserData, 0, 7);
    case 7 
        handles.stp7c0.Value = 0;
        handles.stp5c0.Value = 1;
        thisslot.UserData = setprof(thisslot.UserData, 0, 5);
end
newstack(hObject, eventdata, handles);
update_FPA_values(hObject, eventdata, handles)
update_allowed_profs(hObject, eventdata, handles)

function lastprofc0_Callback(hObject, eventdata, handles)
[slot, thisslot] = getslot(hObject, eventdata, handles);
[prof0, profhandle] = getprof0(hObject, eventdata, handles);

switch prof0
    case 0
        handles.stp0c0.Value = 0;
        handles.stp4c0.Value = 1;
        thisslot.UserData = setprof(thisslot.UserData, 0, 4);
    case 1
        handles.stp1c0.Value = 0;
        handles.stp0c0.Value = 1;
        thisslot.UserData = setprof(thisslot.UserData, 0, 0);
    case 2    
        handles.stp2c0.Value = 0;
        handles.stp3c0.Value = 1;
        thisslot.UserData = setprof(thisslot.UserData, 0, 3);
    case 3
        handles.stp3c0.Value = 0;
        handles.stp1c0.Value = 1;
        thisslot.UserData = setprof(thisslot.UserData, 0, 1);
    case 4
        handles.stp4c0.Value = 0;
        handles.stp5c0.Value = 1;
        thisslot.UserData = setprof(thisslot.UserData, 0, 5);
    case 5
        handles.stp5c0.Value = 0;
        handles.stp7c0.Value = 1;
        thisslot.UserData = setprof(thisslot.UserData, 0, 7);
    case 6
        handles.stp6c0.Value = 0;
        handles.stp2c0.Value = 1;
        thisslot.UserData = setprof(thisslot.UserData, 0, 2);
    case 7 
        handles.stp7c0.Value = 0;
        handles.stp6c0.Value = 1;
        thisslot.UserData = setprof(thisslot.UserData, 0, 6);
end
newstack(hObject, eventdata, handles);
update_FPA_values(hObject, eventdata, handles)
update_allowed_profs(hObject, eventdata, handles)
function setprofc0_Callback(hObject, eventdata, handles)
[slot, thisslot] = getslot(hObject, eventdata, handles);
[prof, profhandle] = getprof0(hObject, eventdata, handles);

thisslot.UserData = setprof(thisslot.UserData, 0, prof);

handles.lastprofc0.Enable = 'on';
handles.nextprofc0.Enable = 'on';
handles.bothlastprof.Enable = 'on';
handles.bothnextprof.Enable = 'on';
newstack(hObject, eventdata, handles);
update_FPA_values(hObject, eventdata, handles)
update_allowed_profs(hObject, eventdata, handles)

function nextprofc1_Callback(hObject, eventdata, handles)
[slot, thisslot] = getslot(hObject, eventdata, handles);
[prof1, profhandle] = getprof1(hObject, eventdata, handles);
%change radios
switch prof1
    case 0
        handles.stp0c1.Value = 0;
        handles.stp1c1.Value = 1;
        thisslot.UserData = setprof(thisslot.UserData, 1, 1);
    case 1
        handles.stp1c1.Value = 0;
        handles.stp3c1.Value = 1;
        thisslot.UserData = setprof(thisslot.UserData, 1, 3);
    case 2    
        handles.stp2c1.Value = 0;
        handles.stp6c1.Value = 1;
        thisslot.UserData = setprof(thisslot.UserData, 1, 6);
    case 3
        handles.stp3c1.Value = 0;
        handles.stp2c1.Value = 1;
        thisslot.UserData = setprof(thisslot.UserData, 1, 2);
    case 4
        handles.stp4c1.Value = 0;
        handles.stp0c1.Value = 1;
        thisslot.UserData = setprof(thisslot.UserData, 1, 0);
    case 5
        handles.stp5c1.Value = 0;
        handles.stp4c1.Value = 1;
        thisslot.UserData = setprof(thisslot.UserData, 1, 4);
    case 6
        handles.stp6c1.Value = 0;
        handles.stp7c1.Value = 1;
        thisslot.UserData = setprof(thisslot.UserData, 1, 7);
    case 7 
        handles.stp7c1.Value = 0;
        handles.stp5c1.Value = 1;
        thisslot.UserData = setprof(thisslot.UserData, 1, 5);
end
newstack(hObject, eventdata, handles);
update_FPA_values(hObject, eventdata, handles)
update_allowed_profs(hObject, eventdata, handles)
function lastprofc1_Callback(hObject, eventdata, handles)
t = get(handles.conn, 'UserData');
[slot, thisslot] = getslot(hObject, eventdata, handles);
[prof1, profhandle] = getprof1(hObject, eventdata, handles);

switch prof1
    case 0
        handles.stp0c1.Value = 0;
        handles.stp4c1.Value = 1;
        thisslot.UserData = setprof(thisslot.UserData, 1, 4);
    case 1
        handles.stp1c1.Value = 0;
        handles.stp0c1.Value = 1;
        thisslot.UserData = setprof(thisslot.UserData, 1, 0);
    case 2    
        handles.stp2c1.Value = 0;
        handles.stp3c1.Value = 1;
        thisslot.UserData = setprof(thisslot.UserData, 1, 3);
    case 3
        handles.stp3c1.Value = 0;
        handles.stp1c1.Value = 1;
        thisslot.UserData = setprof(thisslot.UserData, 1, 1);
    case 4
        handles.stp4c1.Value = 0;
        handles.stp5c1.Value = 1;
        thisslot.UserData = setprof(thisslot.UserData, 1, 5);
    case 5
        handles.stp5c1.Value = 0;
        handles.stp7c1.Value = 1;
        thisslot.UserData = setprof(thisslot.UserData, 1, 7);
    case 6
        handles.stp6c1.Value = 0;
        handles.stp2c1.Value = 1;
        thisslot.UserData = setprof(thisslot.UserData, 1, 2);
    case 7 
        handles.stp7c1.Value = 0;
        handles.stp6c1.Value = 1;
        thisslot.UserData = setprof(thisslot.UserData, 1, 6);
end
newstack(hObject, eventdata, handles);
update_FPA_values(hObject, eventdata, handles)
update_allowed_profs(hObject, eventdata, handles)

function setprofc1_Callback(hObject, eventdata, handles)
[slot, thisslot] = getslot(hObject, eventdata, handles);
[prof, profhandle] = getprof1(hObject, eventdata, handles);

thisslot.UserData = setprof(thisslot.UserData, 1, prof);
% current prof should already be Radio-filled
% no need to set

handles.lastprofc1.Enable = 'on';
handles.nextprofc1.Enable = 'on';
handles.bothlastprof.Enable = 'on';
handles.bothnextprof.Enable = 'on';
newstack(hObject, eventdata, handles);
update_FPA_values(hObject, eventdata, handles)
update_allowed_profs(hObject, eventdata, handles)

function bothnextprof_Callback(hObject, eventdata, handles)
nextprofc0_Callback(hObject, eventdata, handles);
nextprofc1_Callback(hObject, eventdata, handles);
function bothlastprof_Callback(hObject, eventdata, handles)
lastprofc0_Callback(hObject, eventdata, handles);
lastprofc1_Callback(hObject, eventdata, handles)
function bothsetprof_Callback(hObject, eventdata, handles)
setprofc0_Callback(hObject, eventdata, handles)
setprofc1_Callback(hObject, eventdata, handles)

function update_allowed_profs(hObject, eventdata, handles)
[prof0, profhandle] = getprof0(hObject, eventdata, handles);
[prof1, profhandle] = getprof1(hObject, eventdata, handles);

switch prof0
    case 0
        handles.stp0c0.Enable = 'on';
        handles.stp1c0.Enable = 'on';
        handles.stp2c0.Enable = 'on';
        handles.stp3c0.Enable = 'on';
        handles.stp4c0.Enable = 'on';
        handles.stp5c0.Enable = 'on';
        handles.stp6c0.Enable = 'on';
        handles.stp7c0.Enable = 'on';
    case 1
        handles.stp0c0.Enable = 'on';
        handles.stp1c0.Enable = 'on';
        handles.stp2c0.Enable = 'off';
        handles.stp3c0.Enable = 'on';
        handles.stp4c0.Enable = 'off';
        handles.stp5c0.Enable = 'on';
        handles.stp6c0.Enable = 'off';
        handles.stp7c0.Enable = 'on';
    case 2
        handles.stp0c0.Enable = 'on';
        handles.stp1c0.Enable = 'off';
        handles.stp2c0.Enable = 'on';
        handles.stp3c0.Enable = 'on';
        handles.stp4c0.Enable = 'off';
        handles.stp5c0.Enable = 'off';
        handles.stp6c0.Enable = 'on';
        handles.stp7c0.Enable = 'on';        
    case 3
        handles.stp0c0.Enable = 'on';
        handles.stp1c0.Enable = 'on';
        handles.stp2c0.Enable = 'on';
        handles.stp3c0.Enable = 'on';
        handles.stp4c0.Enable = 'off';
        handles.stp5c0.Enable = 'off';
        handles.stp6c0.Enable = 'off';
        handles.stp7c0.Enable = 'on';        
    case 4
        handles.stp0c0.Enable = 'on';
        handles.stp1c0.Enable = 'off';
        handles.stp2c0.Enable = 'off';
        handles.stp3c0.Enable = 'off';
        handles.stp4c0.Enable = 'on';
        handles.stp5c0.Enable = 'on';
        handles.stp6c0.Enable = 'on';
        handles.stp7c0.Enable = 'on';        
    case 5
        handles.stp0c0.Enable = 'on';
        handles.stp1c0.Enable = 'on';
        handles.stp2c0.Enable = 'off';
        handles.stp3c0.Enable = 'off';
        handles.stp4c0.Enable = 'on';
        handles.stp5c0.Enable = 'on';
        handles.stp6c0.Enable = 'off';
        handles.stp7c0.Enable = 'on';        
    case 6
        handles.stp0c0.Enable = 'on';
        handles.stp1c0.Enable = 'off';
        handles.stp2c0.Enable = 'on';
        handles.stp3c0.Enable = 'off';
        handles.stp4c0.Enable = 'on';
        handles.stp5c0.Enable = 'off';
        handles.stp6c0.Enable = 'on';
        handles.stp7c0.Enable = 'on';        
    case 7
        handles.stp0c0.Enable = 'on';
        handles.stp1c0.Enable = 'on';
        handles.stp2c0.Enable = 'on';
        handles.stp3c0.Enable = 'on';
        handles.stp4c0.Enable = 'on';
        handles.stp5c0.Enable = 'on';
        handles.stp6c0.Enable = 'on';
        handles.stp7c0.Enable = 'on';        
end
switch prof1
    case 0
        handles.stp0c1.Enable = 'on';
        handles.stp1c1.Enable = 'on';
        handles.stp2c1.Enable = 'on';
        handles.stp3c1.Enable = 'on';
        handles.stp4c1.Enable = 'on';
        handles.stp5c1.Enable = 'on';
        handles.stp6c1.Enable = 'on';
        handles.stp7c1.Enable = 'on';
    case 1
        handles.stp0c1.Enable = 'on';
        handles.stp1c1.Enable = 'on';
        handles.stp2c1.Enable = 'off';
        handles.stp3c1.Enable = 'on';
        handles.stp4c1.Enable = 'off';
        handles.stp5c1.Enable = 'on';
        handles.stp6c1.Enable = 'off';
        handles.stp7c1.Enable = 'on';
    case 2
        handles.stp0c1.Enable = 'on';
        handles.stp1c1.Enable = 'off';
        handles.stp2c1.Enable = 'on';
        handles.stp3c1.Enable = 'on';
        handles.stp4c1.Enable = 'off';
        handles.stp5c1.Enable = 'off';
        handles.stp6c1.Enable = 'on';
        handles.stp7c1.Enable = 'on';        
    case 3
        handles.stp0c1.Enable = 'on';
        handles.stp1c1.Enable = 'on';
        handles.stp2c1.Enable = 'on';
        handles.stp3c1.Enable = 'on';
        handles.stp4c1.Enable = 'off';
        handles.stp5c1.Enable = 'off';
        handles.stp6c1.Enable = 'off';
        handles.stp7c1.Enable = 'on';        
    case 4
        handles.stp0c1.Enable = 'on';
        handles.stp1c1.Enable = 'off';
        handles.stp2c1.Enable = 'off';
        handles.stp3c1.Enable = 'off';
        handles.stp4c1.Enable = 'on';
        handles.stp5c1.Enable = 'on';
        handles.stp6c1.Enable = 'on';
        handles.stp7c1.Enable = 'on';        
    case 5
        handles.stp0c1.Enable = 'on';
        handles.stp1c1.Enable = 'on';
        handles.stp2c1.Enable = 'off';
        handles.stp3c1.Enable = 'off';
        handles.stp4c1.Enable = 'on';
        handles.stp5c1.Enable = 'on';
        handles.stp6c1.Enable = 'off';
        handles.stp7c1.Enable = 'on';        
    case 6
        handles.stp0c1.Enable = 'on';
        handles.stp1c1.Enable = 'off';
        handles.stp2c1.Enable = 'on';
        handles.stp3c1.Enable = 'off';
        handles.stp4c1.Enable = 'on';
        handles.stp5c1.Enable = 'off';
        handles.stp6c1.Enable = 'on';
        handles.stp7c1.Enable = 'on';        
    case 7
        handles.stp0c1.Enable = 'on';
        handles.stp1c1.Enable = 'on';
        handles.stp2c1.Enable = 'on';
        handles.stp3c1.Enable = 'on';
        handles.stp4c1.Enable = 'on';
        handles.stp5c1.Enable = 'on';
        handles.stp6c1.Enable = 'on';
        handles.stp7c1.Enable = 'on';        
end

function slot0_Callback(hObject, eventdata, handles)
t = get(handles.conn, 'UserData');
slotupdate(hObject, eventdata, handles)
[slot, thisslot] = getslot(hObject, eventdata, handles);
if strcmp(class(t{slot+1}), 'tcpip')
    if strcmp(t{slot+1}.status, 'open')
%         disp(['Slot ', num2str(slot), ' is already open'])
        set(thisslot, 'ForegroundColor', [0,.8,0]);
        set(handles.connectbutton, 'BackgroundColor', [.94,.94,.94]);
        return
    else
        set(handles.connectbutton, 'BackgroundColor', [1,0,0]);
    end
else
    set(handles.connectbutton, 'BackgroundColor', [1,0,0]);
end
function slot1_Callback(hObject, eventdata, handles)
t = get(handles.conn, 'UserData');
slotupdate(hObject, eventdata, handles)
[slot, thisslot] = getslot(hObject, eventdata, handles);
if strcmp(class(t{slot+1}), 'tcpip')
    if strcmp(t{slot+1}.status, 'open')
%         disp(['Slot ', num2str(slot), ' is already open'])
        set(thisslot, 'ForegroundColor', [0,.8,0]);
        set(handles.connectbutton, 'BackgroundColor', [.94,.94,.94]);
        return
    else
        set(handles.connectbutton, 'BackgroundColor', [1,0,0]);
    end
else
    set(handles.connectbutton, 'BackgroundColor', [1,0,0]);
end
function slot2_Callback(hObject, eventdata, handles)
t = get(handles.conn, 'UserData');
slotupdate(hObject, eventdata, handles)
[slot, thisslot] = getslot(hObject, eventdata, handles);
if strcmp(class(t{slot+1}), 'tcpip')
    if strcmp(t{slot+1}.status, 'open')
%         disp(['Slot ', num2str(slot), ' is already open'])
        set(thisslot, 'ForegroundColor', [0,.8,0]);
        set(handles.connectbutton, 'BackgroundColor', [.94,.94,.94]);
        return
    else
        set(handles.connectbutton, 'BackgroundColor', [1,0,0]);
    end
else
    set(handles.connectbutton, 'BackgroundColor', [1,0,0]);
end
function slot3_Callback(hObject, eventdata, handles)
t = get(handles.conn, 'UserData');
slotupdate(hObject, eventdata, handles)
[slot, thisslot] = getslot(hObject, eventdata, handles);
if strcmp(class(t{slot+1}), 'tcpip')
    if strcmp(t{slot+1}.status, 'open')
%         disp(['Slot ', num2str(slot), ' is already open'])
        set(thisslot, 'ForegroundColor', [0,.8,0]);
        set(handles.connectbutton, 'BackgroundColor', [.94,.94,.94]);
        return
    else
        set(handles.connectbutton, 'BackgroundColor', [1,0,0]);
    end
else
    set(handles.connectbutton, 'BackgroundColor', [1,0,0]);
end
function slot4_Callback(hObject, eventdata, handles)
t = get(handles.conn, 'UserData');
slotupdate(hObject, eventdata, handles)
[slot, thisslot] = getslot(hObject, eventdata, handles);
if strcmp(class(t{slot+1}), 'tcpip')
    if strcmp(t{slot+1}.status, 'open')
%         disp(['Slot ', num2str(slot), ' is already open'])
        set(thisslot, 'ForegroundColor', [0,.8,0]);
        set(handles.connectbutton, 'BackgroundColor', [.94,.94,.94]);
        return
    else
        set(handles.connectbutton, 'BackgroundColor', [1,0,0]);
    end
else
    set(handles.connectbutton, 'BackgroundColor', [1,0,0]);
end
function slot5_Callback(hObject, eventdata, handles)
t = get(handles.conn, 'UserData');
slotupdate(hObject, eventdata, handles)
[slot, thisslot] = getslot(hObject, eventdata, handles);
if strcmp(class(t{slot+1}), 'tcpip')
    if strcmp(t{slot+1}.status, 'open')
%         disp(['Slot ', num2str(slot), ' is already open'])
        set(thisslot, 'ForegroundColor', [0,.8,0]);
        set(handles.connectbutton, 'BackgroundColor', [.94,.94,.94]);
        return
    else
        set(handles.connectbutton, 'BackgroundColor', [1,0,0]);
    end
else
    set(handles.connectbutton, 'BackgroundColor', [1,0,0]);
end

function slotupdate(hObject, eventdata, handles)
update_FPA_values(hObject, eventdata, handles)
update_CFR_values(hObject, eventdata, handles)
copyfromboxc0_Callback(hObject, eventdata, handles)
copyfromboxc1_Callback(hObject, eventdata, handles)

function savevalues_Callback(hObject, eventdata, handles)
%save the wokrspace for loading later
assignin('base','FreqChan0',handles.freq0.UserData);
assignin('base','FreqChan1',handles.freq1.UserData);
assignin('base','PhaseChan0',handles.phase0.UserData);
assignin('base','PhaseChan1',handles.phase1.UserData);
assignin('base','AmpChan0',handles.amp0.UserData);
assignin('base','AmpChan1',handles.amp1.UserData);
assignin('base','CFR1c0',handles.CFR1c0.UserData);
assignin('base','CFR2c0',handles.CFR2c0.UserData);
assignin('base','CFR1c1',handles.CFR1c1.UserData);
assignin('base','CFR2c1',handles.CFR2c1.UserData);
assignin('base','SweepTableS0C0',handles.swtabs0c0.Data);
function loadvalues_Callback(hObject, eventdata, handles)
% read from matlab's workspace
f0data=evalin('base','FreqChan0');
f1data=evalin('base','FreqChan1');
p0data=evalin('base','PhaseChan0');
p1data=evalin('base','PhaseChan1');
a0data=evalin('base','AmpChan0');
a1data=evalin('base','AmpChan1');
CFR1c0data = evalin('base','CFR1c0');
CFR2c0data = evalin('base','CFR2c0');
CFR1c1data = evalin('base','CFR1c1');
CFR2c1data = evalin('base','CFR2c1');
SweepTableS0C0 = evalin('base','SweepTableS0C0');

handles.freq0.UserData = f0data;
handles.freq1.UserData = f1data;
handles.phase0.UserData = p0data;
handles.phase1.UserData = p1data;
handles.amp0.UserData = a0data;
handles.amp1.UserData = a1data;
handles.CFR1c0.UserData = CFR1c0data;
handles.CFR2c0.UserData = CFR2c0data;
handles.CFR1c1.UserData = CFR1c1data;
handles.CFR2c1.UserData = CFR2c1data;
handles.swtabs0c0.Data = SweepTableS0C0 ;

function relockphasebutton_Callback(hObject, eventdata, handles)
[slot, thisslot] = getslot(hObject, eventdata, handles);

handles.cfr1b11c0.Value = 1;
handles.cfr1b11c1.Value = 1;
[CFR1c0, CFR2c0] = generate_CFR_c0(hObject, eventdata, handles);
[CFR1c1, CFR2c1] = generate_CFR_c1(hObject, eventdata, handles);

thisslot.UserData = setCFRreg(thisslot.UserData,0,1,CFR1c0);
thisslot.UserData = setCFRreg(thisslot.UserData,0,2,CFR2c0);
thisslot.UserData = setCFRreg(thisslot.UserData,1,1,CFR1c1);
thisslot.UserData = setCFRreg(thisslot.UserData,1,2,CFR2c1);
thisslot.UserData = flexupdateboth(thisslot.UserData);

handles.cfr1b11c0.Value = 0;
handles.cfr1b11c1.Value = 0;
[CFR1c0, CFR2c0] = generate_CFR_c0(hObject, eventdata, handles);
[CFR1c1, CFR2c1] = generate_CFR_c1(hObject, eventdata, handles);

thisslot.UserData = setCFRreg(thisslot.UserData,0,1,CFR1c0);
thisslot.UserData = setCFRreg(thisslot.UserData,0,2,CFR2c0);
thisslot.UserData = setCFRreg(thisslot.UserData,1,1,CFR1c1);
thisslot.UserData = setCFRreg(thisslot.UserData,1,2,CFR2c1);

% Gotta figure this out %
% thisslot.UserData = waitForEvent(thisslot.UserData,2,2);
% thisslot.UserData = waitns(thisslot.UserData,0,24);
% thisslot.UserData = waitns(thisslot.UserData,1,500);
thisslot.UserData = waitforRackA(thisslot.UserData,2);

thisslot.UserData = flexupdateboth(thisslot.UserData);
newstack(hObject, eventdata, handles);

function CFR1c0_Callback(hObject, eventdata, handles)
[slot, ~] = getslot(hObject, eventdata, handles);
data = handles.CFR1c0.UserData;
data{slot+1} = handles.CFR1c0.String;
handles.CFR1c0.UserData  =  data;
copyfromboxc0_Callback(hObject, eventdata, handles)
function CFR2c0_Callback(hObject, eventdata, handles)
[slot, ~] = getslot(hObject, eventdata, handles);
data = handles.CFR2c0.UserData;
data{slot+1} = handles.CFR2c0.String;
handles.CFR2c0.UserData  =  data;
copyfromboxc0_Callback(hObject, eventdata, handles)
function CFR1c1_Callback(hObject, eventdata, handles)
[slot, ~] = getslot(hObject, eventdata, handles);
data = handles.CFR1c1.UserData;
data{slot+1} = handles.CFR1c1.String;
handles.CFR1c1.UserData  =  data;
copyfromboxc1_Callback(hObject, eventdata, handles)
function CFR2c1_Callback(hObject, eventdata, handles)
[slot, ~] = getslot(hObject, eventdata, handles);
data = handles.CFR2c1.UserData;
data{slot+1} = handles.CFR2c1.String;
handles.CFR2c1.UserData  =  data;
copyfromboxc1_Callback(hObject, eventdata, handles)

function setboth0_Callback(hObject, eventdata, handles)
setboth(hObject, eventdata, handles)
function setboth1_Callback(hObject, eventdata, handles)
setboth(hObject, eventdata, handles)
function setboth(hObject, eventdata, handles)
[CFR1c0, CFR2c0] = generate_CFR_c0(hObject, eventdata, handles);
[CFR1c1, CFR2c1] = generate_CFR_c1(hObject, eventdata, handles);
handles.CFR1c0.String = CFR1c0;
handles.CFR2c0.String = CFR2c0;
handles.CFR1c1.String = CFR1c1;
handles.CFR2c1.String = CFR2c1;

[slot, thisslot] = getslot(hObject, eventdata, handles);

data1c0 = handles.CFR1c0.UserData;
data1c0{slot+1} = handles.CFR1c0.String;
handles.CFR1c0.UserData  =  data1c0;

data2c0 = handles.CFR2c0.UserData;
data2c0{slot+1} = handles.CFR2c0.String;
handles.CFR2c0.UserData  =  data2c0;

data1c1 = handles.CFR1c1.UserData;
data1c1{slot+1} = handles.CFR1c1.String;
handles.CFR1c1.UserData  =  data1c1;

data2c1 = handles.CFR2c1.UserData;
data2c1{slot+1} = handles.CFR2c1.String;
handles.CFR2c1.UserData  =  data2c1;

thisslot.UserData = setCFRreg(thisslot.UserData,0,1,CFR1c0);
thisslot.UserData = setCFRreg(thisslot.UserData,0,2,CFR2c0);
thisslot.UserData = setCFRreg(thisslot.UserData,1,1,CFR1c1);
thisslot.UserData = setCFRreg(thisslot.UserData,1,2,CFR2c1);
thisslot.UserData = flexupdateboth(thisslot.UserData);
newstack(hObject, eventdata, handles);

function staticsetcfr0_Callback(hObject, eventdata, handles)
setcfrc0_Callback(hObject, eventdata, handles)
function staticsetcfr1_Callback(hObject, eventdata, handles)
setcfrc1_Callback(hObject, eventdata, handles)
function staticsetbothcfr_Callback(hObject, eventdata, handles)
setboth(hObject, eventdata, handles)

function setcfrc0_Callback(hObject, eventdata, handles)
[CFR1c0, CFR2c0] = generate_CFR_c0(hObject, eventdata, handles);
handles.CFR1c0.String = CFR1c0;
handles.CFR2c0.String = CFR2c0;
CFR1c0_Callback(hObject, eventdata, handles)
CFR2c0_Callback(hObject, eventdata, handles)

[slot, thisslot] = getslot(hObject, eventdata, handles);
data1c0 = handles.CFR1c0.UserData;
data1c0{slot+1} = CFR1c0;
handles.CFR1c0.UserData  =  data1c0;
data2c0 = handles.CFR2c0.UserData;
data2c0{slot+1} = CFR2c0;
handles.CFR2c0.UserData  =  data2c0;

thisslot.UserData = setCFRreg(thisslot.UserData,0,1,CFR1c0);
thisslot.UserData = setCFRreg(thisslot.UserData,0,2,CFR2c0);
thisslot.UserData = flexupdateone(thisslot.UserData,0);
newstack(hObject, eventdata, handles);
function setcfrc1_Callback(hObject, eventdata, handles)
[CFR1c1, CFR2c1] = generate_CFR_c1(hObject, eventdata, handles);
handles.CFR1c1.String = CFR1c1;
handles.CFR2c1.String = CFR2c1;
CFR1c1_Callback(hObject, eventdata, handles)
CFR2c1_Callback(hObject, eventdata, handles)

[slot, thisslot] = getslot(hObject, eventdata, handles);
data1c1 = handles.CFR1c1.UserData;
data1c1{slot+1} = CFR1c1;
handles.CFR1c1.UserData  =  data1c1;
data2c1 = handles.CFR2c1.UserData;
data2c1{slot+1} = CFR2c1;
handles.CFR2c1.UserData  =  data2c1;

thisslot.UserData = setCFRreg(thisslot.UserData,1,1,CFR1c1);
thisslot.UserData = setCFRreg(thisslot.UserData,1,2,CFR2c1);
thisslot.UserData = flexupdateone(thisslot.UserData,1);
newstack(hObject, eventdata, handles);

function openCFRpanel_Callback(hObject, eventdata, handles)
thepos = handles.CFRpanel.OuterPosition;
if thepos(1) > 0
    thepos(1) = 0;
    handles.CFRpanel.OuterPosition = thepos;
    handles.openCFRpanel.String = 'Hide CFR''s';
elseif thepos(1) ==0
    thepos(1) = 130;
    handles.CFRpanel.OuterPosition = thepos;
    handles.openCFRpanel.String = 'Edit CFR''s';
end

function [CFR1, CFR2] = generate_CFR_c0(hObject, eventdata, handles)
switch handles.cfr1RAMdestc0.Value
    case 1
        RAM30 = 0;
        RAM29 = 0;
    case 2
        RAM30 = 0;
        RAM29 = 1;
    case 3
        RAM30 = 1;
        RAM29 = 0;
    case 4
        RAM30 = 1;
        RAM29 = 1;
end
switch handles.cfr2DRGdestc0.Value
    case 1
        DRG21 = 0;
        DRG20 = 0;
    case 2
        DRG21 = 0;
        DRG20 = 1;
    case 3
        DRG21 = 1;
        DRG20 = 0;
end

rawCFR1 = [...
handles.cfr1b31c0.Value == 1 ,...
RAM30, RAM29, 0, 0, 0, 0, 0, ...    %RAMDEST, then open 28:24
handles.cfr1b23c0.Value == 1 ,...
handles.cfr1b22c0.Value == 1 ,...
0,...                               % 21 is open 
handles.cfr1b20c0.Value == 1 ,...
handles.cfr1b19c0.Value == 1 ,...
handles.cfr1b18c0.Value == 1 ,...
handles.cfr1b17c0.Value == 1 ,...
handles.cfr1b16c0.Value == 1 ,...
handles.cfr1b15c0.Value == 1 ,...
handles.cfr1b14c0.Value == 1 ,...
handles.cfr1b13c0.Value == 1 ,...
handles.cfr1b12c0.Value == 1 ,...
handles.cfr1b11c0.Value == 1 ,...
handles.cfr1b10c0.Value == 1 ,...
handles.cfr1b9c0.Value  == 1 ,...
handles.cfr1b8c0.Value  == 1 ,...
0,0,0,0,0,0,1,0];                   % fixed 7:0
CFR1 = binaryVectorToHex(rawCFR1);

rawCFR2 = [...
0,0,0,0,0,0,0,...
handles.cfr2b24c0.Value == 1 ,...
0, 1, DRG21 , DRG20 , ...               % Fixed, and Ramp Dest
handles.cfr2b19c0.Value == 1 ,...
handles.cfr2b18c0.Value == 1 ,...
handles.cfr2b17c0.Value == 1 ,...
handles.cfr2b16c0.Value == 1 ,...
handles.cfr2b15c0.Value == 1 ,...
handles.cfr2b14c0.Value == 1 ,...
0,0,1,0,0,0,...                                 % open, fixed, open
handles.cfr2b7c0.Value == 1 ,...
handles.cfr2b6c0.Value == 1 ,...
0,...
handles.cfr2b4c0.Value == 1 ,...
handles.cfr2b3c0.Value == 1 ,...
handles.cfr2b2c0.Value == 1 ,...
handles.cfr2b1c0.Value == 1 ,...
handles.cfr2b0c0.Value == 1 ];
CFR2 = binaryVectorToHex(rawCFR2);
function [CFR1, CFR2] = generate_CFR_c1(hObject, eventdata, handles)
switch handles.cfr1RAMdestc1.Value
    case 1
        RAM30 = 0;
        RAM29 = 0;
    case 2
        RAM30 = 0;
        RAM29 = 1;
    case 3
        RAM30 = 1;
        RAM29 = 0;
    case 4
        RAM30 = 1;
        RAM29 = 1;
end
switch handles.cfr2DRGdestc1.Value
    case 1
        DRG21 = 0;
        DRG20 = 0;
    case 2
        DRG21 = 0;
        DRG20 = 1;
    case 3
        DRG21 = 1;
        DRG20 = 0;
end

rawCFR1 = [...
handles.cfr1b31c1.Value == 1 ,...
RAM30, RAM29, 0, 0, 0, 0, 0, ...    %RAMDEST, then open 28:24
handles.cfr1b23c1.Value == 1 ,...
handles.cfr1b22c1.Value == 1 ,...
0,...                               % 21 is open 
handles.cfr1b20c1.Value == 1 ,...
handles.cfr1b19c1.Value == 1 ,...
handles.cfr1b18c1.Value == 1 ,...
handles.cfr1b17c1.Value == 1 ,...
handles.cfr1b16c1.Value == 1 ,...
handles.cfr1b15c1.Value == 1 ,...
handles.cfr1b14c1.Value == 1 ,...
handles.cfr1b13c1.Value == 1 ,...
handles.cfr1b12c1.Value == 1 ,...
handles.cfr1b11c1.Value == 1 ,...
handles.cfr1b10c1.Value == 1 ,...
handles.cfr1b9c1.Value  == 1 ,...
handles.cfr1b8c1.Value  == 1 ,...
0,0,0,0,0,0,1,0];                   % fixed 7:0
CFR1 = binaryVectorToHex(rawCFR1);

rawCFR2 = [...
0,0,0,0,0,0,0,...
handles.cfr2b24c1.Value == 1 ,...
0, 1, DRG21 , DRG20 , ...               % Fixed, and Ramp Dest
handles.cfr2b19c1.Value == 1 ,...
handles.cfr2b18c1.Value == 1 ,...
handles.cfr2b17c1.Value == 1 ,...
handles.cfr2b16c1.Value == 1 ,...
handles.cfr2b15c1.Value == 1 ,...
handles.cfr2b14c1.Value == 1 ,...
0,0,1,0,0,0,...                                 % open, fixed, open
handles.cfr2b7c1.Value == 1 ,...
handles.cfr2b6c1.Value == 1 ,...
0,...
handles.cfr2b4c1.Value == 1 ,...
handles.cfr2b3c1.Value == 1 ,...
handles.cfr2b2c1.Value == 1 ,...
handles.cfr2b1c1.Value == 1 ,...
handles.cfr2b0c1.Value == 1 ];
CFR2 = binaryVectorToHex(rawCFR2);

function copy1to0_Callback(hObject, eventdata, handles)
handles.cfr1RAMdestc0.Value = handles.cfr1RAMdestc1.Value;
handles.cfr2DRGdestc0.Value = handles.cfr2DRGdestc1.Value;
handles.cfr1b31c0.Value = handles.cfr1b31c1.Value;
handles.cfr1b23c0.Value = handles.cfr1b23c1.Value;
handles.cfr1b22c0.Value = handles.cfr1b22c1.Value;
handles.cfr1b20c0.Value = handles.cfr1b20c1.Value;
handles.cfr1b19c0.Value = handles.cfr1b19c1.Value;
handles.cfr1b18c0.Value = handles.cfr1b18c1.Value;
handles.cfr1b17c0.Value = handles.cfr1b17c1.Value;
handles.cfr1b16c0.Value = handles.cfr1b16c1.Value;
handles.cfr1b15c0.Value = handles.cfr1b15c1.Value;
handles.cfr1b14c0.Value = handles.cfr1b14c1.Value;
handles.cfr1b13c0.Value = handles.cfr1b13c1.Value;
handles.cfr1b15c0.Value = handles.cfr1b15c1.Value;
handles.cfr1b11c0.Value = handles.cfr1b11c1.Value;
handles.cfr1b10c0.Value = handles.cfr1b10c1.Value;
handles.cfr1b9c0.Value = handles.cfr1b9c1.Value;
handles.cfr1b8c0.Value = handles.cfr1b8c1.Value;

handles.cfr2b24c0.Value = handles.cfr2b24c1.Value;
handles.cfr2b19c0.Value = handles.cfr2b19c1.Value;
handles.cfr2b18c0.Value = handles.cfr2b18c1.Value;
handles.cfr2b17c0.Value = handles.cfr2b17c1.Value;
handles.cfr2b16c0.Value = handles.cfr2b16c1.Value;
handles.cfr2b15c0.Value = handles.cfr2b15c1.Value;
handles.cfr2b14c0.Value = handles.cfr2b14c1.Value ;
handles.cfr2b7c0.Value = handles.cfr2b7c1.Value;
handles.cfr2b6c0.Value = handles.cfr2b6c1.Value;
handles.cfr2b4c0.Value = handles.cfr2b4c1.Value;
handles.cfr2b3c0.Value = handles.cfr2b3c1.Value;
handles.cfr2b2c0.Value = handles.cfr2b2c1.Value;
handles.cfr2b1c0.Value = handles.cfr2b1c1.Value;
handles.cfr2b0c0.Value = handles.cfr2b0c1.Value;
function copy0to1_Callback(hObject, eventdata, handles)
handles.cfr1RAMdestc1.Value = handles.cfr1RAMdestc0.Value;
handles.cfr2DRGdestc1.Value = handles.cfr2DRGdestc0.Value;
handles.cfr1b31c1.Value = handles.cfr1b31c0.Value;
handles.cfr1b23c1.Value = handles.cfr1b23c0.Value;
handles.cfr1b22c1.Value = handles.cfr1b22c0.Value;
handles.cfr1b20c1.Value = handles.cfr1b20c0.Value;
handles.cfr1b19c1.Value = handles.cfr1b19c0.Value;
handles.cfr1b18c1.Value = handles.cfr1b18c0.Value;
handles.cfr1b17c1.Value = handles.cfr1b17c0.Value;
handles.cfr1b16c1.Value = handles.cfr1b16c0.Value;
handles.cfr1b15c1.Value = handles.cfr1b15c0.Value;
handles.cfr1b14c1.Value = handles.cfr1b14c0.Value;
handles.cfr1b13c1.Value = handles.cfr1b13c0.Value;
handles.cfr1b15c1.Value = handles.cfr1b15c0.Value;
handles.cfr1b11c1.Value = handles.cfr1b11c0.Value;
handles.cfr1b10c1.Value = handles.cfr1b10c0.Value;
handles.cfr1b9c1.Value = handles.cfr1b9c0.Value;
handles.cfr1b8c1.Value = handles.cfr1b8c0.Value;

handles.cfr2b24c1.Value = handles.cfr2b24c0.Value;
handles.cfr2b19c1.Value = handles.cfr2b19c0.Value;
handles.cfr2b18c1.Value = handles.cfr2b18c0.Value;
handles.cfr2b17c1.Value = handles.cfr2b17c0.Value;
handles.cfr2b16c1.Value = handles.cfr2b16c0.Value;
handles.cfr2b15c1.Value = handles.cfr2b15c0.Value;
handles.cfr2b14c1.Value = handles.cfr2b14c0.Value ;
handles.cfr2b7c1.Value = handles.cfr2b7c0.Value;
handles.cfr2b6c1.Value = handles.cfr2b6c0.Value;
handles.cfr2b4c1.Value = handles.cfr2b4c0.Value;
handles.cfr2b3c1.Value = handles.cfr2b3c0.Value;
handles.cfr2b2c1.Value = handles.cfr2b2c0.Value;
handles.cfr2b1c1.Value = handles.cfr2b1c0.Value;
handles.cfr2b0c1.Value = handles.cfr2b0c0.Value;

function copyfromboxc0_Callback(hObject, eventdata, handles)
binCFR1 = hex2bin(handles.CFR1c0.String);
binCFR2 = hex2bin(handles.CFR2c0.String);
if ~binCFR1(32-30) && ~binCFR1(32-29)       %% 00 -> freq 
    handles.cfr1RAMdestc0.Value = 1;
elseif ~binCFR1(32-30) && binCFR1(32-29)    %% 01 -> phase 
    handles.cfr1RAMdestc0.Value = 2;
elseif binCFR1(32-30) && ~binCFR1(32-29)    %% 10 -> amp
    handles.cfr1RAMdestc0.Value = 3;
elseif binCFR1(32-30) && binCFR1(32-29)     %% 11 -> polar
    handles.cfr1RAMdestc0.Value = 4;
end

if ~binCFR2(32-21) && ~binCFR2(32-20)       %% 00 -> freq 
    handles.cfr2DRGdestc0.Value = 1;
elseif ~binCFR2(32-21) && binCFR2(32-20)    %% 01 -> phase 
    handles.cfr2DRGdestc0.Value = 2;
elseif binCFR2(32-21) && ~binCFR2(32-20)    %% 10 -> amp
    handles.cfr2DRGdestc0.Value = 3;
elseif binCFR2(32-21) && binCFR2(32-20)     %% 11 -> amp
    handles.cfr2DRGdestc0.Value = 3;
end
handles.cfr1b31c0.Value = binCFR1(32-31); 
handles.cfr1b23c0.Value = binCFR1(32-23) ;
handles.cfr1b22c0.Value = binCFR1(32-22) ;
handles.cfr1b20c0.Value = binCFR1(32-20) ;
handles.cfr1b19c0.Value = binCFR1(32-19) ;
handles.cfr1b18c0.Value = binCFR1(32-18) ;
handles.cfr1b17c0.Value = binCFR1(32-17) ;
handles.cfr1b16c0.Value = binCFR1(32-16) ;
handles.cfr1b15c0.Value = binCFR1(32-15) ;
handles.cfr1b14c0.Value = binCFR1(32-14) ;
handles.cfr1b13c0.Value = binCFR1(32-13) ;
handles.cfr1b12c0.Value = binCFR1(32-12) ;
handles.cfr1b11c0.Value = binCFR1(32-11) ;
handles.cfr1b10c0.Value = binCFR1(32-10) ;
handles.cfr1b9c0.Value  = binCFR1(32-9) ;
handles.cfr1b8c0.Value  = binCFR1(32-8) ;

handles.cfr2b24c0.Value = binCFR2(32-24) ;
handles.cfr2b19c0.Value = binCFR2(32-19) ;
handles.cfr2b18c0.Value = binCFR2(32-18) ;
handles.cfr2b17c0.Value = binCFR2(32-17) ;
handles.cfr2b16c0.Value = binCFR2(32-16) ;
handles.cfr2b15c0.Value = binCFR2(32-15) ;
handles.cfr2b14c0.Value = binCFR2(32-14) ;
handles.cfr2b7c0.Value = binCFR2(32-7) ;
handles.cfr2b6c0.Value = binCFR2(32-6) ;
handles.cfr2b4c0.Value = binCFR2(32-4) ;
handles.cfr2b3c0.Value = binCFR2(32-3) ;
handles.cfr2b2c0.Value = binCFR2(32-2) ;
handles.cfr2b1c0.Value = binCFR2(32-1) ;
handles.cfr2b0c0.Value = binCFR2(32-0) ;
function copyfromboxc1_Callback(hObject, eventdata, handles)
binCFR1 = hex2bin(handles.CFR1c1.String);
binCFR2 = hex2bin(handles.CFR2c1.String);
if ~binCFR1(32-30) && ~binCFR1(32-29)       %% 00 -> freq 
    handles.cfr1RAMdestc1.Value = 1;
elseif ~binCFR1(32-30) && binCFR1(32-29)    %% 01 -> phase 
    handles.cfr1RAMdestc1.Value = 2;
elseif binCFR1(32-30) && ~binCFR1(32-29)    %% 10 -> amp
    handles.cfr1RAMdestc1.Value = 3;
elseif binCFR1(32-30) && binCFR1(32-29)     %% 11 -> polar
    handles.cfr1RAMdestc1.Value = 4;
end

if ~binCFR2(32-21) && ~binCFR2(32-20)       %% 00 -> freq 
    handles.cfr2DRGdestc1.Value = 1;
elseif ~binCFR2(32-21) && binCFR2(32-20)    %% 01 -> phase 
    handles.cfr2DRGdestc1.Value = 2;
elseif binCFR2(32-21) && ~binCFR2(32-20)    %% 10 -> amp
    handles.cfr2DRGdestc1.Value = 3;
elseif binCFR2(32-21) && binCFR2(32-20)     %% 11 -> amp
    handles.cfr2DRGdestc1.Value = 3;
end
handles.cfr1b31c1.Value = binCFR1(32-31); 
handles.cfr1b23c1.Value = binCFR1(32-23) ;
handles.cfr1b22c1.Value = binCFR1(32-22) ;
handles.cfr1b20c1.Value = binCFR1(32-20) ;
handles.cfr1b19c1.Value = binCFR1(32-19) ;
handles.cfr1b18c1.Value = binCFR1(32-18) ;
handles.cfr1b17c1.Value = binCFR1(32-17) ;
handles.cfr1b16c1.Value = binCFR1(32-16) ;
handles.cfr1b15c1.Value = binCFR1(32-15) ;
handles.cfr1b14c1.Value = binCFR1(32-14) ;
handles.cfr1b13c1.Value = binCFR1(32-13) ;
handles.cfr1b12c1.Value = binCFR1(32-12) ;
handles.cfr1b11c1.Value = binCFR1(32-11) ;
handles.cfr1b10c1.Value = binCFR1(32-10) ;
handles.cfr1b9c1.Value  = binCFR1(32-9) ;
handles.cfr1b8c1.Value  = binCFR1(32-8) ;

handles.cfr2b24c1.Value = binCFR2(32-24) ;
handles.cfr2b19c1.Value = binCFR2(32-19) ;
handles.cfr2b18c1.Value = binCFR2(32-18) ;
handles.cfr2b17c1.Value = binCFR2(32-17) ;
handles.cfr2b16c1.Value = binCFR2(32-16) ;
handles.cfr2b15c1.Value = binCFR2(32-15) ;
handles.cfr2b14c1.Value = binCFR2(32-14) ;
handles.cfr2b7c1.Value = binCFR2(32-7) ;
handles.cfr2b6c1.Value = binCFR2(32-6) ;
handles.cfr2b4c1.Value = binCFR2(32-4) ;
handles.cfr2b3c1.Value = binCFR2(32-3) ;
handles.cfr2b2c1.Value = binCFR2(32-2) ;
handles.cfr2b1c1.Value = binCFR2(32-1) ;
handles.cfr2b0c1.Value = binCFR2(32-0) ;

function stp6c1_Callback(hObject, eventdata, handles)
handles.lastprofc1.Enable = 'off';
handles.nextprofc1.Enable = 'off';
handles.bothlastprof.Enable = 'off';
handles.bothnextprof.Enable = 'off';
update_FPA_values(hObject, eventdata, handles)
function stp5c1_Callback(hObject, eventdata, handles)
handles.lastprofc1.Enable = 'off';
handles.nextprofc1.Enable = 'off';
handles.bothlastprof.Enable = 'off';
handles.bothnextprof.Enable = 'off';
update_FPA_values(hObject, eventdata, handles)
function stp7c1_Callback(hObject, eventdata, handles)
handles.lastprofc1.Enable = 'off';
handles.nextprofc1.Enable = 'off';
handles.bothlastprof.Enable = 'off';
handles.bothnextprof.Enable = 'off';
update_FPA_values(hObject, eventdata, handles)
function stp3c1_Callback(hObject, eventdata, handles)
handles.lastprofc1.Enable = 'off';
handles.nextprofc1.Enable = 'off';
handles.bothlastprof.Enable = 'off';
handles.bothnextprof.Enable = 'off';
update_FPA_values(hObject, eventdata, handles)
function stp2c1_Callback(hObject, eventdata, handles)
handles.lastprofc1.Enable = 'off';
handles.nextprofc1.Enable = 'off';
handles.bothlastprof.Enable = 'off';
handles.bothnextprof.Enable = 'off';
update_FPA_values(hObject, eventdata, handles)
function stp1c1_Callback(hObject, eventdata, handles)
handles.lastprofc1.Enable = 'off';
handles.nextprofc1.Enable = 'off';
handles.bothlastprof.Enable = 'off';
handles.bothnextprof.Enable = 'off';
update_FPA_values(hObject, eventdata, handles)
function stp0c1_Callback(hObject, eventdata, handles)
handles.lastprofc1.Enable = 'off';
handles.nextprofc1.Enable = 'off';
handles.bothlastprof.Enable = 'off';
handles.bothnextprof.Enable = 'off';
update_FPA_values(hObject, eventdata, handles)
function stp4c1_Callback(hObject, eventdata, handles)
handles.lastprofc1.Enable = 'off';
handles.nextprofc1.Enable = 'off';
handles.bothlastprof.Enable = 'off';
handles.bothnextprof.Enable = 'off';
update_FPA_values(hObject, eventdata, handles)
function stp6c0_Callback(hObject, eventdata, handles)
handles.lastprofc0.Enable = 'off';
handles.nextprofc0.Enable = 'off';
handles.bothlastprof.Enable = 'off';
handles.bothnextprof.Enable = 'off';
update_FPA_values(hObject, eventdata, handles)
function stp5c0_Callback(hObject, eventdata, handles)
handles.lastprofc0.Enable = 'off';
handles.nextprofc0.Enable = 'off';
handles.bothlastprof.Enable = 'off';
handles.bothnextprof.Enable = 'off';
update_FPA_values(hObject, eventdata, handles)
function stp4c0_Callback(hObject, eventdata, handles)
handles.lastprofc0.Enable = 'off';
handles.nextprofc0.Enable = 'off';
handles.bothlastprof.Enable = 'off';
handles.bothnextprof.Enable = 'off';
update_FPA_values(hObject, eventdata, handles)
function stp7c0_Callback(hObject, eventdata, handles)
handles.lastprofc0.Enable = 'off';
handles.nextprofc0.Enable = 'off';
handles.bothlastprof.Enable = 'off';
handles.bothnextprof.Enable = 'off';
update_FPA_values(hObject, eventdata, handles)
function stp3c0_Callback(hObject, eventdata, handles)
handles.lastprofc0.Enable = 'off';
handles.nextprofc0.Enable = 'off';
handles.bothlastprof.Enable = 'off';
handles.bothnextprof.Enable = 'off';
update_FPA_values(hObject, eventdata, handles)
function stp2c0_Callback(hObject, eventdata, handles)
handles.lastprofc0.Enable = 'off';
handles.nextprofc0.Enable = 'off';
handles.bothlastprof.Enable = 'off';
handles.bothnextprof.Enable = 'off';
update_FPA_values(hObject, eventdata, handles)
function stp1c0_Callback(hObject, eventdata, handles)
handles.lastprofc0.Enable = 'off';
handles.nextprofc0.Enable = 'off';
handles.bothlastprof.Enable = 'off';
handles.bothnextprof.Enable = 'off';
update_FPA_values(hObject, eventdata, handles)
function stp0c0_Callback(hObject, eventdata, handles)
handles.lastprofc0.Enable = 'off';
handles.nextprofc0.Enable = 'off';
handles.bothlastprof.Enable = 'off';
handles.bothnextprof.Enable = 'off';
update_FPA_values(hObject, eventdata, handles)

function deletebutt_Callback(hObject, eventdata, handles)
slot = handles.slotnum.Value-1;
chan = handles.channum.Value-1;
table = gettable(hObject, eventdata, handles, slot, chan);
data = table.Data;
numrows = size(data,1);
if numrows == 1; return; end
row = handles.rownum.Value;
data(row,:) = [];
table.Data = data;
rownum_Callback(hObject, eventdata, handles)

function blankabove_Callback(hObject, eventdata, handles)
slot = handles.slotnum.Value-1;
chan = handles.channum.Value-1;
table = gettable(hObject, eventdata, handles, slot, chan);
data = table.Data;
row = handles.rownum.Value;
data(row+1:end+1,:) = data(row:end,:);
data(row,:) = {[]};
table.Data = data;
handles.rownum.Value = handles.rownum.Value + 1;
rownum_Callback(hObject, eventdata, handles)
function rampabove_Callback(hObject, eventdata, handles)
slot = handles.slotnum.Value-1;
chan = handles.channum.Value-1;
table = gettable(hObject, eventdata, handles, slot, chan);
data = table.Data;
row = handles.rownum.Value;
data(row+1:end+1,:) = data(row:end,:);
data(row,:) = {'ramp';'freq';'';'';'';'';'';'';''};
table.Data = data;
handles.rownum.Value = handles.rownum.Value + 1;
rownum_Callback(hObject, eventdata, handles)
function trigabove_Callback(hObject, eventdata, handles)
slot = handles.slotnum.Value-1;
chan = handles.channum.Value-1;
table = gettable(hObject, eventdata, handles, slot, chan);
data = table.Data;
row = handles.rownum.Value;
data(row+1:end+1,:) = data(row:end,:);
data(row,:) = {'wait';'rackA';'';'';'';'';'';'';''};
table.Data = data;
handles.rownum.Value = handles.rownum.Value + 1;
rownum_Callback(hObject, eventdata, handles)

function blankbelow_Callback(hObject, eventdata, handles)
slot = handles.slotnum.Value-1;
chan = handles.channum.Value-1;
table = gettable(hObject, eventdata, handles, slot, chan);
data = table.Data;
row = handles.rownum.Value;
data(row+2:end+1,:) = data(row+1:end,:);
data(row+1,:) = {[]};
table.Data = data;
rownum_Callback(hObject, eventdata, handles)
function rampbelow_Callback(hObject, eventdata, handles)
slot = handles.slotnum.Value-1;
chan = handles.channum.Value-1;
table = gettable(hObject, eventdata, handles, slot, chan);
data = table.Data;
row = handles.rownum.Value;
data(row+2:end+1,:) = data(row+1:end,:);
data(row+1,:) = {'ramp';'freq';'';'';'';'';'';'';''};
table.Data = data;
rownum_Callback(hObject, eventdata, handles)
function trigbelow_Callback(hObject, eventdata, handles)
slot = handles.slotnum.Value-1;
chan = handles.channum.Value-1;
table = gettable(hObject, eventdata, handles, slot, chan);
data = table.Data;
row = handles.rownum.Value;
data(row+2:end+1,:) = data(row+1:end,:);
data(row+1,:) = {'wait';'rackA';'';'';'';'';'';'';''};
table.Data = data;
rownum_Callback(hObject, eventdata, handles)

function copyto_Callback(hObject, eventdata, handles)
fromslot = handles.slotnum.Value-1;
fromchan = handles.channum.Value-1;
fromline = handles.rownum.Value;
fromtable = gettable(hObject, eventdata, handles, fromslot, fromchan);
toslot = handles.slotnumto.Value-1;
tochan = handles.channumto.Value-1;
toline = handles.copydest.Value;
totable = gettable(hObject, eventdata, handles, toslot, tochan);

fromdata = fromtable.Data;
todata = totable.Data;
todata(toline,:) = fromdata(fromline,:);
totable.Data = todata;

function copytable_Callback(hObject, eventdata, handles)
fromslot = handles.slotnum.Value-1;
fromchan = handles.channum.Value-1;
fromtable = gettable(hObject, eventdata, handles, fromslot, fromchan);
toslot = handles.slotnumto.Value-1;
tochan = handles.channumto.Value-1;
totable = gettable(hObject, eventdata, handles, toslot, tochan);

totable.Data = fromtable.Data;

function rownum_Callback(hObject, eventdata, handles)
slot = handles.slotnum.Value-1;
chan = handles.channum.Value-1;
table = gettable(hObject, eventdata, handles, slot, chan);
data = table.Data;
numrows = size(data,1);
if handles.rownum.Value == numrows && handles.rownum.Value ~= 1
    handles.rownum.Value = handles.rownum.Value - 1;
end

for r = 1:1:numrows
    if r < 10
        rowlist(r,:) = ['  ',num2str(r)];
    elseif r < 100
        rowlist(r,:) = [' ',num2str(r)];
    else
        rowlist(r,:) = num2str(r);
    end     % call me if it's >1k
end
handles.rownum.String = rowlist;

function copydest_Callback(hObject, eventdata, handles)
slot = handles.slotnumto.Value-1;
chan = handles.channumto.Value-1;
table = gettable(hObject, eventdata, handles, slot, chan);
data = table.Data;
numrows = size(data,1);
if handles.copydest.Value == numrows && handles.copydest.Value ~= 1
    handles.copydest.Value = handles.copydest.Value - 1;
end

for r = 1:1:numrows
    if r < 10
        rowlist(r,:) = ['  ',num2str(r)];
    elseif r < 100
        rowlist(r,:) = [' ',num2str(r)];
    else
        rowlist(r,:) = num2str(r);
    end     % call me if it's >1k
end
handles.copydest.String = rowlist;

function swtabs0c0_CellEditCallback(hObject, eventdata, handles)
rownum_Callback(hObject, eventdata, handles);


assignin('base', 'sweeptable', handles.swtabs0c0.Data)
assignin('base', 'tablenames', handles.swtabs0c0.ColumnName)

function edittable_Callback(hObject, eventdata, handles)
thepos = handles.tableeditpanel.Position;
if thepos(1) > 100
    thepos(1) = 20;
    handles.tableeditpanel.Position = thepos;
    handles.edittable.String = 'Hide Table Edits';
else
    thepos(1) = 130;
    handles.tableeditpanel.Position = thepos;
    handles.edittable.String = 'Edit Tables';
end


function [slot, thisslot] = getslot(~, ~, handles)
    if get(handles.slot0, 'Value')
        slot=0;
        thisslot = handles.slot0;
    elseif(get(handles.slot1, 'Value'))
        slot=1;
        thisslot = handles.slot1;
    elseif(get(handles.slot2, 'Value'))
        slot=2;
        thisslot = handles.slot2;
    elseif(get(handles.slot3, 'Value'))
        slot=3;
        thisslot = handles.slot3;
    elseif(get(handles.slot4, 'Value'))
        slot=4;
        thisslot = handles.slot4;
    elseif(get(handles.slot5, 'Value'))
        slot=5;
        thisslot = handles.slot5;
    else
        return
    end
function [prof, thisprof] = getprof0(~, ~, handles)
    if get(handles.stp0c0, 'Value')
        prof=0;
        thisprof = handles.stp0c0;
    elseif(get(handles.stp1c0, 'Value'))
        prof=1;
        thisprof = handles.stp1c0;
    elseif(get(handles.stp2c0, 'Value'))
        prof=2;
        thisprof = handles.stp2c0;
    elseif(get(handles.stp3c0, 'Value'))
        prof=3;
        thisprof = handles.stp3c0;
    elseif(get(handles.stp4c0, 'Value'))
        prof=4;
        thisprof = handles.stp4c0;
    elseif(get(handles.stp5c0, 'Value'))
        prof=5;
        thisprof = handles.stp5c0;
    elseif(get(handles.stp6c0, 'Value'))
        prof=6;
        thisprof = handles.stp6c0;
    elseif(get(handles.stp7c0, 'Value'))
        prof=7;
        thisprof = handles.stp7c0;
    else
        return
    end
function [prof, thisprof] = getprof1(~, ~, handles)
    if get(handles.stp0c1, 'Value')
        prof=0;
        thisprof = handles.stp0c1;
    elseif(get(handles.stp1c1, 'Value'))
        prof=1;
        thisprof = handles.stp1c1;
    elseif(get(handles.stp2c1, 'Value'))
        prof=2;
        thisprof = handles.stp2c1;
    elseif(get(handles.stp3c1, 'Value'))
        prof=3;
        thisprof = handles.stp3c1;
    elseif(get(handles.stp4c1, 'Value'))
        prof=4;
        thisprof = handles.stp4c1;
    elseif(get(handles.stp5c1, 'Value'))
        prof=5;
        thisprof = handles.stp5c1;
    elseif(get(handles.stp6c1, 'Value'))
        prof=6;
        thisprof = handles.stp6c1;
    elseif(get(handles.stp7c1, 'Value'))
        prof=7;
        thisprof = handles.stp7c1;
    else
        return
    end
function [profc0, profc1] = getprofhfromnum(num, handles)
    switch num
        case 0
            profc0 = handles.stp0c0;
            profc1 = handles.stp0c1;
        case 1
            profc0 = handles.stp1c0;
            profc1 = handles.stp1c1;
        case 2
            profc0 = handles.stp2c0;
            profc1 = handles.stp3c1;
        case 3
            profc0 = handles.stp3c0;
            profc1 = handles.stp3c1;
        case 4
            profc0 = handles.stp4c0;
            profc1 = handles.stp4c1;
        case 5
            profc0 = handles.stp5c0;
            profc1 = handles.stp5c1;
        case 6
            profc0 = handles.stp6c0;
            profc1 = handles.stp6c1;
        case 7
            profc0 = handles.stp7c0;
            profc1 = handles.stp7c1;
        case 8
            profc0 = handles.stp8c0;
            profc1 = handles.stp8c1;
    end
function slotnum_Callback(hObject, eventdata, handles)
rownum_Callback(hObject, eventdata, handles)
function channum_Callback(hObject, eventdata, handles)
rownum_Callback(hObject, eventdata, handles)
function slotnumto_Callback(hObject, eventdata, handles)
copydest_Callback(hObject, eventdata, handles)
function channumto_Callback(hObject, eventdata, handles)
copydest_Callback(hObject, eventdata, handles)

function tableeditpanel_CreateFcn(hObject, eventdata, handles)

function thetable = gettable(hObject, eventdata, handles, slot, chan)
switch slot
    case 0 
        switch chan
            case 0
                thetable = handles.swtabs0c0;
            case 1
                thetable = handles.swtabs0c1;
        end
    case 1
        switch chan
            case 0
                thetable = handles.swtabs1c0;
            case 1
                thetable = handles.swtabs1c1;
        end
    case 2
        switch chan
            case 0
                thetable = handles.swtabs2c0;
            case 1
                thetable = handles.swtabs2c1;
        end
    case 3
        switch chan
            case 0
                thetable = handles.swtabs3c0;
            case 1
                thetable = handles.swtabs3c1;
        end
    case 4
        switch chan
            case 0
                thetable = handles.swtabs4c0;
            case 1
                thetable = handles.swtabs4c1;
        end
    case 5
        switch chan
            case 0
                thetable = handles.swtabs5c0;
            case 1
                thetable = handles.swtabs5c1;
        end
end

function newstack(hObject, eventdata, handles)
    handles.flush.BackgroundColor    = [1 1 0];
    handles.flushall.BackgroundColor = [1 1 0];

function help_Callback(hObject, eventdata, handles)
