function varargout = ModeloVisualTEAGui(varargin)
% MODELOVISUALTEAGUI MATLAB code for ModeloVisualTEAGui.fig
%      MODELOVISUALTEAGUI, by itself, creates a new MODELOVISUALTEAGUI or raises the existing
%      singleton*.
%
%      H = MODELOVISUALTEAGUI returns the handle to a new MODELOVISUALTEAGUI or the handle to
%      the existing singleton*.
%
%      MODELOVISUALTEAGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MODELOVISUALTEAGUI.M with the given input arguments.
%
%      MODELOVISUALTEAGUI('Property','Value',...) creates a new MODELOVISUALTEAGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ModeloVisualTEAGui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ModeloVisualTEAGui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ModeloVisualTEAGui

% Last Modified by GUIDE v2.5 27-Jul-2016 20:54:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ModeloVisualTEAGui_OpeningFcn, ...
                   'gui_OutputFcn',  @ModeloVisualTEAGui_OutputFcn, ...
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


% --- Executes just before ModeloVisualTEAGui is made visible.
function ModeloVisualTEAGui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ModeloVisualTEAGui (see VARARGIN)

% Choose default command line output for ModeloVisualTEAGui
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);
% UIWAIT makes ModeloVisualTEAGui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ModeloVisualTEAGui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

function editTeste_Callback(hObject, eventdata, handles)
% hObject    handle to editTeste (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editTeste as text
%        str2double(get(hObject,'String')) returns contents of editTeste as a double


% --- Executes during object creation, after setting all properties.
function editTeste_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editTeste (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in buttonBuscarTeste.
function buttonBuscarTeste_Callback(hObject, eventdata, handles)
% hObject    handle to buttonBuscarTeste (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function editTreinamento_Callback(hObject, eventdata, handles)
% hObject    handle to editTreinamento (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editTreinamento as text
%        str2double(get(hObject,'String')) returns contents of editTreinamento as a double


% --- Executes during object creation, after setting all properties.
function editTreinamento_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editTreinamento (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in buttonBuscarTreinamento.
function buttonBuscarTreinamento_Callback(hObject, eventdata, handles)
% hObject    handle to buttonBuscarTreinamento (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbuttonClassificar.
function pushbuttonClassificar_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonClassificar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in checkboBiological.
function checkboBiological_Callback(hObject, eventdata, handles)
% hObject    handle to checkboBiological (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboBiological


% --- Executes on button press in checkboxOlhaTela.
function checkboxOlhaTela_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxOlhaTela (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxOlhaTela


% --- Executes on button press in checkboxOlhaPandda.
function checkboxOlhaPandda_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxOlhaPandda (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxOlhaPandda


% --- Executes on button press in checkboxApontaPanda.
function checkboxApontaPanda_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxApontaPanda (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxApontaPanda


% --- Executes on button press in checkboxApontaJacare.
function checkboxApontaJacare_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxApontaJacare (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxApontaJacare


% --- Executes on button press in checkboxOlhaJacare.
function checkboxOlhaJacare_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxOlhaJacare (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxOlhaJacare


% --- Executes on button press in checkboxFlorzinha.
function checkboxFlorzinha_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxFlorzinha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxFlorzinha


% --- Executes on button press in checkboxPiramides.
function checkboxPiramides_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxPiramides (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxPiramides


% --- Executes on button press in checkboxCores.
function checkboxCores_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxCores (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxCores


% --- Executes on button press in checkboxTorralba.
function checkboxTorralba_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxTorralba (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxTorralba


% --- Executes on button press in checkboxHorizontal.
function checkboxHorizontal_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxHorizontal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxHorizontal


% --- Executes on button press in checkboxCentro.
function checkboxCentro_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxCentro (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxCentro


% --- Executes on button press in checkboxMovimento.
function checkboxMovimento_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxMovimento (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxMovimento


% --- Executes on button press in checkboxFaces.
function checkboxFaces_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxFaces (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxFaces


% --- Executes on button press in checkboxPessoas.
function checkboxPessoas_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxPessoas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxPessoas


% --- Executes on button press in checkboxIttiIntensity.
function checkboxIttiIntensity_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxIttiIntensity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxIttiIntensity


% --- Executes on button press in checkboxIttiOrientation.
function checkboxIttiOrientation_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxIttiOrientation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxIttiOrientation


% --- Executes on button press in checkboxIttiCor.
function checkboxIttiCor_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxIttiCor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxIttiCor


% --- Executes on button press in checkboxIttiPele.
function checkboxIttiPele_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxIttiPele (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxIttiPele
