% EEGLAB history file generated on the 05-May-2021
% ------------------------------------------------
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG = pop_loadset('filename','suj1.set','filepath','C:\\Users\\bdireito\\Desktop\\Data\\HCT\\');
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
eeglab redraw;
