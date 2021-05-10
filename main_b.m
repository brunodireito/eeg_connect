%% -- define global variables --

clear all;
close all;

% Define variables that will be required throughou the project.

% addpath - add important folders to the path
addpath('functions')

CHANS_STANDARD='/Users/home/Documents/GitHub/eeglab/plugins/dipfit/standard_BEM/elec/standard_1005.elc';

% paths.
RAWDATA_PATH='C:\Users\bdireito\Desktop\Data\HCT';
% RAWDATA_PATH='/Volumes/ELEMENT/EEG_HCT/data/';

RESULTS_PATH='results';

% variables / TRIGGERS.
% e.g. Triggers for correct or wrong asnswers.
TRI_CORRECT='21';
TRI_WRONG='20';
% Triggers corresponding to each subtest.
TRI_ST1='1';
TRI_ST2='2';
TRI_ST3='3';
TRI_ST4='4';
TRI_ST5='5';
TRI_ST6='6';
TRI_ST7='7';

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
    fprintf('--- No .set available.\n')
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
    
    % Set chans position
    EEG=pop_chanedit(EEG, 'lookup',CHANS_STANDARD,'load',{'data/hct_chan_locs.ced','filetype','autodetect'});
    % Plot positions
    figure; topoplot([],EEG.chanlocs, 'style', 'blank',  'electrodes', 'labelpoint', 'chaninfo', EEG.chaninfo);
    
    % remove fields
    EEG=rmfield(EEG, {'dataF', 'delta', 'theta', 'alpha', 'betaL', 'betaH', 'gamma'});
    
    % filter data.
    EEG=hctfilt_b(EEG, LOWCUTOFF, HIGHCUTOFF);

    % Resample data.    
    EEG=pop_resample( EEG, RESAMPLEFREQ);
    
    % Re-epoch around triggers.
    EEG=triggerepoching_b(EEG, {TRI_CORRECT, TRI_WRONG}, [-6 2.999]);
    
    EEG=pop_saveset(EEG,...
            'filename',sprintf('%s_re-epoched%s',FILENAME, EXT),...
            'filepath',fnames(p).folder);
end

%% ICA

%% Count events
n_responses=trigcountperepoch_b(EEG, TRI_CORRECT);


%% Time-frequency example
chan_to_plot='O1';
chan_idx=find(strcmp({EEG.chanlocs.labels}, chan_to_plot));

%figure; topoplot([],EEG.chanlocs, 'style', 'blank',  'electrodes', 'labelpoint', 'chaninfo', EEG.chaninfo);

figure; pop_newtimef( EEG, 1, chan_idx,...
    [-1000   990], [3         0.8] ,...
    'topovec', 1,...
    'elocs', EEG.chanlocs,...
    'chaninfo', EEG.chaninfo,...
    'caption', chan_to_plot,...
    'baseline',[0],...
    'plotphase', 'off',...
    'padratio', 1,...
    'winsize', 100);



%% % EEGLAB history file generated on the 11-May-2021
% ------------------------------------------------
eeglab('redraw');
[EEG ALLEEG CURRENTSET] = eeg_retrieve(ALLEEG,1);
EEG = eeg_checkset( EEG );
EEG=pop_chanedit(EEG, 'lookup','/Users/home/Documents/GitHub/eeglab/plugins/dipfit/standard_BEM/elec/standard_1005.elc','load',{'/Users/home/Documents/GitHub/eeg_connect/data/hct_chan_locs.ced','filetype','autodetect'});
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
EEG = eeg_checkset( EEG );
figure; topoplot([],EEG.chanlocs, 'style', 'blank',  'electrodes', 'labelpoint', 'chaninfo', EEG.chaninfo);
pop_saveh( ALLCOM, 'eeglabhist.m', '/Users/home/Documents/GitHub/eeg_connect/');
EEG = eeg_checkset( EEG );
pop_eegplot( EEG, 1, 1, 1);
EEG = eeg_checkset( EEG );
pop_eegplot( EEG, 1, 1, 1);
EEG = eeg_checkset( EEG );
pop_eegplot( EEG, 1, 1, 1);
EEG = eeg_checkset( EEG );
figure; topoplot([],EEG.chanlocs, 'style', 'blank',  'electrodes', 'labelpoint', 'chaninfo', EEG.chaninfo);
EEG = eeg_checkset( EEG );
pop_eegplot( EEG, 1, 1, 1);
[ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG, CURRENTSET);
EEG = eeg_checkset( EEG );
pop_eegplot( EEG, 1, 1, 1);
EEG = eeg_checkset( EEG );
EEG = pop_runica(EEG, 'icatype', 'runica', 'extended',1,'interrupt','on');
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
pop_saveh( ALLCOM, 'eeglabhist.m', '/Users/home/Documents/GitHub/eeg_connect/');
EEG = eeg_checkset( EEG );
pop_topoplot(EEG, 0, [1:28] ,'HCT epoched trigs',[5 6] ,0,'electrodes','on');
EEG = eeg_checkset( EEG );
pop_selectcomps(EEG, [1:28] );
EEG = eeg_checkset( EEG );
pop_eegplot( EEG, 0, 1, 1);
EEG = eeg_checkset( EEG );
pop_prop( EEG, 0, 1, NaN, {'freqrange',[2 50] });
EEG = eeg_checkset( EEG );
pop_prop( EEG, 0, 6, NaN, {'freqrange',[2 50] });
EEG = eeg_checkset( EEG );
figure; pop_erpimage(EEG,0, [1],[[]],'Comp. 1',10,1,{},[],'' ,'yerplabel','','erp','on','cbar','on','topo', { mean(EEG.icawinv(:,[1]),2) EEG.chanlocs EEG.chaninfo } );
EEG = eeg_checkset( EEG );
EEG = pop_runica(EEG, 'icatype', 'runica', 'extended',1,'interrupt','on');
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
EEG = eeg_checkset( EEG );
pop_topoplot(EEG, 0, [1:26] ,'HCT epoched trigs',[5 6] ,0,'electrodes','on');
EEG = eeg_checkset( EEG );
pop_eegplot( EEG, 0, 1, 1);
EEG = eeg_checkset( EEG );
pop_prop( EEG, 0, 1, NaN, {'freqrange',[2 50] });
EEG = eeg_checkset( EEG );
pop_prop( EEG, 0, 19, NaN, {'freqrange',[2 50] });
EEG = eeg_checkset( EEG );
pop_prop( EEG, 0, 25, NaN, {'freqrange',[2 50] });
EEG = eeg_checkset( EEG );
pop_eegplot( EEG, 1, 1, 1);
EEG = pop_iclabel(EEG, 'default');
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
EEG = pop_icflag(EEG, [NaN NaN;0.9 1;0.9 1;NaN NaN;NaN NaN;NaN NaN;NaN NaN]);
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
EEG = eeg_checkset( EEG );
EEG = pop_subcomp( EEG, [1], 0);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'savenew','/Volumes/ELEMENT/EEG_HCT/data/suj1_re-epoched_ICA.set','gui','off'); 
EEG = eeg_checkset( EEG );
pop_eegplot( EEG, 1, 1, 1);
EEG = eeg_checkset( EEG );
EEG=pop_chanedit(EEG, 'changefield',{28,'labels','AFp9'},'lookup','/Users/home/Documents/GitHub/eeglab/plugins/dipfit/standard_BEM/elec/standard_1005.elc','changefield',{27,'labels','AFp10'},'lookup','/Users/home/Documents/GitHub/eeglab/plugins/dipfit/standard_BEM/elec/standard_1005.elc');
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
EEG = eeg_checkset( EEG );
figure; topoplot([],EEG.chanlocs, 'style', 'blank',  'electrodes', 'labelpoint', 'chaninfo', EEG.chaninfo);
EEG = eeg_checkset( EEG );
EEG = pop_saveset( EEG, 'savemode','resave');
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
EEG = eeg_checkset( EEG );
EEG = pop_runica(EEG, 'icatype', 'runica', 'extended',1,'interrupt','on');
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
EEG = eeg_checkset( EEG );
EEG = pop_iclabel(EEG, 'default');
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
EEG = eeg_checkset( EEG );
pop_eegplot( EEG, 0, 1, 1);
EEG = eeg_checkset( EEG );
pop_prop( EEG, 0, 1, NaN, {'freqrange',[2 50] });
EEG = pop_icflag(EEG, [NaN NaN;0.9 1;0.6 1;NaN NaN;NaN NaN;NaN NaN;NaN NaN]);
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
EEG = eeg_checkset( EEG );
EEG = pop_subcomp( EEG, [  2121], 0);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 2,'setname','HCT epoched trigs pruned with ICA','overwrite','on','gui','off'); 
EEG = eeg_checkset( EEG );
EEG = pop_saveset( EEG, 'savemode','resave');
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
eeglab redraw;
