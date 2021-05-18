%% -- define global variables --
% Define variables that will be required throughou the project.

% addpath - add important folders to the path
addpath('functions')

% paths.
RAWDATA_PATH='C:\Users\Cris\Desktop\DATA\';
RESULTS_PATH='C:\Users\Cris\Desktop\DATA_F\';

% variables.
% e.g.
TRI_CORRECT=21;
TRI_WRONG=20;
ST1=1;
ST2=2;
ST3=3;
ST4=4;
ST5=5;
ST6=6;
ST7=7;


%% raw dataset load.

for n=1:1 
    dummyr=strcat(RAWDATA_PATH,'*.set'); 
    ppraw=feval('dir',dummyr);
    N=length(ppraw);
    dummyr=ppraw(n).name;
    RAWDATA_NAME=strcat(RAWDATA_PATH,dummyr);
    EEG = pop_loadset('filename',RAWDATA_NAME);
    [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, n,'setname',RAWDATA_NAME,'gui','off'); 
    eeglab redraw
end


%% processed dataset load
for n=1:1 
    dummyres=strcat(RESULTS_PATH,'*.set'); 
    ppres=feval('dir',dummyres);
    N=length(ppres);
    dummyres=ppres(n).name;
    RESULT_NAME=strcat(RESULTS_PATH,dummyres);
    EEG = pop_loadset('filename',RESULT_NAME);
    [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, n ,'setname',RESULT_NAME,'gui','off'); 
    eeglab redraw
end

%% Data analysis
% Organize data and call specific functions.

disp(sum2numbers(1,2))
