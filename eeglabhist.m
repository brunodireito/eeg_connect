% EEGLAB history file generated on the 08-Apr-2021
% ------------------------------------------------
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;

path_data='C:\\Program Files\\MATLAB\\R2020b\\eeglab2021.0\\sample_data\\';

EEG = pop_loadset('filename','eeglab_data.set','filepath',path_data);
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
EEG = eeg_checkset( EEG );
% EEG = pop_eegfiltnew(EEG, 'locutoff',1,'hicutoff',40,'plotfreqz',1);
% eeglab redraw;

%% Filtering data between 1Hz and 40Hz


