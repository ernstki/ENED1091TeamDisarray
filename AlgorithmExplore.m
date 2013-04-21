function varargout = AlgorithmExplore(varargin)
% ALGORITHMEXPLORE MATLAB code for AlgorithmExplore.fig
%      ALGORITHMEXPLORE, by itself, creates a new ALGORITHMEXPLORE or raises the existing
%      singleton*.
%
%      H = ALGORITHMEXPLORE returns the handle to a new ALGORITHMEXPLORE or the handle to
%      the existing singleton*.
%
%      ALGORITHMEXPLORE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ALGORITHMEXPLORE.M with the given input arguments.
%
%      ALGORITHMEXPLORE('Property','Value',...) creates a new ALGORITHMEXPLORE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before AlgorithmExplore_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to AlgorithmExplore_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help AlgorithmExplore

% Tell AlgoLaunch that we're open
setappdata(0, 'ALGOEXPLORE_OPEN', true);
%disp(varargin{1});
%return;


global SELECT_ALG INSERTION_SORT SELECTION_SORT BUBBLE_SORT MERGE_SORT ...
       QUICKSORT QUICKSORT_3 RADIX_SORT TREE_SORT QUICKSORT_MEX ...
       UNIMPLEMENTED DEFAULT_SET_SIZE MAX_SET_SIZE DEFAULT_ALG;
SELECT_ALG       = 1;    % top popup menu option 
INSERTION_SORT   = 2;    % Insertion Sort                   (done)
SELECTION_SORT   = 3;    % Selection Sort                   (done)
BUBBLE_SORT      = 4;    % Bubble Sort                      (done)
MERGE_SORT       = 5;    % Merge Sort                       (recursive done)
QUICKSORT        = 6;    % Quicksort
QUICKSORT_3      = 7;    % Quicksort (3-way partition)
RADIX_SORT       = 8;    % Radix sort
TREE_SORT        = 9;    % Tree sort
QUICKSORT_MEX    = 10;   % Quicksort (compiled C program)
UNIMPLEMENTED    = -1;   % unimplemented algorithm
DEFAULT_SET_SIZE = 50;   % default set size for the EditSetSize control
MAX_SET_SIZE     = 5000; % maximum input size

% Test to see if AlgoLaunch wanted to start up with a specific algorithm:
DEFAULT_ALG = getappdata(0, 'ALGOEXPLORE_STARTUP_ALG');
if ~DEFAULT_ALG || DEFAULT_ALG > 10  % 0, false, negative, or > 10
        DEFAULT_ALG = SELECT_ALG; % leave it at 'choose an algorithm'
end % checking if a startup algorithm was specified


% Last Modified by GUIDE v2.5 20-Apr-2013 21:23:39

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @AlgorithmExplore_OpeningFcn, ...
                   'gui_OutputFcn',  @AlgorithmExplore_OutputFcn, ...
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

% --- Executes just before AlgorithmExplore is made visible.
function AlgorithmExplore_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to AlgorithmExplore (see VARARGIN)
global DEFAULT_SET_SIZE DEFAULT_ALG;

% Example of how to use styled text in a uicontrol (only works for popups
% as far as I can tell). Source: http://wp.me/p18q4-50
% uicontrol('Style','popup', 'Position',[10,10,150,100], 'String', ...
% {'<HTML><BODY bgcolor="green">green background</BODY> </HTML>', ...
% '<HTML><FONT color="red" size="+2">Large red font</FONT></HTML>' ...
% '<HTML><BODY bgcolor="#FF00FF"> <PRE>fixed-width font'});

% Choose default command line output for AlgorithmExplore
handles.output = hObject;
handles.BAR_OR_SCATTER = 'bar';
handles.PLOTTING = false;
handles.STOP_PLOTTING = false;
handles.ALG_DESCRIPTIONS = { ... 
     {'Choose an algorithm from the list above.'}, ...            
     { 'Notes on Insertion Sort (2):', '', ...
       'The insertion sort algorithm takes the *first* item from a list of inputs and places it in order in a second, sorted list or does an in-place swap (if the data structure is an array).', ...
       '', ...
       'Other properties of Insertion Sort:', '', ...
       ' * Insertion sort is a "stable" sort  (non-unique items come out of the algorithm in the same order they went in)', ...
       ' * it takes very little extra space (if sorting/swapping is done in-place)', ...
       ' * and performs O(N-squared) comparisons and swaps.' }, ...
     {'Notes on Selection Sort (3):', '', ...
      'The selection sort algorithm searches the entire input list and removes the first item *in sort order*, then places in in a second sorted list or does an in-place swap (if the data structure is an array).', ...
      '', ...
      'Other properties of Selection Sort:', '', ...
      ' * selection sort is *not* stable; i.e., when sorting a compount data type such as a structure or object, items may not appear in the sorted list in the same order they were given to the algorithm.', ...
      ' * it takes very little extra space (if sorting/swapping is done in-place)', ...
      ' * and performs O(N-squared) comparisons and O(N) swaps.' }, ...
     {'Notes on Bubble Sort (4);', '', ...
      'The bubble sort algorithm scans through the list swapping two items if they''re out of sort order until it reaches the end of the list, and repeats this process until no further swaps need be performed.', ...
      '', ...
      'Other properties of Bubble Sort:', ...
      ' * It is a *stable* sort (non-unique items come out of the algorithm in the same order they went in)', ...
      ' * and performs O(N-squared) comparisons and swaps.' }, ...
     {'Notes on Merge Sort (5):', '', ...
      'The merge sort algorithm breaks an input list into sublists (usually recursively), then performs a "merge" operation back up the call chain, combining these sublists in sort order.', ...
      '', ...
      'Other properties of Merge Sort:', ...
      ' * It is a *stable* sort (non-unique items come out of the algorithm in the same order they went in)', ...
      ' * it uses O(n) extra space when implemented on an array-like data structure', ...
      ' * and sorts in O( N * log(N) ) time', ...
	  '', ...
      'Plotting iterations of Merge Sort is not supported in this version of Algo-Explore.', ...
	  '', ...
	  'Sorry. :(' }, ...
     {'Notes on Quicksort:', '', ...
      'The quicksort algorithm is similar to merge sort in that it breaks up the input set into sublists and merges them as it returns from recursion branches. Quick sort chooses sublists based on values less than or greater than a "pivot."', ...
      '', ...
      'Other properties of quicksort', ...
      ' * Quicksort is *not* a stable sort', ...
      ' * The choice of a pivot has a great effect on performance, which ranges from O(N-squared) to O( N * log(N) ).', ...
      ' * When a "stable" sort is not required, quicksort is a very good choice for a fast, general-purpose sorting algorithm.', ...
	  '', ...
      'Plotting iterations of Quicksort is not supported in this version of Algo-Explore.', ...
	  '', ...
	  'Sorry. :(' }, ...
     {'Quicksort with 3 sublists (Quick3) is not implemented in this version of Algo-Explore.', ...
	  '', ...
	  'Sorry. :(' }, ...
     {'Radix Sort is not implemented in this version of Algo-Explore.', ...
	  '', ...
	  'Sorry. :(' }, ...
     {'Tree Sort is not implemented in this version of Algo-Explore.', ...
	  '', ...
	  'Sorry. :(' }, ...
     {'Quicksort using a compiled executable (via MEX) is not implemented in this version of Algo-Explore.', ...
	  '', ...
	  'Sorry. :(' }, ...
    }; % handles.ALG_DESCRIPTIONS (whew!)
handles.ALG_EXTERNAL_HELP = { 'Final Report.htm#instructions',
    'http://www.sorting-algorithms.com/insertion-sort',
    'http://www.sorting-algorithms.com/selection-sort',
    'http://www.sorting-algorithms.com/bubble-sort',
    'http://www.sorting-algorithms.com/merge-sort',
    'http://www.sorting-algorithms.com/quick-sort',
    'http://www.sorting-algorithms.com/quick-sort-3-way',
    'http://en.wikipedia.org/wiki/Radix_sort',
    'http://en.wikipedia.org/wiki/Tree_sort',
    'http://www.sorting-algorithms.com/quick-sort' };
% Update handles structure
guidata(hObject, handles);

% ----------------------------------------------------------------------------
%            I N I T I A L    S E T - U P    O F    C O N T R O L S            
% ----------------------------------------------------------------------------

% FIXME: Could combine these into one function that takes care of it all:
set(handles.popAlgs, 'Value', DEFAULT_ALG);
updateHyperlink(DEFAULT_ALG);
updateHelpText(DEFAULT_ALG);


axes(handles.axes1);
t = 1:DEFAULT_SET_SIZE;
plot(t, t);
title('Run time for input size N');
xlabel('Input set size (N)');
ylabel('Run time (seconds)');

% ------------------------------------------------------------------------
%                      D R A W   T H E   L O G O 
% ------------------------------------------------------------------------
img = imread('./images/Matlab_Logo_small.png', 'BackgroundColor', ...
             [0.5,0.5,0.5]);
% the tag for this set of axes disappears randomly, hence this
% workaround:
%axes(handles.axLogo);  
ah = findobj(handles.pnlTopBanner, 'Type', 'axes');
axes(ah)
imgh = imshow(img);

% UIWAIT makes AlgorithmExplore wait for user response (see UIRESUME)
% uiwait(handles.AlgoExplore);

% === END FUNCTION AlgorithmExplore_OpeningFcn


% --- Outputs from this function are returned to the command line.
function varargout = AlgorithmExplore_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in Go.
function Go_Callback(hObject, eventdata, handles)
% hObject    handle to Go (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.PLOTTING
    return
end 
global SELECT_ALG INSERTION_SORT SELECTION_SORT BUBBLE_SORT MERGE_SORT ...
       QUICKSORT QUICKSORT_3 RADIX_SORT TREE_SORT QUICKSORT_MEX MAX_SET_SIZE;
   
% -- Check the input size
eh = handles.SetSizeEdit;  %handle to the edit box for set size
SetSize = str2num(get(eh, 'String'));

if length(SetSize) == 0 || SetSize < 0 %#ok<ST2NM>
    % Prompt the user that the input value is invalid
    set(eh, 'Enable', 'off');
    % Save the current background color
    orig_fg = get(eh, 'BackgroundColor');
    set(eh, 'BackgroundColor', 'red'); % yikes!
    set(eh, 'String', 'Invalid input!');
    pause(2);
    set(eh, 'BackgroundColor', orig_fg);
    set(eh, 'String', '0');
    set(eh, 'Enable', 'on');
    return
elseif SetSize > MAX_SET_SIZE %#ok<ST2NM>
    % Prompt the user that the input value is too great.
    set(eh, 'Enable', 'off');
    % Save the current background color
    orig_fg = get(eh, 'BackgroundColor');
    set(eh, 'BackgroundColor', 'red'); % yikes!
    set(eh, 'String', sprintf('Sorry, max is %.f', MAX_SET_SIZE));
    pause(2);
    set(eh, 'BackgroundColor', orig_fg);
    set(eh, 'String', MAX_SET_SIZE);
    set(eh, 'Enable', 'on');
    return
end % if ~isnumber ...

% -- Make sure an algorithm is selected:
poph = handles.popAlgs;  % handle to the algorithm popup
if get(handles.popAlgs, 'Value') == SELECT_ALG
    set(poph, 'Enable', 'off');  % disable the control temporarily
    %for k = 1:10
    % The animation didn't work for some reason.
    set(handles.AlgoArrow, 'Visible', 'on');
    pause(2);
    set(handles.AlgoArrow, 'Visible', 'off');
    set(poph, 'Enable', 'on');  % disable the control temporarily

    return
end % if no algorithm is selected when "Go" button is pressed.
    
% -- Plot this stuff:
axes(handles.axes1);
cla;
popup_sel_index = get(poph, 'Value');
handles.STOP_PLOTTING = false;


guidata(hObject,handles);

list = randi(SetSize,1,SetSize);
switch popup_sel_index
    case SELECT_ALG
        
    case INSERTION_SORT
        InsertionSort(list,true,handles.axes1);
    case SELECTION_SORT
        SelectionSort(list,true,handles.axes1);
    case BUBBLE_SORT
        BubbleSort(list,true,handles.axes1);
    case MERGE_SORT
        MergeSort(list,true,handles.axes1);
    case QUICKSORT
        Quicksort(list,true,handles.axes1);
    case QUICKSORT_3
        unimplementedMsg();
        %Quicksort3(list,true,handles.axes1);
    case RADIX_SORT
       unimplementedMsg();
        %RadixSort(list,true,handles.axes1);
    case TREE_SORT
        unimplementedMsg();
        %TreeSort(list,true,handles.axes1);
    case QUICKSORT_MEX
        unimplementedMsg();
        %QuicksortMEX(list,true,handles.axes1);
end
handles.PLOTTING = false;
guidata(hObject,handles);
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
printdlg(handles.AlgoExplore)

% --------------------------------------------------------------------
function CloseMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to CloseMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selection = questdlg(['Close ' get(handles.AlgoExplore,'Name') '?'],...
                     ['Close ' get(handles.AlgoExplore,'Name') '...'],...
                     'Yes','No','Yes');
if strcmp(selection,'No')
    return;
end

delete(handles.AlgoExplore)


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
     set(hObject,'BackgroundColor','white');
end

set(hObject, 'String', {'plot(rand(5))', 'plot(sin(1:0.01:25))', 'bar(1:.5:10)', 'plot(membrane)', 'surf(peaks)'});


% --- Executes during object creation, after setting all properties.
function SetSizeEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SetSizeEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% Set the control's default value to be DEFAULT_SET_SIZE:
global DEFAULT_SET_SIZE;
set(hObject, 'String', DEFAULT_SET_SIZE);


% --- Executes on selection change in popAlgs.
function popAlgs_Callback(hObject, eventdata, handles)
% hObject    handle to popAlgs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popAlgs contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popAlgs
%global SELECT_ALG INSERTION_SORT SELECTION_SORT BUBBLE_SORT MERGE_SORT ...
%       QUICKSORT QUICKSORT_3 RADIX_SORT TREE_SORT QUICKSORT_MEX;

% Update the hyperlink ("Online Help" button) and the description text
% whenever the popup's value changes.
alg = get(hObject, 'Value');
updateHelpText(alg);
updateHyperlink(alg);

    


% --- Executes during object creation, after setting all properties.
function popAlgs_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popAlgs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Hyperlink.
function Hyperlink_Callback(hObject, eventdata, handles)
% hObject    handle to Hyperlink (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
class(get(hObject, 'UserData'));
web(get(hObject, 'UserData'), '-browser');


% --- Executes during object creation, after setting all properties.
function Hyperlink_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Hyperlink (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% These need to be in the OpeningFcn for the form, otherwise the globals
% (and probably the handles) don't exist yet.
%global SELECT_ALG;
%updateHyperlink(SELECT_ALG, handles);



% --- Executes on button press in Cancel.
function Cancel_Callback(hObject, eventdata, handles)
% hObject    handle to Cancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.PLOTTING == true
    handles.STOP_PLOTTING = true;
    % the 'go' button callback should set PLOTTING to false when the sort
    % algorithm falls through, but I'll set it here anyway in case the sort
    % algorithm is interrupted/crashes:
    handles.PLOTTING = false;
    disp('User requested to stop plotting.');
    %set(hObject, 'String', 'Close');
    guidata(hObject, handles); % update 'handles' structure for other controls
else
    setappdata(0, 'ALGOEXPLORE_OPEN', false);
    close(gcf);
end %if

% --- Executes during object creation, after setting all properties.
function AlgDescription_CreateFcn(hObject, eventdata, handles)
% hObject    handle to AlgDescription (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
    set(hObject, 'String', {'Select an algorithm from the menu at the top'});


% --- Executes on button press in Clear.
function Clear_Callback(hObject, eventdata, handles)
% hObject    handle to Clear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

cla(handles.axes1);

% ============================================================================
%                      H E L P E R    F U N C T I O N S            
% ============================================================================

% === UPDATE GLOBAL "PLOTTING" STATUS FLAGS
% --- Unused in this .m file at present
function setPlottingFlags()
    handles = guidata(gcf);
    % This is redundant if we're setting appdata, but if it ain't broke...
    handles.PLOTTING = true;
    setappdata(0, 'ALGOEXPLORE_PLOTTING', false);
    guidata(gcf, handles); % don't forget to update it!
    
function clearPlottingFlags()
% --- Unused in this .m file at present
    handles = guidata(gcf);
    handles.PLOTTING = false;
    setappdata(0, 'ALGOEXPLORE_PLOTTING', false);
    guidata(gcf, handles); % don't forget to update it!
    
    
% === WARNING MESSAGE FOR UNIMPLEMENTED FEATURES
% --- Display a dialog box that a function is unimplemented.
function unimplementedMsg()
    % TODO: Update this to use some non-modal method of interacting with
    % the user, like, say, a normally-hidden status line on the form.
    warndlg({ 'Sorry, that feature is unimplemented', '', 'Apologies,',  ...
              '', '--Team Disarray' });
             
% === end function unimplementedMessage()


% == UPDATE THE HELP TEXT TO THE RIGHT OF THE PLOT
function updateHelpText(alg)
    % Update the static help text to the left of the plot for the given
    % algorithm
    handles = guidata(gcf);
    set(handles.AlgDescription, 'String', handles.ALG_DESCRIPTIONS{alg});
    
% == UPDATE HYPERLINK    
function updateHyperlink(alg)
    handles = guidata(gcf);
    class(handles.ALG_EXTERNAL_HELP);
    set(handles.Hyperlink, 'UserData', handles.ALG_EXTERNAL_HELP{alg});
    set(handles.Hyperlink, 'TooltipString', handles.ALG_EXTERNAL_HELP{alg});


% --- Executes on button press in StableSortHelp.
function StableSortHelp_Callback(hObject, eventdata, handles)
% hObject    handle to StableSortHelp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over StableSortHelp.
function StableSortHelp_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to StableSortHelp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
web('http://en.wikipedia.org/wiki/Stable_sort#Stability');
