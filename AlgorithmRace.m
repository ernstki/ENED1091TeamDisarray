function varargout = AlgorithmRace(varargin)
% ALGORITHM-RACE AlgorithmRace.fig
%      Created by Team Disarray for the 13SS_ENED1091 final group projec
%
%      Displays a graphical interface for comparing the run time of various
%      sort algorithms on different input sizes, and input having different
%      characteristics (sorted, few unique, etc.)
%
% See also: AlgorithmExplore.fig

% Last Modified by GUIDE v2.5 16-Apr-2013 13:50:07

% Popup menu item constants (these must be "declared" in every function
% they'll be referenced from!):
global SELECTION_SORT BUBBLE_SORT MERGE_SORT QUICKSORT QUICKSORT_3 ...
       RADIX_SORT TREE_SORT QUICKSORT_MEX INPUT_MIN INPUT_MAX ...
       INPUT_DEFAULT INPUT_FSTEP INPUT_CSTEP;
SELECTION_SORT = 1; % Selection Sort
BUBBLE_SORT    = 2; % Bubble Sort
MERGE_SORT     = 3; % Merge Sort
QUICKSORT      = 4; % Quicksort
QUICKSORT_3    = 5; % Quicksort (3-way partition)
RADIX_SORT     = 6; % Radix sort
TREE_SORT      = 7; % Tree sort
QUICKSORT_MEX  = 8; % Quicksort (compiled C program)
%VALUE_MAX      = 100;  % largest value;
INPUT_MIN      = 10; % minimum input set
INPUT_MAX      = 1000; % 
INPUT_DEFAULT  = 50; % 
% The "fine" and "coarse" step size for the "Max Input Size" selector.
%INPUT_FSTEP     = (INPUT_MAX-INPUT_MIN) / 20 - mod(INPUT_MAX-INPUT_MIN, 20)
%INPUT_CSTEP     = floor((INPUT_MAX-INPUT_MIN) / 5); %coarse step
INPUT_FSTEP     = INPUT_MIN;
INPUT_CSTEP     = floor(INPUT_MAX / 5);

% The sort "input characteristics" set by the radio buttons:
global INPUT_RANDOM INPUT_SORTED_ASC INPUT_SORTED_DESC INPUT_FEW_UNIQUE ...
       DEFAULT_INPUT_TYPE;
INPUT_RANDOM       = 1;
INPUT_SORTED_ASC   = 2;
INPUT_SORTED_DESC  = 3;
INPUT_FEW_UNIQUE   = 4;
DEFAULT_INPUT_TYPE = INPUT_RANDOM; 

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @AlgorithmRace_OpeningFcn, ...
                   'gui_OutputFcn',  @AlgorithmRace_OutputFcn, ...
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

% --- Executes just before AlgorithmRace is made visible.
function AlgorithmRace_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to AlgorithmRace (see VARARGIN)

% Choose default command line output for AlgorithmRace
handles.output = hObject;

% How to save state in the global 'guidata' structure.
% MATLAB passes by /value/ (reference until you change it?)
%handles.score = 5;


% Update handles structure
guidata(hObject, handles);

% This sets up the initial plot - only do when we are invisible
% so window can get raised using AlgorithmRace.
%if strcmp(get(hObject,'Visible'),'off')
    %plot(rand(5));
%end

% UIWAIT makes AlgorithmRace wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = AlgorithmRace_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function FileMenu_Callback(hObject, eventdata, handles)
% hObject    handle to FileMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function OpenMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to OpenMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
file = uigetfile('*.fig');
if ~isequal(file, 0)
    open(file);
end

% --------------------------------------------------------------------
function PrintMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to PrintMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
printdlg(handles.figure1)

% --------------------------------------------------------------------
function CloseMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to CloseMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selection = questdlg(['Close ' get(handles.figure1,'Name') '?'],...
                     ['Close ' get(handles.figure1,'Name') '...'],...
                     'Yes','No','Yes');
if strcmp(selection,'No')
    return;
end

delete(handles.figure1)

% --- Executes during object creation, after setting all properties.
function axLogo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axLogo (see GCBO)
    img = imread('Matlab_Logo_small.png', 'BackgroundColor', [0.5,0.5,0.5]);
    axes(hObject);
    % See: http://www.peteryu.ca/tutorials/matlab/plot_over_image_background
    %imagesc([100, 400], [100, 400], flipdim(img,1));
    %set(gca, 'Visible', 'off');
    %set(gca, 'ydir', 'normal');
    h = imshow(img);
    set(h, 'Parent', hObject);


% ============================================================================
%            A L G O R I T H M   D R O P - D O W N   S E L E C T O R S
% ============================================================================

% === CONTENDER #1 CREATE
% --- Executes during object creation, after setting all properties.
function popAlg1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popAlg1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% === CONTENDER #1 CALLBACK
% --- Executes on selection change in popAlg1.
function popAlg1_Callback(hObject, eventdata, handles)
% hObject    handle to popAlg1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popAlg1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popAlg1
 global SELECTION_SORT BUBBLE_SORT MERGE_SORT QUICKSORT QUICKSORT_3 ...
        RADIX_SORT TREE_SORT QUICKSORT_MEX
    
 ph = get(hObject, 'Parent'); % get handle to the parent (should be the panel)
 fig = findobj(ph, 'type', 'axes');
 choice = get(hObject, 'Value');
    switch choice
        %case getappdata(hObject, 'SELECTION_SORT')
        case SELECTION_SORT
            fprintf('Selection sort was picked\n');
            %set(gcf, 'UserData'
            %set(fig, 'UserData', SELECTION_SORT);
        case BUBBLE_SORT
            fprintf('Bubble sort was picked\n');
            
        case MERGE_SORT
            fprintf('Merge sort was picked\n');
            
        case QUICKSORT
            fprintf('Quicksort was picked\n');
            
        case QUICKSORT_3
            fprintf('Quicksort (3-way partition) was picked\n');
            
        case RADIX_SORT
            fprintf('Radix sort was picked\n');
            
        case TREE_SORT
            fprintf('Tree sort was picked\n');
            
        case QUICKSORT_MEX
            fprintf('Quicksort (compiled MEX) sort was picked\n');
    end


% === CONTENDER #2 CREATE
% --- Executes during object creation, after setting all properties.
function popAlg2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popAlg2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% === CONTENDER #2 CALLBACK
% --- Executes on selection change in popAlg2.
function popAlg2_Callback(hObject, eventdata, handles)
% hObject    handle to popAlg2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popAlg2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popAlg2
 global SELECTION_SORT BUBBLE_SORT MERGE_SORT QUICKSORT QUICKSORT_3 ...
        RADIX_SORT TREE_SORT QUICKSORT_MEX


% === CONTENDER #3 CREATE
% --- Executes during object creation, after setting all properties.
function popAlg3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popAlg3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% === CONTENDER #3 CALLBACK
% --- Executes on selection change in popAlg3.
function popAlg3_Callback(hObject, eventdata, handles)
% hObject    handle to popAlg3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popAlg3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popAlg3
 global SELECTION_SORT BUBBLE_SORT MERGE_SORT QUICKSORT QUICKSORT_3 ...
        RADIX_SORT TREE_SORT QUICKSORT_MEX




% ============================================================================
%              "M A X   I N P U T   S I Z E"   C O N T R O L S
% ============================================================================

% === THE "MAX INPUT SIZE" SLIDER CONTROL
% --- Executes during object creation, after setting all properties.
function sliInputSize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliInputSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
    global INPUT_MIN INPUT_MAX INPUT_DEFAULT INPUT_FSTEP INPUT_CSTEP
    if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor',[.9 .9 .9]);
    end

    set(hObject, 'Value', INPUT_DEFAULT);
    set(hObject, 'Min', INPUT_MIN);
    set(hObject, 'Max', INPUT_MAX);
    %set(hObject, 'SliderStep', [INPUT_FSTEP, INPUT_CSTEP]);

% --- Executes on slider movement.
function sliInputSize_Callback(hObject, eventdata, handles)
% hObject    handle to sliInputSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
    global INPUT_MIN INPUT_FSTEP
    N = get(handles.sliInputSize, 'Value');    % Get the new slider value
    N = N - mod(N, INPUT_FSTEP);               % round to nearest (fine) step
    if N < INPUT_MIN                           % don't go lower than INPUT_MIN
        N = INPUT_MIN;
    end
    set(handles.edtInputSize, 'String', N);


% === THE "INPUT SIZE" TEXT BOX CONTROL
% --- Executes during object creation, after setting all properties.
function edtInputSize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edtInputSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
    global INPUT_DEFAULT
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
    set(hObject, 'String', INPUT_DEFAULT);    


function edtInputSize_Callback(hObject, eventdata, handles) %#ok<*INUSL>
% hObject    handle to edtInputSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edtInputSize as text
%        str2double(get(hObject,'String')) returns contents of edtInputSize as a double
    
    global INPUT_MIN INPUT_MAX INPUT_CSTEP

    % Check to see that the value given is between INPUT_MIN and INPUT_MAX:
    input_size = get(hObject, 'String');
    if input_size < INPUT_MIN || input_size > INPUT_MAX
        % Restore previous value from 'UserData'
        set(hObject, 'String', get(hObject, 'UserData'));
        set(hObject, 'Color', [0.6, 0.1, 0]); % a nice red color
    else
        % Round input size to the nearest (coarse) step:
        input_size = input_size - mod(input_size, INPUT_CSTEP)
        set(handles.sliInputSize, 'Value', input_size)
        set(hObject, 'UserData', input_size);
        set(hObject, 'Color', [0.25, 0.25, 0.25]); % back to default
        
    end


% ============================================================================
%          R A D I O   B U T T O N   C R E A T E / C A L L B A C K S
% ============================================================================
% The order on the figure is:
% [ ] Random
% [ ] Already Sorted (A)scending
% [ ] Already Sorted (D)escending
% [ ] Few unique

% === RANDOM ===
% --- Executes during object creation, after setting all properties.
function rdoRandom_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rdoRandom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% --- Executes on button press in rdoRandom.
function rdoRandom_Callback(hObject, eventdata, handles)
% hObject    handle to rdoRandom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rdoRandom


% === ALREADY SORTED (ASCENDING)
% --- Executes during object creation, after setting all properties.
function rdoSortedAsc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rdoSortedAsc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% --- Executes on button press in rdoSortedAsc.
function rdoSortedAsc_Callback(hObject, eventdata, handles)
% hObject    handle to rdoSortedAsc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rdoSortedAsc


% === ALREADY SORTED (DESCENDING)
% --- Executes during object creation, after setting all properties.
function rdoSortedDesc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rdoSortedDesc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% --- Executes on button press in rdoSortedDesc.
function rdoSortedDesc_Callback(hObject, eventdata, handles)
% hObject    handle to rdoSortedDesc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rdoSortedDesc


% === FEW UNIQUE (MANY DUPLICATES)
% --- Executes during object creation, after setting all properties.
function rdoFewUnique_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rdoFewUnique (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% --- Executes on button press in rdoFewUnique.
function rdoFewUnique_Callback(hObject, eventdata, handles)
% hObject    handle to rdoFewUnique (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rdoFewUnique


% ============================================================================
%                 P A N E L   C R E A T E   F U N C T I O N S
% ============================================================================

% --- Executes during object creation, after setting all properties.
function pnlAlg1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pnlAlg1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
    % Remember the initial value of Title in 'UserData'
    set(hObject, 'UserData', get(hObject, 'Title'));


% ============================================================================
%                             B U T T O N S                     
% ============================================================================

% === THE "GO" BUTTON
% --- Executes on button press in btnGo.
function btnGo_Callback(hObject, eventdata, handles)
% hObject    handle to btnGo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% When run, loop through all three axes, running that set of axes' selected
% algorithm for the given input size. Then increase by INPUT_FSTEP and do
% it again until reaching the value of sliInputSize (the max input size):
    global INPUT_MIN INPUT_FSTEP %INPUT_MAX
    % A list of handles to the figure's panels
    %ph = get(hObject, 'Parent'); % get handle to parent
    %panels = findobj(gcf, '-regexp', 'Tag', '^pnlAlg');
    ax_handles = [ findobj(gcf, 'Tag', 'axAlg1'), ...
                   findobj(gcf, 'Tag', 'axAlg2'), ...
                   findobj(gcf, 'Tag', 'axAlg3') ];
    if ishandle(ax_handles(1))
        fprintf('ax_handles(1) is a handle!\n');
        axes(ax_handles(1));
        t=0:.1:5;
        plot(t, t.*3);
    end 
    
    
    
% --- Execute one iteration of a sort algorithm for the given axis handle
function [run_time] = runIterationForAxis(which_axis, input_size, handles)
% FIXME: It hurts to have to hard-code this.

    %if which_axis == 1 
        
   


% === THE "CANCEL" BUTTON
% --- Executes during object creation, after setting all properties.
function btnCancel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to btnCancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% --- Executes on button press in btnCancel.
function btnCancel_Callback(hObject, eventdata, handles)
% hObject    handle to btnCancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% === THE "CLEAR AXES" BUTTON
% --- Executes on button press in btnClearAxes.
function btnClearAxes_Callback(hObject, eventdata, handles)
% hObject    handle to btnClearAxes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% === END OF AlgorithmRace.m ===
% vim: tw=78 ts=4 sw=4 expandtab


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over text4.
function text4_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to text4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    web('./Help.htm');
