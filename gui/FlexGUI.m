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

% Last Modified by GUIDE v2.5 13-Sep-2019 19:43:39

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


% --- Executes just before FlexGUI is made visible.
function FlexGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to FlexGUI (see VARARGIN)

% Choose default command line output for FlexGUI
handles.output = hObject;
% 
% handles.tgroup = uitabgroup('Parent', handles.figure1,'TabLocation', 'top');
% handles.tab1 = uitab('Parent', handles.tgroup, 'Title', 'My Tab Label 1');
% handles.tab2 = uitab('Parent', handles.tgroup, 'Title', 'My Tab Label 2');
% handles.tab3 = uitab('Parent', handles.tgroup, 'Title', 'My Tab Label 3');
% %Place panels into each tab
% set(handles.p1,'Parent',handles.tab1)
% set(handles.p2,'Parent',handles.tab2)
% set(handles.p3,'Parent',handles.tab3)
% %Reposition each panel to same location as panel 1
% set(handles.p2,'position',get(handles.p1,'position'));
% set(handles.p3,'position',get(handles.p1,'position'));

% set units
unitfreq_Callback(hObject, eventdata, handles)
%load saved data
update_FPA_values(hObject, eventdata, handles)
update_CFR_values(hObject, eventdata, handles)
% Update handles structure
guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = FlexGUI_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;



function iptext_Callback(hObject, eventdata, handles)


function connectbutton_Callback(hObject, eventdata, handles)

[slot, thisslot] = getslot(hObject, eventdata, handles);
% is it already open? 
t = get(handles.conn, 'UserData');
if strcmp(class(t{slot+1}), 'tcpip')
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
    disp(response);
    if strcmp(t{slot+1}.status, 'open')
        set(thisslot, 'ForegroundColor', [0,.8,0]);
        set(handles.connectbutton, 'BackgroundColor', [.94,.94,.94]);
        return
    end
else
    disp('something went wrong.')
end

end



function setbothbutton_Callback(hObject, eventdata, handles)
t = get(handles.conn, 'UserData');
[prof0, profhandle] = getprof0(hObject, eventdata, handles);
[prof1, profhandle] = getprof1(hObject, eventdata, handles);
[slot, thisslot] = getslot(hObject, eventdata, handles);

amp0 = str2double(get(handles.amp0, 'String'));
amp1 = str2double(get(handles.amp1, 'String'));
phase0 = str2double(get(handles.phase0, 'String'));
phase1 = str2double(get(handles.phase1, 'String'));
freq0 = str2double(get(handles.freq0, 'String'))*freqmult(handles);
freq1 = str2double(get(handles.freq1, 'String'))*freqmult(handles);

% twosingletones(t{slot+1}, prof0,amp0,phase0,freq0,amp1,phase1,freq1);
onesingletone(t{slot+1}, 0, prof0, amp0,  phase0, freq0);
onesingletone(t{slot+1}, 1, prof1, amp1,  phase1, freq1);
flexupdateboth(t{slot+1});


handles.lastprofc0.Enable = 'on';
handles.nextprofc0.Enable = 'on';
handles.lastprofc1.Enable = 'on';
handles.nextprofc1.Enable = 'on';

% flexlst(t{slot+1});

function setchan0_Callback(hObject, eventdata, handles)
t = get(handles.conn, 'UserData');
[prof0, profhandle] = getprof0(hObject, eventdata, handles);
[slot, thisslot] = getslot(hObject, eventdata, handles);

amp0 = str2double(get(handles.amp0, 'String'));
phase0 = str2double(get(handles.phase0, 'String'));
freq0 = str2double(get(handles.freq0, 'String'))*freqmult(handles);

onesingletone(t{slot+1}, 0, prof0, amp0,  phase0, freq0);
flexupdateone(t{slot+1}, 0);

handles.lastprofc0.Enable = 'on';
handles.nextprofc0.Enable = 'on';


function setchan1_Callback(hObject, eventdata, handles)
t = get(handles.conn, 'UserData');
[prof1, profhandle] = getprof1(hObject, eventdata, handles);
[slot, thisslot] = getslot(hObject, eventdata, handles);

amp1 = str2double(get(handles.amp1, 'String'));
phase1 = str2double(get(handles.phase1, 'String'));
freq1 = str2double(get(handles.freq1, 'String'))*freqmult(handles);

onesingletone(t{slot+1}, 1, prof1, amp1,  phase1, freq1);
flexupdateone(t{slot+1}, 1);

handles.lastprofc1.Enable = 'on';
handles.nextprofc1.Enable = 'on';


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
    

function slot0_Callback(hObject, eventdata, handles)
t = get(handles.conn, 'UserData');
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
update_FPA_values(hObject, eventdata, handles)
update_CFR_values(hObject, eventdata, handles)
function slot1_Callback(hObject, eventdata, handles)
t = get(handles.conn, 'UserData');
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
update_FPA_values(hObject, eventdata, handles)
update_CFR_values(hObject, eventdata, handles)
function slot2_Callback(hObject, eventdata, handles)
t = get(handles.conn, 'UserData');
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
update_FPA_values(hObject, eventdata, handles)
update_CFR_values(hObject, eventdata, handles)
function slot3_Callback(hObject, eventdata, handles)
t = get(handles.conn, 'UserData');
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
update_FPA_values(hObject, eventdata, handles)
update_CFR_values(hObject, eventdata, handles)
function slot4_Callback(hObject, eventdata, handles)
t = get(handles.conn, 'UserData');
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
update_FPA_values(hObject, eventdata, handles)
update_CFR_values(hObject, eventdata, handles)
function slot5_Callback(hObject, eventdata, handles)
t = get(handles.conn, 'UserData');
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
update_FPA_values(hObject, eventdata, handles)
update_CFR_values(hObject, eventdata, handles)

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
newunit = unitname(handles.unitfreq.Value);
handles.freqtext.String = strcat('Frequency (',newunit,')');

function outmult = freqmult(handles)
power = 10^(3*(handles.unitfreq.Value-1));
multiplier = str2double(handles.multiplier.String);
outmult = multiplier*power;
function timeunit = timemult(handles)
timeunit = 10^(-3*(handles.unittime.Value-1));



function unittime_Callback(hObject, eventdata, handles)
%% change table headers


function nextprofc0_Callback(hObject, eventdata, handles)
t = get(handles.conn, 'UserData');
[slot, thisslot] = getslot(hObject, eventdata, handles);
[prof0, profhandle] = getprof0(hObject, eventdata, handles);
nextprof(t{slot+1}, 0)

switch prof0
    case 0
        handles.stp0c0.Value = 0;
        handles.stp1c0.Value = 1;
    case 1
        handles.stp1c0.Value = 0;
        handles.stp2c0.Value = 1;
    case 2    
        handles.stp2c0.Value = 0;
        handles.stp3c0.Value = 1;
    case 3
        handles.stp3c0.Value = 0;
        handles.stp4c0.Value = 1;
    case 4
        handles.stp4c0.Value = 0;
        handles.stp5c0.Value = 1;
    case 5
        handles.stp5c0.Value = 0;
        handles.stp6c0.Value = 1;
    case 6
        handles.stp6c0.Value = 0;
        handles.stp7c0.Value = 1;
    case 7 
        handles.stp7c0.Value = 0;
        handles.stp0c0.Value = 1;
end
update_FPA_values(hObject, eventdata, handles)
function lastprofc0_Callback(hObject, eventdata, handles)
t = get(handles.conn, 'UserData');
[slot, thisslot] = getslot(hObject, eventdata, handles);
[prof0, profhandle] = getprof0(hObject, eventdata, handles);

lastprof(t{slot+1}, 0)

switch prof0
    case 0
        handles.stp0c0.Value = 0;
        handles.stp7c0.Value = 1;
    case 7
        handles.stp7c0.Value = 0;
        handles.stp6c0.Value = 1;
    case 6    
        handles.stp6c0.Value = 0;
        handles.stp5c0.Value = 1;
    case 5
        handles.stp5c0.Value = 0;
        handles.stp4c0.Value = 1;
    case 4
        handles.stp4c0.Value = 0;
        handles.stp3c0.Value = 1;
    case 3
        handles.stp3c0.Value = 0;
        handles.stp2c0.Value = 1;
    case 2
        handles.stp2c0.Value = 0;
        handles.stp1c0.Value = 1;
    case 1 
        handles.stp1c0.Value = 0;
        handles.stp0c0.Value = 1;
end
update_FPA_values(hObject, eventdata, handles)
function setprofc0_Callback(hObject, eventdata, handles)
t = get(handles.conn, 'UserData');
[slot, thisslot] = getslot(hObject, eventdata, handles);
[prof, profhandle] = getprof0(hObject, eventdata, handles);

setprof(t{slot+1}, 0, prof)

handles.lastprofc0.Enable = 'on';
handles.nextprofc0.Enable = 'on';
update_FPA_values(hObject, eventdata, handles)
function nextprofc1_Callback(hObject, eventdata, handles)
t = get(handles.conn, 'UserData');
[slot, thisslot] = getslot(hObject, eventdata, handles);
[prof1, profhandle] = getprof1(hObject, eventdata, handles);

nextprof(t{slot+1}, 1);
%change radios
switch prof1
    case 0
        handles.stp0c1.Value = 0;
        handles.stp1c1.Value = 1;
    case 1
        handles.stp1c1.Value = 0;
        handles.stp2c1.Value = 1;
    case 2    
        handles.stp2c1.Value = 0;
        handles.stp3c1.Value = 1;
    case 3
        handles.stp3c1.Value = 0;
        handles.stp4c1.Value = 1;
    case 4
        handles.stp4c1.Value = 0;
        handles.stp5c1.Value = 1;
    case 5
        handles.stp5c1.Value = 0;
        handles.stp6c1.Value = 1;
    case 6
        handles.stp6c1.Value = 0;
        handles.stp7c1.Value = 1;
    case 7 
        handles.stp7c1.Value = 0;
        handles.stp0c1.Value = 1;
end
update_FPA_values(hObject, eventdata, handles)
function lastprofc1_Callback(hObject, eventdata, handles)
t = get(handles.conn, 'UserData');
[slot, thisslot] = getslot(hObject, eventdata, handles);
[prof1, profhandle] = getprof1(hObject, eventdata, handles);

lastprof(t{slot+1}, 1)

switch prof1
    case 0
        handles.stp0c1.Value = 0;
        handles.stp7c1.Value = 1;
    case 7
        handles.stp7c1.Value = 0;
        handles.stp6c1.Value = 1;
    case 6    
        handles.stp6c1.Value = 0;
        handles.stp5c1.Value = 1;
    case 5
        handles.stp5c1.Value = 0;
        handles.stp4c1.Value = 1;
    case 4
        handles.stp4c1.Value = 0;
        handles.stp3c1.Value = 1;
    case 3
        handles.stp3c1.Value = 0;
        handles.stp2c1.Value = 1;
    case 2
        handles.stp2c1.Value = 0;
        handles.stp1c1.Value = 1;
    case 1 
        handles.stp1c1.Value = 0;
        handles.stp0c1.Value = 1;
end
update_FPA_values(hObject, eventdata, handles)
function setprofc1_Callback(hObject, eventdata, handles)
t = get(handles.conn, 'UserData');
[slot, thisslot] = getslot(hObject, eventdata, handles);
[prof, profhandle] = getprof1(hObject, eventdata, handles);

setprof(t{slot+1}, 1, prof)
% current prof should already be Radio-filled
% no need to set

handles.lastprofc1.Enable = 'on';
handles.nextprofc1.Enable = 'on';
update_FPA_values(hObject, eventdata, handles)

function bothnextprof_Callback(hObject, eventdata, handles)
nextprofc0_Callback(hObject, eventdata, handles);
nextprofc1_Callback(hObject, eventdata, handles);
function bothlastprof_Callback(hObject, eventdata, handles)
lastprofc0_Callback(hObject, eventdata, handles);
lastprofc1_Callback(hObject, eventdata, handles)
function bothsetprof_Callback(hObject, eventdata, handles)
setprofc0_Callback(hObject, eventdata, handles)
setprofc1_Callback(hObject, eventdata, handles)


function stp6c1_Callback(hObject, eventdata, handles)
handles.lastprofc1.Enable = 'off';
handles.nextprofc1.Enable = 'off';
update_FPA_values(hObject, eventdata, handles)
function stp5c1_Callback(hObject, eventdata, handles)
handles.lastprofc1.Enable = 'off';
handles.nextprofc1.Enable = 'off';
update_FPA_values(hObject, eventdata, handles)
function stp7c1_Callback(hObject, eventdata, handles)
handles.lastprofc1.Enable = 'off';
handles.nextprofc1.Enable = 'off';
update_FPA_values(hObject, eventdata, handles)
function stp3c1_Callback(hObject, eventdata, handles)
handles.lastprofc1.Enable = 'off';
handles.nextprofc1.Enable = 'off';
update_FPA_values(hObject, eventdata, handles)
function stp2c1_Callback(hObject, eventdata, handles)
handles.lastprofc1.Enable = 'off';
handles.nextprofc1.Enable = 'off';
update_FPA_values(hObject, eventdata, handles)
function stp1c1_Callback(hObject, eventdata, handles)
handles.lastprofc1.Enable = 'off';
handles.nextprofc1.Enable = 'off';
update_FPA_values(hObject, eventdata, handles)
function stp0c1_Callback(hObject, eventdata, handles)
handles.lastprofc1.Enable = 'off';
handles.nextprofc1.Enable = 'off';
update_FPA_values(hObject, eventdata, handles)
function stp4c1_Callback(hObject, eventdata, handles)
handles.lastprofc1.Enable = 'off';
handles.nextprofc1.Enable = 'off';
update_FPA_values(hObject, eventdata, handles)


function stp6c0_Callback(hObject, eventdata, handles)
handles.lastprofc0.Enable = 'off';
handles.nextprofc0.Enable = 'off';
update_FPA_values(hObject, eventdata, handles)
function stp5c0_Callback(hObject, eventdata, handles)
handles.lastprofc0.Enable = 'off';
handles.nextprofc0.Enable = 'off';
update_FPA_values(hObject, eventdata, handles)
function stp4c0_Callback(hObject, eventdata, handles)
handles.lastprofc0.Enable = 'off';
handles.nextprofc0.Enable = 'off';
update_FPA_values(hObject, eventdata, handles)
function stp7c0_Callback(hObject, eventdata, handles)
handles.lastprofc0.Enable = 'off';
handles.nextprofc0.Enable = 'off';
update_FPA_values(hObject, eventdata, handles)
function stp3c0_Callback(hObject, eventdata, handles)
handles.lastprofc0.Enable = 'off';
handles.nextprofc0.Enable = 'off';
update_FPA_values(hObject, eventdata, handles)
function stp2c0_Callback(hObject, eventdata, handles)
handles.lastprofc0.Enable = 'off';
handles.nextprofc0.Enable = 'off';
update_FPA_values(hObject, eventdata, handles)
function stp1c0_Callback(hObject, eventdata, handles)
handles.lastprofc0.Enable = 'off';
handles.nextprofc0.Enable = 'off';
update_FPA_values(hObject, eventdata, handles)
function stp0c0_Callback(hObject, eventdata, handles)
handles.lastprofc0.Enable = 'off';
handles.nextprofc0.Enable = 'off';
update_FPA_values(hObject, eventdata, handles)


function multiplier_Callback(hObject, eventdata, handles)


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

function CFR1c0_Callback(hObject, eventdata, handles)
function CFR2c0_Callback(hObject, eventdata, handles)
function CFR1c1_Callback(hObject, eventdata, handles)
function CFR2c1_Callback(hObject, eventdata, handles)


function setcfrc0_Callback(hObject, eventdata, handles)
function setcfrc1_Callback(hObject, eventdata, handles)


function openCFRpanel_Callback(hObject, eventdata, handles)
thepos = handles.CFRpanel.OuterPosition;
thepos(1) = 7;
handles.CFRpanel.OuterPosition = thepos;

function closeCFRpanel_Callback(hObject, eventdata, handles)
thepos = handles.CFRpanel.OuterPosition;
thepos(1) = 130;
handles.CFRpanel.OuterPosition = thepos;


% --- Executes on button press in cfr1b31.
function cfr1b31_Callback(hObject, eventdata, handles)
% hObject    handle to cfr1b31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cfr1b31


% --- Executes on button press in cfr1b30.
function cfr1b30_Callback(hObject, eventdata, handles)
% hObject    handle to cfr1b30 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cfr1b30


% --- Executes on button press in cfr1b29.
function cfr1b29_Callback(hObject, eventdata, handles)
% hObject    handle to cfr1b29 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cfr1b29


% --- Executes on button press in cfr1b23.
function cfr1b23_Callback(hObject, eventdata, handles)
% hObject    handle to cfr1b23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cfr1b23


% --- Executes on button press in cfr1b22.
function cfr1b22_Callback(hObject, eventdata, handles)
% hObject    handle to cfr1b22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cfr1b22


% --- Executes on button press in cfr1b20.
function cfr1b20_Callback(hObject, eventdata, handles)
% hObject    handle to cfr1b20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cfr1b20


% --- Executes on button press in cfr1b19.
function cfr1b19_Callback(hObject, eventdata, handles)
% hObject    handle to cfr1b19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cfr1b19


% --- Executes on button press in cfr1b18.
function cfr1b18_Callback(hObject, eventdata, handles)
% hObject    handle to cfr1b18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cfr1b18


% --- Executes on button press in cfr1b17.
function cfr1b17_Callback(hObject, eventdata, handles)
% hObject    handle to cfr1b17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cfr1b17


% --- Executes on button press in cfr1b16.
function cfr1b16_Callback(hObject, eventdata, handles)
% hObject    handle to cfr1b16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cfr1b16


% --- Executes on button press in cfr1b12.
function cfr1b12_Callback(hObject, eventdata, handles)
% hObject    handle to cfr1b12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cfr1b12


% --- Executes on button press in cfr1b14.
function cfr1b14_Callback(hObject, eventdata, handles)
% hObject    handle to cfr1b14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cfr1b14


% --- Executes on button press in cfr1b13.
function cfr1b13_Callback(hObject, eventdata, handles)
% hObject    handle to cfr1b13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cfr1b13


% --- Executes on button press in cfr1b11.
function cfr1b11_Callback(hObject, eventdata, handles)
% hObject    handle to cfr1b11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cfr1b11


% --- Executes on button press in cfr1b10.
function cfr1b10_Callback(hObject, eventdata, handles)
% hObject    handle to cfr1b10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cfr1b10


% --- Executes on button press in cfr1b9.
function cfr1b9_Callback(hObject, eventdata, handles)
% hObject    handle to cfr1b9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cfr1b9


% --- Executes on button press in cfr1b8.
function cfr1b8_Callback(hObject, eventdata, handles)
% hObject    handle to cfr1b8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cfr1b8


% --- Executes on button press in cfr2b21.
function cfr2b21_Callback(hObject, eventdata, handles)
% hObject    handle to cfr2b21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cfr2b21


% --- Executes on button press in cfr2b20.
function cfr2b20_Callback(hObject, eventdata, handles)
% hObject    handle to cfr2b20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cfr2b20


% --- Executes on button press in cfr2b19.
function cfr2b19_Callback(hObject, eventdata, handles)
% hObject    handle to cfr2b19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cfr2b19


% --- Executes on button press in cfr2b18.
function cfr2b18_Callback(hObject, eventdata, handles)
% hObject    handle to cfr2b18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cfr2b18


% --- Executes on button press in cfr2b17.
function cfr2b17_Callback(hObject, eventdata, handles)
% hObject    handle to cfr2b17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cfr2b17


% --- Executes on button press in cfr2b16.
function cfr2b16_Callback(hObject, eventdata, handles)
% hObject    handle to cfr2b16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cfr2b16


% --- Executes on button press in cfr2b15.
function cfr2b15_Callback(hObject, eventdata, handles)
% hObject    handle to cfr2b15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cfr2b15


% --- Executes on button press in cfr2b14.
function cfr2b14_Callback(hObject, eventdata, handles)
% hObject    handle to cfr2b14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cfr2b14


% --- Executes on button press in cfr2b7.
function cfr2b7_Callback(hObject, eventdata, handles)
% hObject    handle to cfr2b7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cfr2b7


% --- Executes on button press in cfr2b6.
function cfr2b6_Callback(hObject, eventdata, handles)
% hObject    handle to cfr2b6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cfr2b6


% --- Executes on button press in cfr2b4.
function cfr2b4_Callback(hObject, eventdata, handles)
% hObject    handle to cfr2b4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cfr2b4


% --- Executes on button press in cfr2b3.
function cfr2b3_Callback(hObject, eventdata, handles)
% hObject    handle to cfr2b3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cfr2b3


% --- Executes on button press in cfr2b2.
function cfr2b2_Callback(hObject, eventdata, handles)
% hObject    handle to cfr2b2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cfr2b2


% --- Executes on button press in cfr2b1.
function cfr2b1_Callback(hObject, eventdata, handles)
% hObject    handle to cfr2b1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cfr2b1


% --- Executes on button press in cfr2b0.
function cfr2b0_Callback(hObject, eventdata, handles)
% hObject    handle to cfr2b0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cfr2b0



% --- Executes on selection change in cfr1RAMdest.
function cfr1RAMdest_Callback(hObject, eventdata, handles)
% hObject    handle to cfr1RAMdest (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns cfr1RAMdest contents as cell array
%        contents{get(hObject,'Value')} returns selected item from cfr1RAMdest


% --- Executes on button press in cfr2b24.
function cfr2b24_Callback(hObject, eventdata, handles)
% hObject    handle to cfr2b24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cfr2b24
