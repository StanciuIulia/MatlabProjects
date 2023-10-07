dot_duration = 0.06;
tone_freq = 700;
sampling_frequency = 8000;
sampling_period = 1/sampling_frequency; 
samples = 4000;

t = 0 : sampling_period*2*pi : dot_duration*2*pi;

[pulse_seq,sampling_frequency] = audioread('morse_audio_signal.wav');
message_length = length(pulse_seq);
figure
plot(pulse_seq(1:samples));

%sound(pulse_seq,sampling_frequency);

N = length(pulse_seq);
xdft = fft(pulse_seq);
xdft = xdft(1:N/2+1);
psdx = (1/(sampling_frequency*N)) * abs(xdft).^2;
psdx(2:end-1) = 2*psdx(2:end-1);
freq = 0:sampling_frequency/N:sampling_frequency/2;

figure
periodogram(pulse_seq,rectwin(N),N,sampling_frequency)
grid on
title("Periodogram Using FFT")
xlabel("Frequency (Hz)")
ylabel("Frequency (Hz)")



n = 0:1:(length(pulse_seq)-1);
sinusoidal_signal = pulse_seq.*(sin(2*pi*(tone_freq/sampling_frequency)*n))';
filtered_coefficients = fir1(64,5/(dot_duration*sampling_frequency));
result = filter(filtered_coefficients,1,sinusoidal_signal);

figure
stairs(result)

morse_derivate = diff(result);
plot(morse_derivate)
%findpeaks(morse_derivate, 0.005);

signal = findpeaks(morse_derivate, sampling_frequency);
disp(signal)
