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

% Last Modified by GUIDE v2.5 15-Aug-2019 19:33:11

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

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes FlexGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = FlexGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
