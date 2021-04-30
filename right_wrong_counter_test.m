%% CENTRAR EPOCHS NOS ESTÍMULOS VISUAIS DOS SUBTESTES

finputpath='C:\Users\Cris\Desktop\DATA\'; % diretoria em que busca o dataset a utilizar
foutputpath='C:\Users\Cris\Desktop\DATA_F\'; %diretoria em que guarda o dataset processado neste script
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
    outputfilename=strcat(foutputpath,dummy);
    EEG = pop_loadset('filename',inputfilename); %- load an EEG dataset. If no arguments, pop up an input window.
    %EEG.data=EEG.raw;
    % Remove BASELINE mean before stimulus
    EEG = pop_epoch( EEG, {S3 S4 S5 S6}, [LOW HIGH], 'newname', 'CNT file epochs epochs', 'epochinfo', 'yes'); %faz as epochs centradas nos estímulos visuais dos subtestes 3 a 6
    EEG = eeg_checkset( EEG );
    
    %estas linhas guardam%

EEG = pop_saveset( EEG, 'filename',outputfilename);
EEG = eeg_checkset( EEG );
end

[C,N,T]=size(EEG.data)

Rlate=zeros(1,T);              % tempo da resposta
RSequence= zeros(1,T);         % POSITIVO CERTA; NEGATIVA ERRADA     
RR=[];
WW=[];
for k=1:T
    a=EEG.epoch(k).eventtype;
    E=length(a);
   % Assuming last a 20 or 21 (answer) and before stimulus
    dum1=EEG.epoch(k).eventtype{1,E};
    if E==1
        Rlate(k)=0;
        dum2='0';       % Previous event no defined;
    else
        dum2=EEG.epoch(k).eventtype{1,E-1};
        Rlate(k)=EEG.epoch(k).eventlatency{1,E-1};
end
    
    % Respostas Certas Positivo
       if dum1=='21'
           valor=1;
           R=R+1;
       else
           valor=-1;
           W=W+1;
       end
          switch dum2
       
       case '1'
        Rsequence(k)=valor*1;
        t(k)=1
        case '2'
            Rsequence(k)=valor*2;
            t(k)=2
        case '3'
            Rsequence(k)=valor*3;  
            t(k)=3;
             
        case '4' 
            Rsequence(k)=valor*4;   
            t(k)=4;
        case '5'        
            Rsequence(k)=valor*5;
            t(k)=5;
        case '6'
            Rsequence(k)=valor*6;   
            t(k)=6;
         case '7'
             Rsequence(k)=valor*7;
             t(k)=7;
         otherwise
             Rsequence(k)=0;
             t(k)=0;
          end
    end