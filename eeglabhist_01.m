% EEGLAB history file generated on the 07-Apr-2021
% ------------------------------------------------
% pop_saveh( EEG.history, 'eeglabhist.m', 'C:\Users\Cris\Desktop\PROJ_ESTAG\SUJEITOS\');
% eeglab redraw;

%% load dataset

path_data='C:\\Users\\Cris\\Desktop\\PROJ_ESTAG\\SUJEITOS\\';

[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG = pop_loadset('filename','suj1.set','filepath',path_data);
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );


%% Filtering the data (Between 1 and 40 Hz)

[EEG ALLEEG CURRENTSET] = eeg_retrieve(ALLEEG,2);
EEG = pop_eegfiltnew(EEG, 'locutoff',1,'plotfreqz',1);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 2,'setname','eeglab_data_HP','gui','off'); 
EEG = pop_eegfiltnew(EEG, 'hicutoff',40,'plotfreqz',1);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 3,'setname','eeglab_data_LP','gui','off'); 


%% Saves filtered dataset

path_filtered='C:\\Program Files\\MATLAB\\R2020b\\eeglab2021.0\\sample_data\\'

EEG = pop_saveset( EEG, 'filename','eeg_data_filtered.set','filepath',path_filtered);
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);