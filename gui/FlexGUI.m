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

% Last Modified by GUIDE v2.5 11-Sep-2019 17:51:12

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
% Update handles structure
guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = FlexGUI_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;



function iptext_Callback(hObject, eventdata, handles)

function iptext_CreateFcn(hObject, eventdata, handles)
% hObject    handle to iptext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in connectbutton.
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

% if strcmp(response, 'Auth OK')
%     disp(response);
%     if strcmp(t{slot+1}.status, 'open')
%         set(thisslot, 'ForegroundColor', [0,.8,0]);
%         set(handles.connectbutton, 'BackgroundColor', [.94,.94,.94]);
%         return
%     end
% else
%     disp('something went wrong.')
% end

end



function setbothbutton_Callback(hObject, eventdata, handles)
t = get(handles.conn, 'UserData');
[prof, profhandle] = getprof(hObject, eventdata, handles);
[slot, thisslot] = getslot(hObject, eventdata, handles);

amp0 = str2double(get(handles.amp0, 'String'));
amp1 = str2double(get(handles.amp1, 'String'));
phase0 = str2double(get(handles.phase0, 'String'));
phase1 = str2double(get(handles.phase1, 'String'));
freq0 = str2double(get(handles.freq0, 'String'))*freqmult(handles);
freq1 = str2double(get(handles.freq1, 'String'))*freqmult(handles);

twosingletones(t{slot+1}, prof,amp0,phase0,freq0,amp1,phase1,freq1);

% flexlst(t{slot+1});

function setchan0_Callback(hObject, eventdata, handles)
t = get(handles.conn, 'UserData');
[prof, profhandle] = getprof(hObject, eventdata, handles);
[slot, thisslot] = getslot(hObject, eventdata, handles);

amp0 = str2double(get(handles.amp0, 'String'));
phase0 = str2double(get(handles.phase0, 'String'));
freq0 = str2double(get(handles.freq0, 'String'))*freqmult(handles);

onesingletone(t{slot+1}, 0, prof, amp0,  phase0, freq0);

function setchan1_Callback(hObject, eventdata, handles)
t = get(handles.conn, 'UserData');
[prof, profhandle] = getprof(hObject, eventdata, handles);
[slot, thisslot] = getslot(hObject, eventdata, handles);

amp1 = str2double(get(handles.amp1, 'String'));
phase1 = str2double(get(handles.phase1, 'String'));
freq1 = str2double(get(handles.freq1, 'String'))*freqmult(handles);

onesingletone(t{slot+1}, 1, prof, amp1,  phase1, freq1);


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
    
function [prof, thisprof] = getprof(~, ~, handles)
    if get(handles.stp0, 'Value')
        prof=0;
        thisprof = handles.stp0;
    elseif(get(handles.stp1, 'Value'))
        prof=1;
        thisprof = handles.stp1;
    elseif(get(handles.stp2, 'Value'))
        prof=2;
        thisprof = handles.stp2;
    elseif(get(handles.stp3, 'Value'))
        prof=3;
        thisprof = handles.stp3;
    elseif(get(handles.stp4, 'Value'))
        prof=4;
        thisprof = handles.stp4;
    elseif(get(handles.stp5, 'Value'))
        prof=5;
        thisprof = handles.stp5;
    elseif(get(handles.stp6, 'Value'))
        prof=6;
        thisprof = handles.stp6;
    elseif(get(handles.stp7, 'Value'))
        prof=7;
        thisprof = handles.stp7;
    else
        return
    end
    
%% unused callbacks and makefcns 
function slot0_Callback(~, ~, ~)
function slot1_Callback(~, ~, ~)
function slot2_Callback(~, ~, ~)
function slot3_Callback(~, ~, ~)
function slot4_Callback(~, ~, ~)
function slot5_Callback(~, ~, ~)

function freq0_Callback(hObject, eventdata, handles)
function freq0_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function phase0_Callback(hObject, eventdata, handles)
function phase0_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function amp0_Callback(hObject, eventdata, handles)
function amp0_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function freq1_Callback(hObject, eventdata, handles)
function freq1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function phase1_Callback(hObject, eventdata, handles)
function phase1_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function amp1_Callback(hObject, eventdata, handles)
function amp1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when entered data in editable cell(s) in swtab.
function swtab_CellEditCallback(hObject, eventdata, handles)

% assignin('base','table',get(handles.swtab, 'data'));
assignin('base','table',handles.swtab.Data);
assignin('base','element',handles.swtab.Data{2,1});


function unitfreq_Callback(hObject, eventdata, handles)

unitname = {'Hz'; 'kHz'; 'MHz'; 'GHz' };

newunit = unitname(handles.unitfreq.Value);

handles.freqtext.String = strcat('Frequency (',newunit,')');


function power = freqmult(handles)
power = 10^(3*(handles.unitfreq.Value-1));

function power = timemult(handles)
power = 10^(-3*(handles.unittime.Value-1));


% --- Executes during object creation, after setting all properties.
function unitfreq_CreateFcn(hObject, eventdata, handles)
% hObject    handle to unitfreq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in unittime.
function unittime_Callback(hObject, eventdata, handles)
% hObject    handle to unittime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns unittime contents as cell array
%        contents{get(hObject,'Value')} returns selected item from unittime


% --- Executes during object creation, after setting all properties.
function unittime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to unittime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
