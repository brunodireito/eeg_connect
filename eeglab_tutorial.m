% EEGlab tutorial

%% Run ONE section each time 

% Open EEGlab interface
eeglab

%% 
EEG = pop_loadset( 'filename', 'eeglab_data.set', 'filepath', '/Users/home/Documents/GitHub/eeglab/sample_data/');
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
EEG = eeg_checkset( EEG );
pop_eegplot( EEG, 1, 1, 1);

eeglab redraw;

%% 
% change path back to previous path
cd(current_path)