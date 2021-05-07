function [n_events_trig_to_count] = trigcountperepoch_b(EEG,TRIG_TO_COUNT)
%TRIGCOUNTPEREPOCH_B Summary of this function goes here
%   Detailed explanation goes here

% Number of trails  available in this dataset.
n_trials=EEG.trials;

% Latency of the response.
r_late=zeros(1,n_trials);

% Participant's response per trial.
r_trig= zeros(1,n_trials);

for t=1:n_trials
    % Number of events in trial t.
    n_events=numel(EEG.epoch(t).event);
    
    if n_events>2
        fprintf('WARNING: MORE THAN 2 EVENTS IN A SINGLE EPOCH.')
    end    
    
    fprintf('--Trial %d has %d events\n', t, n_events);
    
    for e=1:n_events
        % Display events available.
        fprintf('--- event %d: event type: %s\n', e, EEG.epoch(t).eventtype{e})
        
        if EEG.epoch(t).eventtype{e}==TRIG_TO_COUNT
            r_trig(t)=str2double(EEG.epoch(t).eventtype{e});
            r_late(t)=EEG.epoch(t).eventlatency{e};
        end
        
    end
    
end

[~,idxs,~]=find(r_trig);

n_events_trig_to_count=numel(idxs);


end

