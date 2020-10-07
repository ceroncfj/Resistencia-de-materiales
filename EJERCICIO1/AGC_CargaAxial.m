function varargout = AGC_CargaAxial(varargin)
% AGC_CARGAAXIAL MATLAB code for AGC_CargaAxial.fig
%      AGC_CARGAAXIAL, by itself, creates a new AGC_CARGAAXIAL or raises the existing
%      singleton*.
%
%      H = AGC_CARGAAXIAL returns the handle to a new AGC_CARGAAXIAL or the handle to
%      the existing singleton*.
%
%      AGC_CARGAAXIAL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in AGC_CARGAAXIAL.M with the given input arguments.
%
%      AGC_CARGAAXIAL('Property','Value',...) creates a new AGC_CARGAAXIAL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before AGC_CargaAxial_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to AGC_CargaAxial_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help AGC_CargaAxial

% Last Modified by GUIDE v2.5 05-Oct-2020 19:00:57

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @AGC_CargaAxial_OpeningFcn, ...
                   'gui_OutputFcn',  @AGC_CargaAxial_OutputFcn, ...
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


% --- Executes just before AGC_CargaAxial is made visible.
function AGC_CargaAxial_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to AGC_CargaAxial (see VARARGIN)

% Choose default command line output for AGC_CargaAxial
handles.output = hObject;
clc;
A={30e3 true 1 0.3 'Diámetro' 200e9;
   40e3 true 1 0.5 'Diámetro' 105e9;
   40e3 true 1 0.8 'Diámetro' 105e9};
columname = {'Fuerza','Fza.Positiva' 'Longitud' 'Diámetro/Área' 'Diámetro/Área' 'Elasticidad'};
columnformat = {'numeric','logical','numeric','numeric',{'Diámetro' 'Área'},'numeric'};
columneditable = [true true true true true true];
set(handles.uitable1,'Data',A,'ColumnName',columname,...
    'ColumnFormat',columnformat,'FontSize',16,...
    'ColumnWidth',{85 85 85 85 120 120},'FontWeight','bold',...
    'ColumnEditable',columneditable,'RowName',[]);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes AGC_CargaAxial wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = AGC_CargaAxial_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
%M contiene la info de la tabla1
M=get(handles.uitable1,'data');
%Fuerza positiva es tensión, fuerza negativa es compresión.

%Variables necesarias para operaciones
sf=0;sd=0;      %Inicializa suma de fuerzas y de deformaciones
%Variables necesarias para graficar
Q=(0:10:360)';  %Variable para crear cilindros
LongAcum=0;     %Variable para acumulación de longitud
axes(handles.axes1);cla;hold on;
map = [0 1 0];  %Mapa de color para gráficas
%Ciclo for para operaciones y graficación
for k=1:size(M,1)
     %Convierte a diámetro si está en área
     if strcmp(M{k,5},'Diámetro')==1
         diametro=M{k,4};
     else
         diametro=sqrt((4*M{k,4})/pi);
     end
    %Revisa si es fuerza positiva o negativa
    if M{k,2}==0
        M{k,1}=M{k,1}*-1; 
    end
    %Obtiene d-deformación; sd-suma de deformaciones; sf-suma de fuerzas
    sf=sf+[M{k,1}];     R(k,1)=sf;
    a=pi*[diametro]^2/4;  R(k,2)=a;
    d=R(k,1)*[M{k,3}]/(a*[M{k,6}]);R(k,3)=d;
    sd=sd+d;    R(k,4)=sd;
    s=R(k,1)/a; R(k,5)=s;
    %Gráfícas normales
    x=diametro*sind(Q)/2;
    y=diametro*cosd(Q)/2;
    z=zeros(size(Q));
    %Graficación normal
    axis xy; view(120,30);
    set(get(gca,'XLabel'),'String','Eje X');
    set(get(gca,'YLabel'),'String','Eje Y');
    set(get(gca,'ZLabel'),'String','Eje Z');
    if get(handles.radiobutton1,'value')==1
        surf([z z z+[M{k,3}] z+[M{k,3}]]+LongAcum,[x*0 x x x*0],[y*0 y y y*0],'facealpha',1);
        surf([z z z+[M{k,3}] z+[M{k,3}]]+LongAcum,[x*0 x x x*0]+max([M{:,4}]),[y*0 y y y*0],'facealpha',1); %gráfica que aumentará su deformación
    elseif get(handles.radiobutton2,'value')==1
        surf([x*0 x x x*0],[z z z+[M{k,3}] z+[M{k,3}]]+LongAcum,[y*0 y y y*0],'facealpha',1);
        surf([x*0 x x x*0]+max([M{:,4}]),[z z z+[M{k,3}] z+[M{k,3}]]+LongAcum,[y*0 y y y*0],'facealpha',1); %gráfica que aumentará su deformación
    else
        surf([x*0 x x x*0],[y*0 y y y*0],[z z z+[M{k,3}] z+[M{k,3}]]+LongAcum,'facealpha',1);
        surf([x*0 x x x*0]+max([M{:,4}]),[y*0 y y y*0],[z z z+[M{k,3}] z+[M{k,3}]]+LongAcum,'facealpha',1); %gráfica que aumentará su deformación
    end
    colormap(map)
    axis equal
    h=rotate3d;set(h,'RotateStyle','box','Enable','on');
    %Suma de longitud acumulada se actualiza
    LongAcum=LongAcum+M{k,3};
end
%Envía datos a Table2
set(handles.uitable2,'data',R,'Fontsize',16,...
    'ColumnWidth',{100 120 120 120 120},'FontWeight','bold',...
    'ColumnName',{'Fuerza total' 'Área' 'Deformación' 'Def.Acum.' 'Esfuerzo'});
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


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
