function varargout = AlgorithmRace(varargin)
% ALGORITHM-RACE AlgorithmRace.fig
%      Created by Team Disarray for the 13SS_ENED1091 final group projec
%
%      Displays a graphical interface for comparing the run time of various
%      sort algorithms on different input sizes, and input having different
%      characteristics (sorted, few unique, etc.)
%
% See also: AlgorithmExplore.fig

% Last Modified by GUIDE v2.5 18-Apr-2013 15:18:52

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
function AlgorithmRace_OpeningFcn(hObject, eventdata, handles, varargin) %#ok<*INUSL>
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to AlgorithmRace (see VARARGIN)
global INSERTION_SORT INPUT_RANDOM;

% Updated this to use a 'STOP_PLOTTING' flag in the global 'handles'
% structure intead. But both work equally well.
%global STOP_PLOTTING;
% Choose default command line output for AlgorithmRace
handles.output = hObject;

% ----------------------------------------------------------------------------
%             G L O B A L   S E T T I N G S   /   D E F A U L T S
% ----------------------------------------------------------------------------

handles.STOP_PLOTTING         = false;     % signal from some control to stop
handles.PLOTTING              = false;     % are we currently plotting?
handles.BAR_OR_SCATTER        = 'bar';          % Default to bar charts
%handles.INPUT_CHARACTERISTICS = INPUT_RANDOM;   % Default to INPUT_RANDOM
%handles.SORT_ALGORITHM        = INSERTION_SORT; % Default sort algorithm
set(handles.popAlg1, 'Value', INSERTION_SORT);  % default for 1st set of axes
setAxesAlgorithm(handles.axAlg1, INSERTION_SORT);
% Update handles structure
guidata(hObject, handles);
setInputCharacteristics(INPUT_RANDOM);%, handles); % Default to INPUT_RANDOM

% This sets up the initial plot - only do when we are invisible
% so window can get raised using AlgorithmRace.
%if strcmp(get(hObject,'Visible'),'off')
    %plot(rand(5));
%end

% UIWAIT makes AlgorithmRace wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = AlgorithmRace_OutputFcn(hObject, eventdata, handles) %#ok<*INUSL>
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
%function FileMenu_Callback(hObject, eventdata, handles)
% hObject    handle to FileMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function OpenMenuItem_Callback(hObject, eventdata, handles) %#ok<*INUSD,*INUSD>
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
function CloseMenuItem_Callback(hObject, eventdata, handles) %#ok<*DEFNU>
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
function popAlgSelector_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popAlg1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% For some reason, this can't be put in the CreatFcn, maybe because the
% control hasn't been filled with values yet. Moved to
% AlgorithmRace_OpeningFcn instead.
% % Set popAlg1 to default to the second item (insertion sort)
% if strcmp(get(hObject, 'Tag'), 'popAlg1')
%     disp('Initialize first popup (popAlg1) to default to insertion sort.');
%     %*** disp(get(hObject, 'Tag'));
%     set(hObject, 'Value', 1);
%     drawnow expose update;
% end

% === AXES POPUP MENU (ALGORITHM CHOICE) CALLBACK
% --- Executes on selection change in popAlg1, popAlg2, and popAlg3
function popAlgSelector_Callback(hObject, eventdata, handles)
% hObject    handle to popAlg1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popAlg1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popAlg1
% global SELECTION_SORT BUBBLE_SORT MERGE_SORT QUICKSORT QUICKSORT_3 ...
%        RADIX_SORT TREE_SORT QUICKSORT_MEX; %#ok<*NUSED>
 
% Find the axes in the parent object and get a handle to them:
ph = get(hObject, 'Parent');
ah = findobj(ph, 'Type', 'axes');
% This function sets the chosen algorithm in the 'UserData' of the axes
% themselves.
setAxesAlgorithm(ah, get(hObject, 'Value'));

    




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
        input_size = input_size - mod(input_size, INPUT_CSTEP);
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

% === RANDOM
% === ALREADY SORTED (ASCENDING)
% === ALREADY SORTED (DESCENDING)
% === FEW UNIQUE (MANY DUPLICATES)

% --- Executes for all radio buttons in the "Input Characteristics" group
function rdoInputCharacteristics_Callback(hObject, eventdata, handles)
% hObject    handle to rdoFewUnique (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rdoFewUnique
setInputCharacteristics(get(hObject, 'Value'));



% ============================================================================
%            A X E S  /  P A N E L   C R E A T E   F U N C T I O N S
% ============================================================================

% --- Executes during object creation, after setting all properties.
function axAlgX_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axAlg1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axAlg1
ax = get(hObject, 'Tag');
% Set 'haxAlgN' to the handle to the axes
setappdata(gcf, 'haxAlg1', hObject);    


% --- Executes during object creation, after setting all properties.
function pnlAlgX_CreateFcn(hObject, eventdata, handles)
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
% Need to do it the second way because 'findobj' won't return them in the
% same (numerical) order each time.
%panels = findobj(gcf, '-regexp', 'Tag', '^pnlAlg');
ax_handles = [ findobj(gcf, 'Tag', 'axAlg1'), ...
               findobj(gcf, 'Tag', 'axAlg2'), ...
               findobj(gcf, 'Tag', 'axAlg3') ];

% --- Set up some things
% Clear the global "stop_plotting" and update 'handles':
handles.STOP_PLOTTING = false;
handles.PLOTTING      = true;
guidata(hObject, handles);  % signal to other controls that a plot in progress
set(handles.btnCancelClose, 'String', 'Cancel');
btnbg = get(handles.btnCancelClose, 'BackgroundColor'); % remember this
%*** disp(btnbg);
set(handles.btnCancelClose, 'BackgroundColor', [1.0, 0.6, 0.6]); %reddish

% ----------------------------------------------------------------------------
%                      T I M E    T H E    P L O T S            
% ----------------------------------------------------------------------------
for ah = ax_handles % for each set of axes in ax_handles
    % a cell array of function handles to the various sorting algorithms
    sort_algs     = { @() disp('no alg selected'), @InsertionSort, ...
                      @SelectionSort, @BubbleSort, ...
                      @MergeSort, @Quicksort, @Quick3, @RadixSort, ...
                      @TreeSort, @QuicksortMEX };
    % a cell array of function handles to the various input generators
    input_types   = { @ListRandom, @(n)ListAlreadySorted(n, 'ascend'), ...
                      @(n)ListAlreadySorted(n, 'descend'), @ListFewUnique };
        
    times         = [];              % initialize times and empty vector
    k             = 1;               % # of iterations, used to index into 't'
    
    % A function handle to the sort algorithm [1-10] to be used, which is
    % stored in the axes' 'UserData' (not sure why I did it this way):
    axalg = get(ah, 'UserData');
    if isempty(axalg)
        % Skip this set of axes if the 'UserData' is empty
        fprintf('Axes %s have no algorithm selected. Skipping.\n', ...
                get(ah, 'Tag'));
        continue
    else
        %sorter        = sort_algs{ handles.SORT_ALGORITHM };
        sorter        = sort_algs{ axalg };
    end % if isempty(axalg)
    
    % a function handle to the input generator to be used, indexed by the
    % value of handles.INPUT_CHARACTERISTICS:
    input         = input_types{ handles.INPUT_CHARACTERISTICS };
    pnlh          = get(ah, 'Parent'); % handle to the parent panel
    default_lbl   = get(pnlh, 'UserData');  % the default label
    stop_set_size = get(handles.sliInputSize, 'Value');   % max set size
    set_size      = INPUT_MIN:INPUT_FSTEP:stop_set_size;  % need this to plot
        
    %*** DEBUGGING
    %*** disp(ax);
    %*** disp(get(ax, 'UserData'));
    %*** return;
    %*** DEBUGGING
        
    % Run INPUT_MIN:INPUT_FSTEP:<the value of sliInputSize> iterations
    tic;                           % start timing (total run time)
    for s = set_size % for each set size in 'set_size':
        input_data = randi(s, 1, s);
        tic;
        % -- Run the sort algorithm for the given set size 's':
        sorter(input(s)); % both of these are function handles set above
        times(k) = toc;
        k = k + 1;
        pnl_label = sprintf('%s - running - [%i / %i iterations]', ...
                            default_lbl, k, round(stop_set_size / INPUT_MIN));
        set(pnlh, 'Title', pnl_label);
        drawnow expose;
    end % for s = set_size
    total_time = toc; % stop timing (total time)
    
    % --- Now plot it:
    axes(ah); %#ok<LAXES>          % set 'ax' to be the current axes
    scatter(set_size, times, 'd');
    xlabel('Number of input elements (N)');
    ylabel('Time to sort (s)');
    %hold on;
    % TODO: Figure out how to determine the coefficients necessary to
    % represent O(n), O(log(n)), O(n log(n)), etc on the same plot.
    %plot(set_size, 
    pnl_label = sprintf('%s - finished (%0.2e s)', default_lbl, ...
                        total_time);
    set(pnlh, 'Title', pnl_label);
    
end % for ax = ax_handles

% --- Finish up
handles.PLOTTING = false;
guidata(hObject, handles);  % signal to other controls that we're done
set(handles.btnCancelClose, 'String', 'Close');
set(handles.btnCancelClose, 'BackgroundColor', btnbg);

% === END OF function btnGo_Callback()

    
% === THE "CANCEL" BUTTON
% --- Executes during object creation, after setting all properties.
function btnCancelClose_CreateFcn(hObject, eventdata, handles)
% hObject    handle to btnCancelClose (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(hObject, 'String', 'Close');

% --- Executes on button press in btnCancelClose.
function btnCancelClose_Callback(hObject, eventdata, handles)
% hObject    handle to btnCancelClose (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%handles.stop_plotting = true;
%global STOP_PLOTTING
%STOP_PLOTTING=true;
if handles.PLOTTING == true
    handles.STOP_PLOTTING = true;
    % the 'go' button callback should set PLOTTING to false when the sort
    % algorithm falls through, but I'll set it here anyway in case the sort
    % algorithm is interrupted/crashes:
    handles.PLOTTING = false;
    disp('User requested to stop plotting.');
    set(hObject, 'String', 'Close');
    guidata(hObject, handles); % update 'handles' structure for other controls
else
    close(gcf);
end %if


% === THE "CLEAR AXES" BUTTON
% --- Executes on button press in btnClearAxes.
function btnClearAxes_Callback(hObject, eventdata, handles)
% hObject    handle to btnClearAxes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Calls the helper function 'doForAllAxes' with an anonymous function which
% clears the axis handle of whatever's passed as the first argument.
%doForAllAxes(@(ah) cla(ah), handles);

%*** Try this:
    
    ax_handles = findobj('-regexp', 'Tag', '^axAlg');
    ax_handles = ax_handles';
    disp(ax_handles);
    k = 1;
    tic;
    %for ah = ax_handles
    for ax = { 'axAlg1', 'axAlg2', 'axAlg3' }
        %ah = findobj(gcf, 'Tag', ax);
        ah = getappdata(gcf, ['h', 'ax']);
        cla(ah);
        
        disp(k);
        k = k + 1;
    end
    %run_time = toc;



% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over txtTitle.
function txtTitle_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to txtTitle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
disp('User clicked on the title.');    
web('./Help.htm');


% ============================================================================
%                                M E N U S            
% ============================================================================

% ==
function mnuAxesContextMenu_Callback(hObject, eventdata, handles)
% hObject    handle to mnuClearAxes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% TODO: This really should be merged with setAxesAlgorithm(), since they do
% virtually the same thing.
global SELECT_ALG INSERTION_SORT SELECTION_SORT BUBBLE_SORT MERGE_SORT ...
       QUICKSORT QUICKSORT_3 RADIX_SORT TREE_SORT QUICKSORT_MEX ...
       CLEAR_AXES; %#ok<*NUSED,NUSED>
       
ph = get(gcbo, 'Parent');
ah = findobj(ph, 'Type', 'axes');
menupos = get(hObject, 'Position'); % basically the same as 'Value'
switch menupos
	case { INSERTION_SORT, SELECTION_SORT, BUBBLE_SORT, MERGE_SORT, ...
		   QUICKSORT, QUICKSORT_3, RADIX_SORT, TREE_SORT, QUICKSORT_MEX }
	   set(ah, 'UserData', menupos);
	case CLEAR_AXES
		cla(ah);
	otherwise
		% There's an error
		disp('Shouldn''t get here! Check setAxesAlgorithms().');
end % switch      


% ============================================================================
%                    H E L P E R   F U N C T I O N S            
% ============================================================================

% === DO SOME FUNCTION FOR ALL AXES
% --- Execute 'func' for each set of axes on the figure (used to clear axes)
function [run_time] = doForAllAxes(func) %, handles)
% AlgorithmRace.m - doForAllAxes
%                   perform a function (passed as a function handle) on all
%                   axes found in the second argument, 'handles'.
    ax_handles = findobj('-regexp', 'Tag', '^axAlg');
    ax_handles = ax_handles';
    disp(ax_handles);
    k = 1;
    tic;
    for ah = ax_handles
    %for ax = { 'axAlg1', 'axAlg2', 'axAlg3' }
        func(ah)
        %func(findobj(gcf, 'Tag', ax))
        disp(k);
        k = k + 1;
    end
    run_time = toc;
    
% XXX SET THE SORTING ALGORITHM
% --- (insertion, selection, bubble, etc.) These are defined as globals
%     near the top of this file.
% function setSortAlgorithm(alg)
%     global SELECT_ALG INSERTION_SORT SELECTION_SORT BUBBLE_SORT MERGE_SORT ...
%        QUICKSORT QUICKSORT_3 RADIX_SORT TREE_SORT QUICKSORT_MEX;
% 
%     handles.SORT_ALGORITHM = alg;
%     guidata(hObject, handles); % update the handles structure
    
% === SET THE INPUT SET CHARACTERISTICS
% --- (random, already sorted, etc.)
function setInputCharacteristics(type)%, handles)
    global INPUT_RANDOM INPUT_SORTED_ASC INPUT_SORTED_DESC ...
           INPUT_FEW_UNIQUE;  %#ok<*NUSED>

    handles = guidata(gcf);
    handles.INPUT_CHARACTERISTICS = type;
    guidata(gcf, handles); % update the handles structure
    
% === UPDATE SORT ALGORITHM FOR A SET OF AXES
% --- Store the chosen sort algorithm in the axes' 'UserData' structure:
function setAxesAlgorithm(ah, alg) %#ok<*DEFNU>
    global SELECT_ALG INSERTION_SORT SELECTION_SORT BUBBLE_SORT MERGE_SORT ...
           QUICKSORT QUICKSORT_3 RADIX_SORT TREE_SORT QUICKSORT_MEX ...
           CLEAR_AXES; %#ok<*NUSED,NUSED>
    switch alg
        case { INSERTION_SORT, SELECTION_SORT, BUBBLE_SORT, MERGE_SORT, ...
               QUICKSORT, QUICKSORT_3, RADIX_SORT, TREE_SORT, QUICKSORT_MEX }
           set(ah, 'UserData', alg);
           ph = get(ah, 'Parent');
           ch = findobj(ph, '-regexp', 'Tag', 'pop');  % popup control
           set(ch, 'Value', alg);
        otherwise
            % There's an error
            disp('Shouldn''t get here! Check setAxesAlgorithms().');
    end % switch        	
		
% === END OF AlgorithmRace.m ===
% vim: tw=78 ts=4 sw=4 expandtab
