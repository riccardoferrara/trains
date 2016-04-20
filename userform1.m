function varargout = userform1(varargin)
%USERFORM1 M-file for userform1.fig
%      USERFORM1, by itself, creates a new USERFORM1 or raises the existing
%      singleton*.
%
%      H = USERFORM1 returns the handle to a new USERFORM1 or the handle to
%      the existing singleton*.
%
%      USERFORM1('Property','Value',...) creates a new USERFORM1 using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to userform1_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      USERFORM1('CALLBACK') and USERFORM1('CALLBACK',hObject,...) call the
%      local function named CALLBACK in USERFORM1.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help userform1

% Last Modified by GUIDE v2.5 09-Dec-2011 10:39:43

% Begin initialization code - DO NOT EDIT


gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @userform1_OpeningFcn, ...
                   'gui_OutputFcn',  @userform1_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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


% --- Executes just before userform1 is made visible.
function userform1_OpeningFcn(hObject, ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for userform1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes userform1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = userform1_OutputFcn(~, ~, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function STEPS_Callback(~, ~, ~)
% hObject    handle to STEPS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of STEPS as text
%        str2double(get(hObject,'String')) returns contents of STEPS as a double


% --- Executes during object creation, after setting all properties.
function STEPS_CreateFcn(hObject, ~, ~)
% hObject    handle to STEPS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on velocita and none of its controls.
function velocita_Callback(~, ~, handles)
% hObject    handle to velocita (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

%ricalcolo intervallo dt
V = get(handles.velocita,'String');
V = str2double(V)/3.6; %da km/h a m/s
d = get(handles.DiscretizzazioneCorta,'String');
d = str2double(d);
Lc = str2double(get(handles.Lcorta,'String'));
dt = Lc/V/d/1000; %è /1000 per passare Lc da mm a m
set(handles.intervallo, 'string', dt);
interasse = str2double(get(handles.InterasseTraverse,'string'))/100;

%ricalcolo STEPS
treno = get(handles.treno,'value');
if treno == 1, load matrici_veicolo_ALn668, end
if treno == 2, load matrici_veicolo_TGV, end
if treno == 3, load matrici_veicolo_ETR500, end
if treno == 4, load matrici_veicolo_X-2000, end
if treno == 5, load matrici_veicolo_dong, end
if treno == 6, load matrici_veicolo_nelsen, end
if treno == 7, load matrici_veicolo_manchester_benchmark, end
if treno == 8, load matrici_veicolo_ALn668-2, end
if treno == 9, load matrici_veicolo_vehicle, end

dt = str2double(get(handles.intervallo,'String'));
V = str2double(get(handles.velocita,'String'))/3.6;
interasse = str2double(get(handles.InterasseTraverse,'string'))/100;
Lsimulazione = str2double(get(handles.Lunghezza,'string'));
Lsimulazione = round(Lsimulazione/interasse)*interasse;
T_preload = str2double(get(handles.T_preload,'string'));
steps = round((Lsimulazione-distanze_ruote(4)-0.5)/V/dt)+round(T_preload/dt);
set(handles.STEPS,'string',steps)


% --- Executes on key press with focus on Lunghezza and none of its controls.
function Lunghezza_Callback(~, ~, handles)
% hObject    handle to Lunghezza (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

%ricalcolo STEPS
treno = get(handles.treno,'value');
if treno == 1, load matrici_veicolo_ALn668, end
if treno == 2, load matrici_veicolo_TGV, end
if treno == 3, load matrici_veicolo_ETR500, end
if treno == 4, load matrici_veicolo_X-2000, end
if treno == 5, load matrici_veicolo_dong, end
if treno == 6, load matrici_veicolo_nelsen, end
if treno == 7, load matrici_veicolo_manchester_benchmark, end
if treno == 8, load matrici_veicolo_ALn668-2, end
if treno == 9, load matrici_veicolo_vehicle, end


dt = str2double(get(handles.intervallo,'String'));
V = str2double(get(handles.velocita,'String'))/3.6;
interasse = str2double(get(handles.InterasseTraverse,'string'))/100;
Lsimulazione = str2double(get(handles.Lunghezza,'string'));
Lsimulazione = round(Lsimulazione/interasse)*interasse;
T_preload = str2double(get(handles.T_preload,'string'));
steps = round((Lsimulazione-distanze_ruote(4)-0.5)/V/dt)+round(T_preload/dt);
set(handles.STEPS,'string',steps)


% --- Executes on key press with focus on Lcorta and none of its controls.
function Lcorta_Callback(~, ~, handles)
% hObject    handle to Lcorta (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

%ricalcolo intervallo dt
V = get(handles.velocita,'String');
V = str2double(V)/3.6; %da km/h a m/s
d = get(handles.DiscretizzazioneCorta,'String');
d = str2double(d);
Lc = str2double(get(handles.Lcorta,'String'));
dt = Lc/V/d/1000; %è /1000 per passare Lc da mm a m
set(handles.intervallo, 'string', dt);
interasse = str2double(get(handles.InterasseTraverse,'string'))/100;

%ricalcolo STEPS
treno = get(handles.treno,'value');
if treno == 1, load matrici_veicolo_ALn668, end
if treno == 2, load matrici_veicolo_TGV, end
if treno == 3, load matrici_veicolo_ETR500, end
if treno == 4, load matrici_veicolo_X-2000, end
if treno == 5, load matrici_veicolo_dong, end
if treno == 6, load matrici_veicolo_nelsen, end
if treno == 7, load matrici_veicolo_manchester_benchmark, end
if treno == 8, load matrici_veicolo_ALn668-2, end
if treno == 9, load matrici_veicolo_vehicle, end

Lsimulazione = str2double(get(handles.Lunghezza,'string'));
Lsimulazione = round(Lsimulazione/interasse)*interasse;
T_preload = str2double(get(handles.T_preload,'string'));
steps = round((Lsimulazione-distanze_ruote(4)-0.5)/V/dt)+round(T_preload/dt);
set(handles.STEPS,'string',steps)


% --- Executes on key press with focus on DiscretizzazioneCorta and none of its controls.
function DiscretizzazioneCorta_Callback(~, ~, handles)
% hObject    handle to DiscretizzazioneCorta (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

%ricalcolo intervallo dt
V = get(handles.velocita,'String');
V = str2double(V)/3.6; %da km/h a m/s
d = get(handles.DiscretizzazioneCorta,'String');
d = str2double(d);
Lc = str2double(get(handles.Lcorta,'String'));
dt = Lc/V/d/1000; %è /1000 per passare Lc da mm a m
set(handles.intervallo, 'string', dt);
interasse = str2double(get(handles.InterasseTraverse,'string'))/100;

%ricalcolo STEPS
treno = get(handles.treno,'value');
if treno == 1, load matrici_veicolo_ALn668, end
if treno == 2, load matrici_veicolo_TGV, end
if treno == 3, load matrici_veicolo_ETR500, end
if treno == 4, load matrici_veicolo_X-2000, end
if treno == 5, load matrici_veicolo_dong, end
if treno == 6, load matrici_veicolo_nelsen, end
if treno == 7, load matrici_veicolo_manchester_benchmark, end
if treno == 8, load matrici_veicolo_ALn668-2, end
if treno == 9, load matrici_veicolo_vehicle, end


Lsimulazione = str2double(get(handles.Lunghezza,'string'));
Lsimulazione = round(Lsimulazione/interasse)*interasse;
T_preload = str2double(get(handles.T_preload,'string'));
steps = round((Lsimulazione-distanze_ruote(4)-0.5)/V/dt)+round(T_preload/dt);
set(handles.STEPS,'string',steps)


% --- Executes during object creation, after setting all properties.
function calculate_CreateFcn(~, ~, handles)
% hObject    handle to calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on key press with focus on calculate and none of its controls.
function calculate_KeyPressFcn(hObject, eventdata, handles)

% hObject    handle to calculate (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in reset.
function reset_Callback(hObject, eventdata, handles)
% hObject    handle to reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function reset_CreateFcn(hObject, eventdata, handles)
% hObject    handle to reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object deletion, before destroying properties.
function reset_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when selected object is changed in unitgroup.
function unitgroup_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in unitgroup 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)



function delta_Callback(hObject, eventdata, handles)
% hObject    handle to delta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of delta as text
%        str2double(get(hObject,'String')) returns contents of delta as a double
delta = str2double(get(handles.delta,'string'));
alfa = 0.25 * (0.5 + delta) ^ 2;
set(handles.alfaMIN,'string',alfa)

% --- Executes on button press in opzione_deterministica.
function opzione_deterministica_Callback(hObject, eventdata, handles)
% hObject    handle to opzione_deterministica (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    
% Hint: get(hObject,'Value') returns toggle state of opzione_deterministica
opzione_deterministica = get(handles.opzione_deterministica,'value');
if opzione_deterministica == 1;
    set(handles.Acorta, 'enable', 'on')
    set(handles.Amedia, 'enable', 'on')
    set(handles.Alunga, 'enable', 'on')
    set(handles.Lcorta, 'enable', 'on')
    set(handles.Lmedia, 'enable', 'on')
    set(handles.Llunga, 'enable', 'on')
    
    set(handles.grado, 'enable', 'off')
    set(handles.Llower, 'enable', 'off')
    set(handles.Lupper, 'enable', 'off')
    set(handles.N_difetti, 'enable', 'off')
else
    set(handles.Acorta, 'enable', 'off')
    set(handles.Amedia, 'enable', 'off')
    set(handles.Alunga, 'enable', 'off')
    set(handles.Lcorta, 'enable', 'off')
    set(handles.Lmedia, 'enable', 'off')
    set(handles.Llunga, 'enable', 'off')
    
    set(handles.grado, 'enable', 'on')
    set(handles.Llower, 'enable', 'on')
    set(handles.Lupper, 'enable', 'on')
    set(handles.N_difetti, 'enable', 'on')
end



% --- Executes during object creation, after setting all properties.
function delta_CreateFcn(hObject, eventdata, handles)
% hObject    handle to delta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on delta and none of its controls.
function delta_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to delta (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
 
% d = str2double(get(delta,'String'));
% min = 0.25 * (0.5 + d) ^ 2;
% set(handles.alfaMIN, 'string', min);

function alfa_Callback(hObject, eventdata, handles)
% hObject    handle to alfa (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of alfa as text
%        str2double(get(hObject,'String')) returns contents of alfa as a double


% --- Executes during object creation, after setting all properties.
function alfa_CreateFcn(hObject, eventdata, handles)
% hObject    handle to alfa (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function errore_Callback(hObject, eventdata, handles)
% hObject    handle to errore (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of errore as text
%        str2double(get(hObject,'String')) returns contents of errore as a double


% --- Executes during object creation, after setting all properties.
function errore_CreateFcn(hObject, eventdata, handles)
% hObject    handle to errore (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Nmodi_Callback(hObject, eventdata, handles)
% hObject    handle to Nmodi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Nmodi as text
%        str2double(get(hObject,'String')) returns contents of Nmodi as a double


% --- Executes during object creation, after setting all properties.
function Nmodi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Nmodi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function InterasseTraverse_Callback(hObject, eventdata, handles)
% hObject    handle to InterasseTraverse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of InterasseTraverse as text
%        str2double(get(hObject,'String')) returns contents of InterasseTraverse as a double


% --- Executes during object creation, after setting all properties.
function InterasseTraverse_CreateFcn(hObject, eventdata, handles)
% hObject    handle to InterasseTraverse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Acorta_Callback(hObject, eventdata, handles)
% hObject    handle to Acorta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Acorta as text
%        str2double(get(hObject,'String')) returns contents of Acorta as a double


% --- Executes during object creation, after setting all properties.
function Acorta_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Acorta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Amedia_Callback(hObject, eventdata, handles)
% hObject    handle to Amedia (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Amedia as text
%        str2double(get(hObject,'String')) returns contents of Amedia as a double


% --- Executes during object creation, after setting all properties.
function Amedia_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Amedia (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Alunga_Callback(hObject, eventdata, handles)
% hObject    handle to Alunga (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Alunga as text
%        str2double(get(hObject,'String')) returns contents of Alunga as a double


% --- Executes during object creation, after setting all properties.
function Alunga_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Alunga (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes during object creation, after setting all properties.
function Lcorta_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Lcorta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function mr_Callback(hObject, eventdata, handles)
% hObject    handle to mr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mr as text
%        str2double(get(hObject,'String')) returns contents of mr as a double


% --- Executes during object creation, after setting all properties.
function mr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EI_Callback(hObject, eventdata, handles)
% hObject    handle to EI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EI as text
%        str2double(get(hObject,'String')) returns contents of EI as a double


% --- Executes during object creation, after setting all properties.
function EI_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function beams_Callback(hObject, eventdata, handles)
% hObject    handle to beams (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of beams as text
%        str2double(get(hObject,'String')) returns contents of beams as a double


% --- Executes during object creation, after setting all properties.
function beams_CreateFcn(hObject, eventdata, handles)
% hObject    handle to beams (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit50_Callback(hObject, eventdata, handles)
% hObject    handle to InterasseTraverse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of InterasseTraverse as text
%        str2double(get(hObject,'String')) returns contents of InterasseTraverse as a double


% --- Executes during object creation, after setting all properties.
function edit50_CreateFcn(hObject, eventdata, handles)
% hObject    handle to InterasseTraverse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ms_Callback(hObject, eventdata, handles)
% hObject    handle to ms (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ms as text
%        str2double(get(hObject,'String')) returns contents of ms as a double


% --- Executes during object creation, after setting all properties.
function ms_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ms (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function mb_Callback(hObject, eventdata, handles)
% hObject    handle to mb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mb as text
%        str2double(get(hObject,'String')) returns contents of mb as a double


% --- Executes during object creation, after setting all properties.
function mb_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Kb_Callback(hObject, eventdata, handles)
% hObject    handle to Kb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Kb as text
%        str2double(get(hObject,'String')) returns contents of Kb as a double


% --- Executes during object creation, after setting all properties.
function Kb_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Kb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Kp_Callback(hObject, eventdata, handles)
% hObject    handle to Kp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Kp as text
%        str2double(get(hObject,'String')) returns contents of Kp as a double


% --- Executes during object creation, after setting all properties.
function Kp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Kp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Kf_Callback(hObject, eventdata, handles)
% hObject    handle to Kf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Kf as text
%        str2double(get(hObject,'String')) returns contents of Kf as a double


% --- Executes during object creation, after setting all properties.
function Kf_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Kf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Kw_Callback(hObject, eventdata, handles)
% hObject    handle to Kw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Kw as text
%        str2double(get(hObject,'String')) returns contents of Kw as a double


% --- Executes during object creation, after setting all properties.
function Kw_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Kw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Cb_Callback(hObject, eventdata, handles)
% hObject    handle to Cb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Cb as text
%        str2double(get(hObject,'String')) returns contents of Cb as a double


% --- Executes during object creation, after setting all properties.
function Cb_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Cb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Nsaving_steps_Callback(hObject, eventdata, handles)
% hObject    handle to Nsaving_steps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Nsaving_steps as text
%        str2double(get(hObject,'String')) returns contents of Nsaving_steps as a double


% --- Executes during object creation, after setting all properties.
function Nsaving_steps_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Nsaving_steps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Cp_Callback(hObject, eventdata, handles)
% hObject    handle to Cp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Cp as text
%        str2double(get(hObject,'String')) returns contents of Cp as a double


% --- Executes during object creation, after setting all properties.
function Cp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Cp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Cf_Callback(hObject, eventdata, handles)
% hObject    handle to Cf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Cf as text
%        str2double(get(hObject,'String')) returns contents of Cf as a double


% --- Executes during object creation, after setting all properties.
function Cf_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Cf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Cw_Callback(hObject, eventdata, handles)
% hObject    handle to Cw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Cw as text
%        str2double(get(hObject,'String')) returns contents of Cw as a double


% --- Executes during object creation, after setting all properties.
function Cw_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Cw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in solo_modello_veicolo.
function solo_modello_veicolo_Callback(hObject, eventdata, handles)
% hObject    handle to solo_modello_veicolo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of solo_modello_veicolo


% --- Executes on button press in no_difetti.
function no_difetti_Callback(hObject, eventdata, handles)
% hObject    handle to no_difetti (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of no_difetti



function Lnodifetti_Callback(hObject, eventdata, handles)
% hObject    handle to Lnodifetti (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Lnodifetti as text
%        str2double(get(hObject,'String')) returns contents of Lnodifetti as a double


% --- Executes during object creation, after setting all properties.
function Lnodifetti_CreateFcn(hObject, eventdata, ~)
% hObject    handle to Lnodifetti (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Lmedia_Callback(hObject, eventdata, handles)
% hObject    handle to Lmedia (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Lmedia as text
%        str2double(get(hObject,'String')) returns contents of Lmedia as a double


% --- Executes during object creation, after setting all properties.
function Lmedia_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Lmedia (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Llunga_Callback(hObject, eventdata, handles)
% hObject    handle to Llunga (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Llunga as text
%        str2double(get(hObject,'String')) returns contents of Llunga as a double


% --- Executes during object creation, after setting all properties.
function Llunga_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Llunga (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes during object creation, after setting all properties.
function DiscretizzazioneCorta_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DiscretizzazioneCorta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function velocita_CreateFcn(hObject, eventdata, handles)
% hObject    handle to velocita (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes during object creation, after setting all properties.
function Lunghezza_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Lunghezza (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





% --- Executes on selection change in integration_method.
function integration_method_Callback(hObject, eventdata, handles)
% hObject    handle to integration_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns integration_method contents as cell array
%        contents{get(hObject,'Value')} returns selected item from integration_method


% --- Executes during object creation, after setting all properties.
function integration_method_CreateFcn(hObject, eventdata, handles)
% hObject    handle to integration_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% hObject    handle to calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function intervallo_Callback(hObject, eventdata, handles)
% hObject    handle to intervallo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of intervallo as text
%        str2double(get(hObject,'String')) returns contents of intervallo as a double


% --- Executes during object creation, after setting all properties.
function intervallo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to intervallo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





function alfaMIN_Callback(hObject, eventdata, handles)
% hObject    handle to alfaMIN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of alfaMIN as text
%        str2double(get(hObject,'String')) returns contents of alfaMIN as a double


% --- Executes during object creation, after setting all properties.
function alfaMIN_CreateFcn(hObject, eventdata, handles)
% hObject    handle to alfaMIN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Llower_Callback(hObject, eventdata, handles)
% hObject    handle to Llower (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Llower as text
%        str2double(get(hObject,'String')) returns contents of Llower as a double


% --- Executes during object creation, after setting all properties.
function Llower_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Llower (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function N_difetti_Callback(hObject, eventdata, handles)
% hObject    handle to N_difetti (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of N_difetti as text
%        str2double(get(hObject,'String')) returns contents of N_difetti as a double


% --- Executes during object creation, after setting all properties.
function N_difetti_CreateFcn(hObject, eventdata, handles)
% hObject    handle to N_difetti (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Lupper_Callback(hObject, eventdata, handles)
% hObject    handle to Lupper (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Lupper as text
%        str2double(get(hObject,'String')) returns contents of Lupper as a double


% --- Executes during object creation, after setting all properties.
function Lupper_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Lupper (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in grado.
function grado_Callback(hObject, eventdata, handles)
% hObject    handle to grado (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns grado contents as cell array
%        contents{get(hObject,'Value')} returns selected item from grado


% --- Executes during object creation, after setting all properties.
function grado_CreateFcn(hObject, eventdata, handles)
% hObject    handle to grado (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in treno.
function treno_Callback(hObject, eventdata, handles)
% hObject    handle to treno (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns treno contents as cell array
%        contents{get(hObject,'Value')} returns selected item from treno

%ricalcolo STEPS
treno = get(handles.treno,'value');
if treno == 1, load matrici_veicolo_ALn668, end
if treno == 2, load matrici_veicolo_TGV, end
if treno == 3, load matrici_veicolo_ETR500, end
if treno == 4, load matrici_veicolo_X-2000, end
if treno == 5, load matrici_veicolo_dong, end
if treno == 6, load matrici_veicolo_nelsen, end
if treno == 7, load matrici_veicolo_manchester_benchmark, end
if treno == 8, load matrici_veicolo_ALn668-2, end
if treno == 9, load matrici_veicolo_vehicle, end



dt = str2double(get(handles.intervallo,'String'));
V = str2double(get(handles.velocita,'String'))/3.6;
interasse = str2double(get(handles.InterasseTraverse,'string'))/100;
Lsimulazione = str2double(get(handles.Lunghezza,'string'));
Lsimulazione = round(Lsimulazione/interasse)*interasse;
T_preload = str2double(get(handles.T_preload,'string'));
steps = round((Lsimulazione-distanze_ruote(4)-0.5)/V/dt)+round(T_preload/dt);
set(handles.STEPS,'string',steps)

% --- Executes during object creation, after setting all properties.
function treno_CreateFcn(hObject, eventdata, handles)
% hObject    handle to treno (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function chi_Callback(hObject, eventdata, handles)
% hObject    handle to chi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of chi as text
%        str2double(get(hObject,'String')) returns contents of chi as a double


% --- Executes during object creation, after setting all properties.
function chi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to chi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function A_Callback(hObject, eventdata, handles)
% hObject    handle to A (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of A as text
%        str2double(get(hObject,'String')) returns contents of A as a double


% --- Executes during object creation, after setting all properties.
function A_CreateFcn(hObject, eventdata, handles)
% hObject    handle to A (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function I_Callback(hObject, eventdata, handles)
% hObject    handle to I (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of I as text
%        str2double(get(hObject,'String')) returns contents of I as a double


% --- Executes during object creation, after setting all properties.
function I_CreateFcn(hObject, eventdata, handles)
% hObject    handle to I (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in rail.
function rail_Callback(hObject, eventdata, handles)
% hObject    handle to rail (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns rail contents as cell array
%        contents{get(hObject,'Value')} returns selected item from rail
rail = get(handles.rail,'value');
load matrici_rotaie.mat
if rail == 1
    mr = rail_50UNI(1);
    I = rail_50UNI(2);
    A = rail_50UNI(3);
    chi = rail_50UNI(4);
    set(handles.mr,'string',mr)
    set(handles.I,'string',I)
    set(handles.A,'string',A)
    set(handles.chi,'string',chi)
end
if rail == 2
    mr = rail_60UNI(1);
    I = rail_60UNI(2);
    A = rail_60UNI(3);
    chi = rail_60UNI(4);
    set(handles.mr,'string',mr)
    set(handles.I,'string',I)
    set(handles.A,'string',A)
    set(handles.chi,'string',chi)
end
if rail == 3
    mr = rail_56dong(1);
    I = rail_56dong(2);
    A = rail_56dong(3);
    chi = rail_56dong(4);
    set(handles.mr,'string',mr)
    set(handles.I,'string',I)
    set(handles.A,'string',A)
    set(handles.chi,'string',chi)
end


function Pw_Callback(hObject, eventdata, handles)
% hObject    handle to Pw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Pw as text
%        str2double(get(hObject,'String')) returns contents of Pw as a double


% --- Executes during object creation, after setting all properties.
function Pw_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Pw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Pbeams_Callback(hObject, eventdata, handles)
% hObject    handle to Pbeams (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Pbeams as text
%        str2double(get(hObject,'String')) returns contents of Pbeams as a double


% --- Executes during object creation, after setting all properties.
function Pbeams_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Pbeams (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function rail_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rail (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function T_preload_Callback(hObject, eventdata, handles)
% hObject    handle to T_preload (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of T_preload as text
%        str2double(get(hObject,'String')) returns contents of T_preload as a double
%ricalcolo intervallo dt
V = get(handles.velocita,'String');
V = str2double(V)/3.6; %da km/h a m/s
d = get(handles.DiscretizzazioneCorta,'String');
d = str2double(d);
Lc = str2double(get(handles.Lcorta,'String'));
dt = Lc/V/d/1000; %è /1000 per passare Lc da mm a m
set(handles.intervallo, 'string', dt);
interasse = str2double(get(handles.InterasseTraverse,'string'))/100;

%ricalcolo STEPS
treno = get(handles.treno,'value');
if treno == 1, load matrici_veicolo_ALn668, end
if treno == 2, load matrici_veicolo_TGV, end
if treno == 3, load matrici_veicolo_ETR500, end
if treno == 4, load matrici_veicolo_X-2000, end
if treno == 5, load matrici_veicolo_dong, end
if treno == 6, load matrici_veicolo_nelsen, end
if treno == 7, load matrici_veicolo_manchester_benchmark, end
if treno == 8, load matrici_veicolo_ALn668-2, end
if treno == 9, load matrici_veicolo_vehicle, end

Lsimulazione = str2double(get(handles.Lunghezza,'string'));
Lsimulazione = round(Lsimulazione/interasse)*interasse;
T_preload = str2double(get(handles.T_preload,'string'));
steps = round((Lsimulazione-distanze_ruote(4)-0.5)/V/dt)+round(T_preload/dt);
set(handles.STEPS,'string',steps)

% --- Executes during object creation, after setting all properties.
function T_preload_CreateFcn(hObject, eventdata, handles)
% hObject    handle to T_preload (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in calculate.
function calculate_Callback(hObject, eventdata, handles)
% hObject    handle to calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


lettura_userform

calcoli_iniziali

[K_rail,C_rail] = FEM_K_C_rail2(K_rail, C_rail, EI, beams, Pbeams, Kp, Cp, interasse, f, fp, l, lp, s, w1, w2);
% K_rail = FEM_K_rail(K_rail, EI, beams, Pbeams, Kp, interasse, f, fp, l, lp, s, w1, w2);


costanti_newmark

matrici_sovrastruttura

costanti_newton_raphson

vettX

inizializzazione_variabili

% deformata_random_parametri
deformata_random_parametri_nielsen2

%iterazioni
lancia_waitbar

figure

performance = zeros(1,steps);

%apro i file su cui scrivere i risultati
Usfile = fopen('Usfile.txt','wt');
Us1file = fopen('Us1file.txt','wt');
Us2file = fopen('Us2file.txt','wt');

for i = 1:steps
    tic
    nuovo_schema_pf
    if getappdata(wait,'canceling')
        break
    end
    performance(i) = toc;
end
delete(wait)

%chiudo i file su cui scrivo i risultati
fclose(Usfile);
fclose(Us1file);
fclose(Us2file);

% USrotaia
% analisi_modale



save matlab.mat

figure
 plot(performance)
%  analisi_sensitivit
% stampa_acc
% visualizza_US
