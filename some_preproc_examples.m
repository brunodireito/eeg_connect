% EEGLAB history file generated on the 07-Apr-2021
% ------------------------------------------------
% pop_saveh( EEG.history, 'eeglabhist.m', 'C:\Users\Cris\Desktop\PROJ_ESTAG\SUJEITOS\');
% eeglab redraw;

%% load dataset

path_data='C:\\Users\\Cris\\Desktop\\PROJ_ESTAG\\SUJEITOS';

[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG = pop_loadset('filename','suj1.set','filepath',path_data);
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
eeglab redraw;


%% Filtering the data (Between 1 and 40 Hz)

%high-pass above 1Hz + creates new dataset
[EEG ALLEEG CURRENTSET] = eeg_retrieve(ALLEEG,1);
EEG = pop_eegfiltnew(EEG, 'locutoff',1,'plotfreqz',1);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 2,'setname','eeglab_data_HP','gui','off');
display('Terminou criação do dataset');

%% lowpass below 40Hz + creates new dataset

EEG = pop_eegfiltnew(EEG, 'hicutoff',40,'plotfreqz',2);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 3,'setname','eeglab_data_LP','gui','off'); 
eeglab redraw;

%% Saves filtered dataset

path_filtered='C:\\Program Files\\MATLAB\\R2020b\\eeglab2021.0\\sample_data\\'

EEG = pop_saveset( EEG, 'filename','eeg_data_filtered.set','filepath',path_filtered);
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
eeglab redraw;
%% re-referencing without eye channels and save

path_ref='C:\\Program Files\\MATLAB\\R2020b\\eeglab2021.0\\sample_data\\';

EEG = pop_reref( EEG, [],'exclude',[2 6] );
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 2,'setname','eegdata_res_noeye','savenew',path_ref,'gui','off');  %Edit/save EEG dataset structure information.
EEG = eeg_checkset( EEG );
% pop_saveh( ALLCOM, 'eeglabhist_dataset.m', 'C:\Program Files\MATLAB\R2020b\eeglab2021.0\sample_data\');
% eeglab redraw; % Scans for non-empty datasets
eeglab redraw;

%% resampling dataset

EEG = pop_resample( EEG, 100); %downsampled dataset to 100 Hz
EEG = eeg_checkset( EEG );
eeglab redraw;

%% removes bad channels (ex below: channel 1 (FPz))

EEG = pop_select( EEG, 'nochannel',{'FPz'});
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 2,'savenew','C:\\Program Files\\MATLAB\\R2020b\\eeglab2021.0\\sample_data\\eeglad_filt_rf_rsmp_bch.set','gui','off'); 
eeglab redraw;

%% extracts data epochs and creates a new dataset

EEG = pop_epoch( EEG, {  'square'  }, [-1  2], 'newname', 'eegdata_res_noeye resampled epochs', 'epochinfo', 'yes');
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 3,'gui','off'); 
eeglab redraw;

%% removes baseline values and creates new dataset

EEG = pop_rmbase( EEG, [-1000 0] ,[]);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 4,'savenew','C:\\Program Files\\MATLAB\\R2020b\\eeglab2021.0\\sample_data\\eeg_data_filtered_reref_resmp_epoch.set','gui','off'); 
eeglab redraw;