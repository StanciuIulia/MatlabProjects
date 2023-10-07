function morse_sound = morse_beep(pulse_seq, tone_freq, dot_duration, sampling_freq)
    
    morse_sound = [];
    %pulse_seq = morse_encoder(message);
    
    sampling_period = 1/sampling_freq;
    t = 0 : sampling_period*2*pi : dot_duration*2*pi;
    
    message_length = length(pulse_seq);
    for i = 1:message_length
             morse_sound = [morse_sound, tone_freq*pulse_seq(i)*cos(t)];
    end
    
    sound(morse_sound)
    figure
    plot(morse_sound)
    xlabel('message duration = time (s)')
    ylabel('tone frequency (Hz)')
    title("Representation of message in morse code for the chosen sampling frequency: " + sampling_freq + "Hz, tone frequency " + tone_freq + " and duration of a pulse " + dot_duration + " seconds.")
            
end