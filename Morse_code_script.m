clear
clc 

pulse_seq = morse_encoder("MAE - SPRING 2022");
tone_freq = 750;
dot_duration = 0.06;
sampling_freq1 = 8000;
sampling_freq2 = 4000;

morse_beep(pulse_seq, tone_freq, dot_duration, sampling_freq1)
morse_beep(pulse_seq, tone_freq, dot_duration, sampling_freq2)