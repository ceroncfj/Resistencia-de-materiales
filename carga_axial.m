function varargout = carga_axial(varargin)
% CARGA_AXIAL MATLAB code for carga_axial.fig
%      CARGA_AXIAL, by itself, creates a new CARGA_AXIAL or raises the existing
%      singleton*.
%
%      H = CARGA_AXIAL returns the handle to a new CARGA_AXIAL or the handle to
%      the existing singleton*.
%
%      CARGA_AXIAL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CARGA_AXIAL.M with the given input arguments.
%
%      CARGA_AXIAL('Property','Value',...) creates a new CARGA_AXIAL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before carga_axial_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to carga_axial_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help carga_axial

% Last Modified by GUIDE v2.5 30-Sep-2020 18:29:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @carga_axial_OpeningFcn, ...
                   'gui_OutputFcn',  @carga_axial_OutputFcn, ...
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


% --- Executes just before carga_axial is made visible.
function carga_axial_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to carga_axial (see VARARGIN)

% Choose default command line output for carga_axial
handles.output = hObject;
A={30e3 true 0.25 0.03 'Diametro' 200e9;
    40e3 true 0.30 0.05 'Diametro' 105e9};
columnname={'Fuerza', 'Fza. Positiva', 'Longitud', 'Diametro' 'Diametro/Area' 'Elasticidad'};
columnformat={'numeric', 'logical', 'numeric', 'numeric', {'Diametro' 'Area'}, 'numeric'};
columneditable= [true true true true true true];
set(handles.uitable1, 'Data', A, 'ColumnName', columnname, ...
    'ColumnFormat', columnformat, 'FontSize', 16,...
    'ColumnWidth', {85 85 85 85 120 120}, 'FontWeight', 'bold',...
    'ColumnEditable', columneditable, 'RowName', [])

guidata(hObject, handles);

function varargout = carga_axial_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;


function pushbutton1_Callback(hObject, eventdata, handles)
M=get(handles.uitable1, 'data');
sf=0; sd=0;
for k=1:size(M,1)
    sf=sf+ [M(k,1)]; R(k,1)=sf;
    a=pi*[M{k,4}]^2/4; R(k,2)=a;
    d=R(k,1)* [M{k,3}]/(a*[M{k,6}]); R(k,3)=d;
    sd=sd+d; R(k,4)=sd;
    s=R(k,1)/a; R(k,5)=s;
end

set(handles.uitable2, 'data', R, 'Fontsize', 16,...
    'ColumnWidth', {100 100 100 120 120}, 'FontWeight', 'bold', ...
    'ColumnName', {'Fuerza total' 'Area''deformacion''def. acumnulada''Esfuerzo'});



% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1
