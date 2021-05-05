function [EEG] = triggerepoching_b(EEG, triggers, interval)
%TRIGGEREPOCHING Summary of this function goes here
%   Detailed explanation goes here

% example:  [EEG] = triggerepoching(EEG, {1 2}, [-1 1])
BEFORE=interval(1);
AFTER=interval(2);

% extract epochs around *triggers* with *interval* 
EEG = pop_epoch( EEG,...
    triggers,...
    interval,...
    'newname', 'HCT epoched trigs',...
    'epochinfo', 'yes'); 

% Remove baseline.
% Use the entire epoch? de-mean?
baseline=[(BEFORE*EEG.srate) (AFTER*EEG.srate)-1];
EEG = pop_rmbase( EEG, baseline );

end

