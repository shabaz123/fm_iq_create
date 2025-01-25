% FM I/Q WAV file generator
% rev 1 - shabaz - feb 2024
% Generates a WAV file containing I and Q components of an
% FM modulated signal. The audio source is a mono WAV file.
% Sample rates are 48 kHz for input and output.

% input audio
audio_fname = 'eveshort-48-mono.wav';
% FM modulation parameters, fd = frequency deviation
fd = 5e3; % 5 kHz
out_bw = 2*(fd + 12e3); % 2*(freq deviation + audio bandwidth (12kHz))
out_fs = 2*out_bw; % 180*2 = 44ksps
% might as well make it 48ksps, for a round number!
out_fs = 48e3;

% read in the source audio
[x,fs] = audioread(audio_fname);

% create the FM modulator object
fmmodulator = comm.FMModulator( ...
    'SampleRate',out_fs, ...
    'FrequencyDeviation',fd);

% perform the FM modulation
y = fmmodulator(x);

% obtain the I/Q components
I = real(y);
Q = imag(y);

% build the stereo WAV file containing the I and Q outputs
IQ_stereo = [I';Q']';
audiowrite('iq_file.wav', IQ_stereo, 48e3);
