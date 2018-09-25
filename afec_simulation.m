sim_header;
for i = 1:1e6;
if rand < (FADE_TOGGLE_PROB*FTP_FACTOR)
    FADE_EVENT = mod(FADE_EVENT+1,2);
end
switch STATE
    case LOW_FEC_LOW_BER
        BER = LFLB_HIT_MATRIX;
        lowfec;
        if FADE_EVENT == 1;
            t = 0;
            STATE = LOW_FEC_HIGH_BER;
            FTP_FACTOR = 9;
        end
        
    case LOW_FEC_HIGH_BER
        BER = LFHB_HIT_MATRIX;
        lowfec;
        if FADE_EVENT == 0;
            STATE = LOW_FEC_LOW_BER;
            FTP_FACTOR = 9;
        end
        if t>= DETECT_TIME
            STATE = HIGH_FEC_HIGH_BER;
            FTP_FACTOR = 1;
        end
        t = t+9;
        
    case HIGH_FEC_HIGH_BER
        BER = HFHB_HIT_MATRIX;
        highfec;
        if FADE_EVENT == 0
            t = 0;
            STATE = HIGH_FEC_LOW_BER;
            FTP_FACTOR = 1;
        end
        
    case HIGH_FEC_LOW_BER
        BER = HFLB_HIT_MATRIX;
        highfec;
        if FADE_EVENT == 1
            STATE = HIGH_FEC_HIGH_BER;
            FTP_FACTOR = 1;
        end
        if t >= DETECT_TIME
            STATE = LOW_FEC_LOW_BER;
            FTP_FACTOR = 9;
        end
        t = t + 1;
end
end
eff = (lf*57/9 + hf*4)/((lf+hf)*7)
ABER = 10*log10(miss/((lf+hf)*7));
BER_SYS = 10*log10(hit_count/((lf+hf)*7));
GAIN = BER_SYS-ABER
