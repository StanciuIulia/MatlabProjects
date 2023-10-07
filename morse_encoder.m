function pulse_seq = morse_encoder(message)

load('morse.mat')

if nargout==0
    pulse_seq = strings;
    string_message = char(message);
    new_message = upper(string_message);
    for i = 1:length(new_message)
        j = find(Alpha == new_message(i));
        str = char(Morse(j));
        pulse_seq = append(pulse_seq, str);
        if( i ~= length(new_message))
            if(new_message(i) == " ")
                pulse_seq = append(pulse_seq, '       ');
            else
                pulse_seq = append(pulse_seq, ' ');
            end
        end
    end
else
    pulse_seq = [];
    string_message = char(message);
    new_message = upper(string_message);
    for i = 1:length(new_message)
        j = find(Alpha == new_message(i));
        string = char(Morse(j));
        for k = 1:length(string)
            switch string(k)
                case "."
                    pulse_seq = [pulse_seq, 1];
                    if( k~= length(string) )
                        switch string(k+1)
                            case "."
                                pulse_seq = [pulse_seq, 0];
                            case "-"
                                pulse_seq = [pulse_seq, 0];
                        end
                    else 
                        if( i~= length(new_message))
                            pulse_seq = [pulse_seq, 0, 0, 0];
                        end
                    end
                    
                case "-"
                    pulse_seq = [pulse_seq, 1, 1, 1];
                    if( k~= length(string) )
                        switch string(k+1)
                            case "."
                                pulse_seq = [pulse_seq, 0];
                            case "-"
                                pulse_seq = [pulse_seq, 0];
                        end
                    else 
                        if( i~= length(new_message))
                            pulse_seq = [pulse_seq, 0, 0, 0, 0, 0, 0, 0];
                        end
                    end
            end
        end
    end 
end


end

