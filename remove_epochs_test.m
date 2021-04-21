%% loads dataset
path_data='C:\\Users\\Cris\\Desktop\\PROJ_ESTAG\\SUJEITOS\\';

[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG = pop_loadset('filename','suj1_hplp_ref.set','filepath',path_data);
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
eeglab redraw;

%% 
EEG = eeg_epoch2continuous(EEG);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 3,'setname','suj1_CONT','gui','off'); 
eeglab redraw;