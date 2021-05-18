%% TEST FOR counting right and wrong using rem() on the latencies
 %NOTE: this ended up returning more than 208 events, which is greater than
 %the number of trials in HCT.
 
 %This is because there are many (latency-1) values at certain events that
 %can be divided by 3 with a 0 remainder AND also be either '20' or '21'
 %markers
 
RAWDATA_PATH='C:\Users\Cris\Desktop\DATA\';
RESULTS_PATH='C:\Users\Cris\Desktop\DATA_F\';

for n=1:1 
    dummyr=strcat(RAWDATA_PATH,'*.set'); 
    ppraw=feval('dir',dummyr);
    N=length(ppraw);
    dummyr=ppraw(n).name;
    RAWDATA_NAME=strcat(RAWDATA_PATH,dummyr);
    EEG = pop_loadset('filename',RAWDATA_NAME);
    [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, n,'setname',RAWDATA_NAME,'gui','off'); 
    eeglab redraw
end

right=0
wrong=0

for e=1:530 %corresponde ao número do eventos do dataset suj1.set que se encontra na diretoria C:\Users\Cris\Desktop\DATA\
    a=EEG.event(e).latency - 1  %vai buscar a latência no evento número e e subtrai 1 para dar número que pode potencialmente ser múltiplo de 3.
    b=rem(a,3) %divide o valor guardado na variável a por 3 e retorna o resto da divisão para a variável b
    if b==0
        if EEG.event(e).type=='20'
            wrong=wrong+1
        elseif EEG.event(e).type=='21'
            right=right+1
        end
        
    end
end
c=right+wrong

%% TEST FOR counting right and wrong using a multiplier

%NOTE: there's the error "Too many input arguments."

RAWDATA_PATH='C:\Users\Cris\Desktop\DATA\';

for n=1:1 
    dummyr=strcat(RAWDATA_PATH,'*.set'); 
    ppraw=feval('dir',dummyr);
    N=length(ppraw);
    dummyr=ppraw(n).name;
    RAWDATA_NAME=strcat(RAWDATA_PATH,dummyr);
    EEG = pop_loadset('filename',RAWDATA_NAME);
    [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, n,'setname',RAWDATA_NAME,'gui','off'); 
    eeglab redraw
end

right=0
wrong=0

for e=28:187
    a=(6001+e*9000);
   if EEG.event.latency==a
      if EEG.event.type=='21'
          right=right+1;
      elseif EEG.event.type=='20'
          wrong=wrong+1;
      end
   end
end

c=right+wrong