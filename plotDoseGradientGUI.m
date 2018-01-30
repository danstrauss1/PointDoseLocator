function varargout = plotDoseGradientGUI(varargin)
% PLOTDOSEGRADIENTGUI MATLAB code for plotDoseGradientGUI.fig
%      PLOTDOSEGRADIENTGUI, by itself, creates a new PLOTDOSEGRADIENTGUI or raises the existing
%      singleton*.
%
%      H = PLOTDOSEGRADIENTGUI returns the handle to a new PLOTDOSEGRADIENTGUI or the handle to
%      the existing singleton*.
%
%      PLOTDOSEGRADIENTGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PLOTDOSEGRADIENTGUI.M with the given input arguments.
%
%      PLOTDOSEGRADIENTGUI('Property','Value',...) creates a new PLOTDOSEGRADIENTGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before plotDoseGradientGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to plotDoseGradientGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help plotDoseGradientGUI

% Last Modified by GUIDE v2.5 09-Feb-2017 13:16:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @plotDoseGradientGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @plotDoseGradientGUI_OutputFcn, ...
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

% --- Executes just before plotDoseGradientGUI is made visible.
function plotDoseGradientGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to plotDoseGradientGUI (see VARARGIN)

% Choose default command line output for plotDoseGradientGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes plotDoseGradientGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


clc;

% --- Outputs from this function are returned to the command line.
function varargout = plotDoseGradientGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function dcmFile_Callback(hObject, eventdata, handles)
% hObject    handle to dcmFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dcmFile as text
%        str2double(get(hObject,'String')) returns contents of dcmFile as a double


% --- Executes during object creation, after setting all properties.
function dcmFile_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dcmFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on button press in MatrixxFlag.
function MatrixxFlag_Callback(hObject, eventdata, handles)
% hObject    handle to MatrixxFlag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of MatrixxFlag
handlesMatrixxFlag = get(hObject,'Value');

% --- Executes on key press with focus on MatrixxFlag and none of its controls.
function MatrixxFlag_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to MatrixxFlag (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in searchFile.
function searchFile_Callback(hObject, eventdata, handles)
% hObject    handle to searchFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
dicom = uigetfile('*.dcm', 'Select DICOM file');
set(handles.filename, 'string', dicom);






% --- Executes on button press in runbtn.
function runbtn_Callback(hObject, eventdata, handles)
% hObject    handle to runbtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


dicom = get(handles.filename,'string');

if (isempty(dicom));
    errordlg('Please select a dicom file', 'File Error');
end


%Run plotDoseGradienTest.m
dose = plotDoseGradientTEST(dicom,0);
format bank;
set(handles.pdTable,'data',dose.lowgradpoints);

%Display Pt information
set(handles.ptID,'string',dose.ptid);
set(handles.ptName,'string',[dose.familyname ', ' dose.givenname]);

axes(handles.histogramplot);
cla;
%Plot histogram of absolute gradient values
title('Histogram of Absolute Gradient Values');
hold on;
ylabel('Count');
xlabel('Gradient Magnitude');
histogram(dose.absGrad);
hold off;








% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over searchFile.
function searchFile_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to searchFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in depthsort.
function depthsort_Callback(hObject, eventdata, handles)
% hObject    handle to depthsort (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

data = get(handles.pdTable,'data');
depthsorted = sortrows(data,2);
set(handles.pdTable,'data',depthsorted);


% --- Executes on button press in gradsort.
function gradsort_Callback(hObject, eventdata, handles)
% hObject    handle to gradsort (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


data = get(handles.pdTable,'data');
gradsorted = sortrows(data,5);
set(handles.pdTable,'data',gradsorted);


% --- Executes on button press in dosesort.
function dosesort_Callback(hObject, eventdata, handles)
% hObject    handle to dosesort (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data = get(handles.pdTable,'data');
dosesorted = sortrows(data,-4);
set(handles.pdTable,'data',dosesorted);

