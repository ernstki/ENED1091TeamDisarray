function varargout = AlgoLaunch(varargin)
% LAUNCH MATLAB code for launch.fig
%      LAUNCH, by itself, creates a new LAUNCH or raises the existing
%      singleton*.
%
%      H = LAUNCH returns the handle to a new LAUNCH or the handle to
%      the existing singleton*.
%
%      LAUNCH('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LAUNCH.M with the given input arguments.
%
%      LAUNCH('Property','Value',...) creates a new LAUNCH or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before launch_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to launch_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help launch

global DEBUGGING HELP_DOC_URL;
DEBUGGING = true;
HELP_DOC_URL = 'Final_Report.htm#instructions';

% Last Modified by GUIDE v2.5 20-Apr-2013 21:23:16

% Popup  and context menu item constants (these must be "declared" in every
% function they'll be referenced from!):
global SELECT_ALG INSERTION_SORT SELECTION_SORT BUBBLE_SORT MERGE_SORT ...
       QUICKSORT QUICKSORT_3 RADIX_SORT TREE_SORT QUICKSORT_MEX CLEAR_AXES;
SELECT_ALG     = 1;  % top popup menu option 
INSERTION_SORT = 2;  % Insertion Sort                   (done)
SELECTION_SORT = 3;  % Selection Sort                   (done)
BUBBLE_SORT    = 4;  % Bubble Sort                      (done)
MERGE_SORT     = 5;  % Merge Sort                       (recursive done)
QUICKSORT      = 6;  % Quicksort
QUICKSORT_3    = 7;  % Quicksort (3-way partition)
RADIX_SORT     = 8;  % Radix sort
TREE_SORT      = 9;  % Tree sort
QUICKSORT_MEX  = 10; % Quicksort (compiled C program)
CLEAR_AXES     = 11; % clear the current axes

% Global constants for the input set size:
global INPUT_MIN INPUT_MAX INPUT_DEFAULT INPUT_FSTEP INPUT_CSTEP;
%VALUE_MAX      = 100;  % largest value;
INPUT_MIN      = 25; % minimum input set
INPUT_MAX      = 10000; % 
INPUT_DEFAULT  = 100; % 
% The "fine" and "coarse" step size for the "Max Input Size" selector.
%INPUT_FSTEP     = (INPUT_MAX-INPUT_MIN) / 20 - mod(INPUT_MAX-INPUT_MIN, 20)
%INPUT_CSTEP     = floor((INPUT_MAX-INPUT_MIN) / 5); %coarse step
INPUT_FSTEP     = INPUT_MIN;
INPUT_CSTEP     = floor(INPUT_MAX / 5);

% The sort "input characteristics" set by the radio buttons:
global INPUT_RANDOM INPUT_SORTED_ASC INPUT_SORTED_DESC INPUT_FEW_UNIQUE; % ...
       %DEFAULT_INPUT_TYPE;
INPUT_RANDOM       = 1;
INPUT_SORTED_ASC   = 2;
INPUT_SORTED_DESC  = 3;
INPUT_FEW_UNIQUE   = 4;
%DEFAULT_INPUT_TYPE = INPUT_RANDOM; 

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @AlgoLaunch_OpeningFcn, ...
                   'gui_OutputFcn',  @AlgoLaunch_OutputFcn, ...
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


% --- Executes just before AlgoLaunch is made visible.
function AlgoLaunch_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to AlgoLaunch (see VARARGIN)

% Choose default command line output for AlgoLaunch
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes AlgoLaunch wait for user response (see UIRESUME)
% uiwait(handles.AlgoLaunch);

% ----------------------------------------------------------------------------
%                S E T     U P     G U I     C O N T R O L S            
% ----------------------------------------------------------------------------
    
% -- Draw the logo
img = imread('./images/algo_race_sequential.png', 'BackgroundColor', ...
             [0.5,0.5,0.5]); 
% the tag for this set of axes disappears randomly, hence this
% workaround:
%axes(handles.axLogo);  
ah = findobj(handles.pnlTopBanner, 'Type', 'axes');
axes(ah)
imgh = imshow(img);

% --- Outputs from this function are returned to the command line.
function varargout = AlgoLaunch_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in explorebutton.

% hObject    handle to explorebutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
function explorebutton_Callback(hObject, eventdata, handles)
global SELECT_ALG;

% If user wanted a specific algorithm, set it in appdata here:
setappdata(0, 'ALGOEXPLORE_STARTUP_ALG', get(handles.ExploreInput, 'Value'));
AlgorithmExplore;
pause(1);

while getappdata(0, 'ALGOEXPLORE_OPEN')
    pause(1);
    set(handles.ExploreState, 'String', 'Open')
    % Catch if figure was closed with 'X' button.
    if ~isFigureOpen('AlgoExplore')
        break
    end
end
set(handles.ExploreState, 'String', '')

% === end function exploreButton_Callback()


% --- Executes on button press in racebutton.
% hObject    handle to racebutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
function racebutton_Callback(hObject, eventdata, handles)
AlgorithmRace
pause(1);

while getappdata(0, 'ALGORACE_OPEN')
    pause(1);
    % This inner loop doesn't actually work. Dunno how to signal to the
    % other form to take a break and let AlgoLaunch update its controls...
    while getappdata(0, 'ALGORACE_PLOTTING')
        pause(1);
        set(handles.RaceState, 'String', 'Plotting...')
    end
    set(handles.RaceState, 'String', 'Open')
    % Redundant check (just in case figure was closed with the 'X' button):
    if ~isFigureOpen('AlgoRace')
        break
    end
end
set(handles.RaceState, 'String', '')


% --- Executes on button press in helplaunch.
function helplaunch_Callback(hObject, eventdata, handles)
% hObject    handle to helplaunch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global HELP_DOC_URL;
%web([ pwd, '/Final_Report.htm#instructions' ]);
%disp('Final_Report.htm');
web(HELP_DOC_URL);  % some trouble with this on Windows
%web([pwd, '/', HELP_DOC_URL], '-browser');


% --- Executes on selection change in ExploreInput.
function ExploreInput_Callback(hObject, eventdata, handles)
% hObject    handle to ExploreInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ExploreInput contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ExploreInput


% --- Executes during object creation, after setting all properties.
function ExploreInput_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ExploreInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% ============================================================================
%                    U T I L I T Y    F U N C T I O N S            
% ============================================================================

% === Determine if a specific figure is open
% --- borked
function result = isFigureOpen(figureTag)
    % see: http://stackoverflow.com/questions/4540604
    figHandles = findall(0, 'Type', 'figure');  % get list of all open figures
    figHandles = figHandles';  % transpose so 'for' will digest it
    result = false;
    if numel(figHandles) == 0
        return
    end % if
    for fh = figHandles
        % If this figure handle's tag matches what we were given:
        if strcmp(get(fh, 'Tag'), figureTag)
            result = true;
            return;
        end
    end % for each figure in figureHandles

% === end function isFigureOpen(figureTag)
