%% CENTRAR EPOCHS NOS ESTÍMULOS VISUAIS DOS SUBTESTES

finputpath='C:\Users\Cris\Desktop\DATA\'; % diretoria em que busca o dataset a utilizar
foutputpathB='C:\Users\Cris\Desktop\DATA_F\'; %diretoria em que guarda o dataset processado neste script
dummy=strcat(finputpath,'*.set'); %vai à diretoria do finput path e busca ficheiros do tipo .set
pp=feval('dir',dummy);
N=length(pp)
LOW=-1;
HIGH=1;
% a=[]
% LATE=[]
S1='1';S2='2';S3='3';S4='4';S5='5';S6='6';S7='7';S20='20';S21='21'; %estas variáveis referem-se aos eventos dos subtestes (1, 2, 3, 4, 5, 6, 7) e às respostas certas e erradas (21, 20)
% RR_T=[]; %right
% WW_T=[]; %wrong
for n=1:1
    dummy=pp(n).name
    inputfilename=strcat(finputpath,dummy);
    outputfilename=strcat(foutputpathB,dummy);
    EEG = pop_loadset('filename',inputfilename); %- load an EEG dataset. If no arguments, pop up an input window.
    %EEG.data=EEG.raw;
    % Remove BASELINE mean before stimulus
    EEG = pop_epoch( EEG, {S3 S4 S5 S6}, [LOW HIGH], 'newname', 'CNT file epochs epochs', 'epochinfo', 'yes'); %faz as epochs centradas nos estímulos visuais dos subtestes 3 a 6
    EEG = eeg_checkset( EEG );
    
    %estas linhas guardam%

EEG = pop_saveset( EEG, 'filename',outputfilename);
EEG = eeg_checkset( EEG );
end






%% 

finputpath='C:\Users\Cris\Desktop\DATA\'; % diretoria em que busca o dataset a utilizar
foutputpath='C:\Users\Cris\Desktop\DATA_F\';  %diretoria em que guarda o dataset processado neste script

outputfilenameA='dummy.fdt';
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
% EEG = pop_loadcnt( inputfilename, 'dataformat', 'auto', 'memmapfile',outputfilenameA);
% EEG = eeg_checkset( EEG );

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



%% CENTRAR EPOCHS NAS RESPOSTAS 
finputpath='C:\Users\Cris\Desktop\DATA\'; % diretoria em que busca o dataset a utilizar
foutputpath='C:\Users\Cris\Desktop\DATA_F\';  %diretoria em que guarda o dataset processado neste script

dummy=strcat(finputpath,'*.set'); %vai à diretoria do finput path e busca ficheiros do tipo .set
pp=feval('dir',dummy);
N=length(pp) %returns the length of the largest array dimension in pp. For vectors, the length is simply the number of elements. For arrays with more dimensions, the length is max(size(pp)). The length of an empty array is zero.

LOW=-1; %this will be the left time limit for each epoch (-1 second)
HIGH=1; %this will be the right time limit for each epoch (1 second)

S1='20' %marker for wrong answers
S2='21' %marker for right answers

for n=1:1 %this cycle was initially <for 1:58> in order to process fifty-eight datasets with the name suj1 to suj 58. However, since there is currently only one such dataset, 'suj1.set', the cycle has been edited to <for 1:1>
    dummy=pp(n).name
    inputfilename=strcat(finputpath,dummy);
    outputfilename=strcat(foutputpath,dummy);
    EEG = pop_loadset('filename',inputfilename); %- load an EEG dataset. If no arguments, pop up an input window.
    %EEG.data=EEG.raw;
    % Remove BASELINE mean before stimulus
    EEG = pop_epoch( EEG, {S1 S2}, [LOW HIGH], 'newname', 'CNT file epochs epochs', 'epochinfo', 'yes'); %faz as epochs centradas no momento das respostas certas (21) ou erradas (20), limitadas
    EEG = eeg_checkset( EEG );
    
    %estas linhas guardam%

EEG = pop_saveset( EEG, 'filename',outputfilename);
%EEG = eeg_checkset( EEG,'epoch') %I added this line to check, through scripting, if the EEG contains epoched or continuous data
%EEG = eeg_checkset(EEG, ) %another testing line (meant to add extra
%keywords after the comma
EEG = eeg_checkset( EEG );
end

%% COUNTER FOR RIGHT ANSWERS(21) AND WRONG ANSWERS(20)


%======CODE FOUND IN: https://sccn.ucsd.edu/pipermail/eeglablist/2009/002597.html======%
%**NOTE: THIS CODE DOES NOT WORK!!!

% allevents = { EEG.event.type }; %fetches all
% eventtypes = unique( allevents );
% 
% for i = 20:length(eventtypes)
%     numbr = strmatch(eventtypes{i}, allevents);
%     fprintf('There are %d events of type %s \n', numbr, eventtypes{i});
% end