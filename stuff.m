%%===========================SCRIPT PARA PROCESSAR OS SUJEITOS================================%%
%Cristina Ferreira de Melo

%NOTE: <eeglab redraw> is added at the end of each section of the script to refresh the
%interface

%% load dataset
path_data='C:\\Users\\Cris\\Desktop\\DATA\\';

[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG = pop_loadset('filename','suj1.set','filepath',path_data);
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
eeglab redraw;

%% high-pass above 0.1Hz + creates new dataset
[EEG ALLEEG CURRENTSET] = eeg_retrieve(ALLEEG,1);
EEG = pop_eegfiltnew(EEG, 'locutoff',0.1,'plotfreqz',1);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 2,'setname','suj1_hp','gui','off');
eeglab redraw;

%% lowpass below 100Hz + creates new dataset
EEG = pop_eegfiltnew(EEG, 'hicutoff',100,'plotfreqz',2);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 3,'setname','suj1_lp','gui','off'); 
eeglab redraw;

%% re-referencing by average value

path_data_ref='C:\\Users\\Cris\\Desktop\\DATA\\';

EEG = pop_reref( EEG, []); %re-refencing by average value (empty [] is average by default)
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 4,'setname','suj1_hplp_ref','savenew',path_data_ref,'gui','off'); 
EEG = eeg_checkset( EEG );
eeglab redraw;


%% ======SECTION MEANT FOR ICA=====%

% More info is needed in order to make an ICA 