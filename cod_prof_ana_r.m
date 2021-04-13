%% 
finputpath='C:\Users\Cris\Desktop\PROJ_ESTAG\SUJEITOS\';  
dummy=strcat(finputpath,'suj1.set');
pp=feval('dir',dummy);
N=length(pp);
LOW=-1;
HIGH=1;
a=[]
LATE=[]
S1='1';S2='2';S3='3';S4='4';S5='5';S6='6';S7='7';S20='20';S21='21';
RR_T=[]; %right
WW_T=[]; %wrong
for n=1:58
    dummy=pp(n).name;
    inputfilename=strcat(finputpath,dummy);
    EEG = pop_loadset('filename',inputfilename); %- load an EEG dataset. If no arguments, pop up an input window.
    %EEG.data=EEG.raw;
    % Remove BASELINE mean before stimulus
    EEG = pop_epoch( EEG, {S1 S2  S3 S4 S5 S6 S7 }, [LOW HIGH], 'newname', 'CNT file epochs epochs', 'epochinfo', 'yes');
    EEG = pop_loadset('filename',inputfilename);
    EEG = eeg_checkset( EEG );
end

%estas linhas guardam%
EEG = pop_saveset( EEG, 'filename',outputfilenameB);
EEG = eeg_checkset( EEG );



%% 

finputpath='C:\Users\Cris\Desktop\PROJ_ESTAG\SUJEITOS\'; %ALTERAR O PATH%
foutputpath='C:\Users\Cris\Desktop\PROJ_ESTAG\SUJEITOS\FilteredD\';  %ALTERAR O PATH%

outputfilenameA='dummy.fdt'
% Epoc
LOW=-1
HIGH=1
%Stimulus
S1='20'
S2='21'
% EPOCHS of the data directory.

p=feval('dir',finputpath)

N=length(p)


for n=1:1
    dummy=p(n).name
 %input file name  
    inputfilename=strcat(finputpath,dummy)
 %Output file name   
     inx=findstr(dummy,'_');
   name =strcat(dummy(1:inx-1),'.set')
outputfilenameB=strcat(foutputpath,name);

% storage in disk of the data *.fdt
EEG = pop_loadcnt( inputfilename, 'dataformat', 'auto', 'memmapfile',outputfilenameA);
EEG = eeg_checkset( EEG );
%to save the epoch into set files....

EEG = pop_epoch( EEG, {  S1 S2  }, [LOW  HIGH], 'newname','CNT file epochs' , 'epochinfo', 'yes');
EEG = eeg_checkset(EEG);

% SAMPLES or milliseconds .... baseline.....OR only works with
% srate=1000Hz..........(1000 rates/frames each second)
srate=EEG.srate;
baseline=[LOW*srate HIGH*srate-1]
EEG = pop_rmbase( EEG, baseline );
EEG = eeg_checkset( EEG );
clear EEG
end
