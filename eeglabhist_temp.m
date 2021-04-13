% EEGLAB history file generated on the 08-Apr-2021
% ------------------------------------------------
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG = pop_loadset('filename','eeg_data_filtered_reref.set','filepath','C:\\Program Files\\MATLAB\\R2020b\\eeglab2021.0\\sample_data\\');
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
EEG = eeg_checkset( EEG );
EEG = pop_resample( EEG, 100);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'savenew','C:\\Program Files\\MATLAB\\R2020b\\eeglab2021.0\\sample_data\\eeg_data_filtered_reref_resmp.set','gui','off'); 
pop_saveh( EEG.history, 'eeglabhist_temp.m', 'C:\Users\Cris\Documents\GitHub\eeg_connect\');
EEG = eeg_checkset( EEG );
figure; pop_spectopo(EEG, 1, [0  238310], 'EEG' , 'freq', [6 10 22], 'freqrange',[2 25],'electrodes','off');
EEG = eeg_checkset( EEG );
pop_eegplot( EEG, 1, 1, 1);
EEG = eeg_checkset( EEG );
pop_eegplot( EEG, 1, 1, 1);
EEG = eeg_checkset( EEG );
EEG = pop_select( EEG, 'nochannel',{'FPz'});
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 2,'savenew','C:\\Program Files\\MATLAB\\R2020b\\eeglab2021.0\\sample_data\\eeglad_filt_rf_rsmp_bch.set','gui','off'); 
pop_saveh( ALLCOM, 'eeglabhist_temp.m', 'C:\Users\Cris\Documents\GitHub\eeg_connect\');
EEG = eeg_checkset( EEG );
pop_eegplot( EEG, 1, 1, 1);
EEG = eeg_checkset( EEG );
EEG = pop_epoch( EEG, {  'square'  }, [-1  2], 'newname', 'eegdata_res_noeye resampled epochs', 'epochinfo', 'yes');
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 3,'gui','off'); 
EEG = eeg_checkset( EEG );
EEG = pop_rmbase( EEG, [-1000 0] ,[]);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 4,'savenew','C:\\Program Files\\MATLAB\\R2020b\\eeglab2021.0\\sample_data\\eeg_data_filtered_reref_resmp_epoch.set','gui','off'); 
EEG = eeg_checkset( EEG );
pop_eegplot( EEG, 1, 1, 1);
eeglab redraw;