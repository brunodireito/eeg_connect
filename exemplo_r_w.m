%Numero de respostas certas e erradas pou subteste e por ind
%RR_T=[RR_T; RR];
%WW_T=[WW_T; WW];

finputpath='C:\Users\Cris\Desktop\DATA\'; % diretoria em que busca o dataset a utilizar
foutputpath='C:\Users\Cris\Desktop\DATA_F\'; %diretoria em que guarda o dataset processado neste script
%vai à diretoria do finput path e busca ficheiros do tipo .set e depois concatena string horizontalmente. Útil no ciclo for 1:1 abaixo
dummy=strcat(finputpath,'*.set'); 
pp=feval('dir',dummy);

N=length(pp);%returns the length of the largest array dimension in pp. 
%For vectors, the length is simply the number of elements. 
%For arrays with more dimensions, the length is max(size(pp)). The length of an empty array is zero.

LOW=-1;
HIGH=1;
%LATE=[];
S1='1';S2='2';S3='3';S4='4';S5='5';S6='6';S7='7';S20='20';S21='21'; %estas variáveis referem-se aos eventos dos subtestes (1, 2, 3, 4, 5, 6, 7) e às respostas certas e erradas (21, 20)
%RR_T=[];
%WW_T=[];

%This cycle was initially <for 1:58> in order to process fifty-eight datasets with the name suj1 to suj 58. 
%However, since there is currently only one such dataset, 'suj1.set', the cycle has been edited to <for 1:1>
for n=1:1 
    dummy=pp(n).name
    inputfilename=strcat(finputpath,dummy);
    outputfilename=strcat(foutputpath,dummy);
    EEG = pop_loadset('filename',inputfilename);
    %EEG.data=EEG.raw;
    % Remove BASELINE mean before stimulus
    EEG = pop_epoch( EEG, {  S3 S4 S5 S6  }, [LOW HIGH], 'newname', 'CNT file epochs epochs', 'epochinfo', 'yes');                                                  %faz as epochs centradas nos estímulos visuais dos subtestes 3 a 6. Os subtestes 1 e 2 são de treino, enquanto que o 7 é de memória
    EEG = pop_saveset( EEG, 'filename',outputfilename);
    EEG = eeg_checkset( EEG );
end

    [C,N,T]=size(EEG.data) %returns the dimensions of the EEG array, those being C (number of channels), N number of frames per epoch, and T (number of trials)

    Rlate=zeros(1,T);              % tempo da resposta
    RSequence= zeros(1,T);         % POSITIVO CERTA; NEGATIVA ERRADA  
    a=[];
    RR=[];
    WW=[];
    for k=1:T
        a=EEG.epoch(k).eventtype;
        E=length(a);
       % Assuming last a 20 or 21 (answer) and before stimulus
        dum1=EEG.epoch(k).eventtype{1,E};
        if E==1
            Rlate(k)=0;
            dum2='0';       % Previous event not defined;
        else
            dum2=EEG.epoch(k).eventtype{1,E-1};
            Rlate(k)=EEG.epoch(k).eventlatency{1,E-1};
        end

        % Respostas Certas Positivo
           if dum1=='21'
               valor=1;
               R=R+1;
           else %respostas erradas negativo
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
