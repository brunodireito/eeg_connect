%% -- define global variables --

clear all;
close all;

% Define variables that will be required throughou the project.

% addpath - add important folders to the path
addpath('functions')

% paths.
RAWDATA_PATH='C:\Users\bdireito\Desktop\Data\HCT';
RESULTS_PATH='results';

% variables.
% e.g. Triggers for correct or wrong asnswers.
TRI_CORRECT=21;
TRI_WRONG=20;
% Triggers corresponding to each subtest.
TRI_ST1=1;
TRI_ST2=2;
TRI_ST3=3;
TRI_ST4=4;
TRI_ST5=5;
TRI_ST6=6;
TRI_ST7=7;

% filtering vars.
LOWCUTOFF=1;
HIGHCUTOFF=40;

% Resample to?
RESAMPLEFREQ=100;

%% Check data.

% find datasets.
fnames=dir(fullfile(RAWDATA_PATH,'*.set'));
fprintf('Checking folder %s for .set files.\n', RAWDATA_PATH);

if isempty(fnames)
    fprintf('--- No .set available.')
else
    fprintf('%d EEGLAB .sets available.\n',numel(fnames))
    for f=1:numel(fnames)
        fprintf('%s.\n',fnames(f).name)
    end
end


%% Data analysis
% Organize data and call specific functions.

% Load data.
for p=1
    % Load data.
    PART_SET_PATH=fullfile(fnames(p).folder,fnames(p).name);
    [~, FILENAME, EXT] = fileparts(PART_SET_PATH);
    EEG = pop_loadset('filename', fnames(p).name,...
        'filepath',fnames(p).folder);
    
    % filter data.
    EEG = hctfilt(EEG, LOWCUTOFF, HIGHCUTOFF);

    % Resample data.    
    EEG = pop_resample( EEG, RESAMPLEFREQ);
    
    % Re-epoch around triggers.
    EEG = triggerepoching(EEG, {TRI_ST3}, [-1 1]);
    
    EEG = pop_saveset(EEG,...
            'filename',sprintf('%s_re-epoched%s',FILENAME, EXT),...
            'filepath',fnames(p).folder);
end

%%

