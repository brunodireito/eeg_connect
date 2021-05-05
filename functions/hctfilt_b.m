function [EEG] = hctfilt_b(EEG, locutoff, hicutoff)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


% Highpass higher locutoff.
EEG = pop_eegfiltnew(EEG, 'locutoff',locutoff,'plotfreqz',1);
% lowpass below hicutoff.
EEG = pop_eegfiltnew(EEG, 'hicutoff',hicutoff,'plotfreqz',2);

end

