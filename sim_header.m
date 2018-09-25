%Block Coding
P = [1 1 1; 1 1 0; 1 0 1; 0 1 1];
G = [P eye(4)];
H = [eye(3) P'];
 
%enums
LOW_FEC_LOW_BER     = 0;
LOW_FEC_HIGH_BER    = 1;
HIGH_FEC_LOW_BER    = 2;
HIGH_FEC_HIGH_BER   = 3;
 
%sim params
HIGH_FEC_BITS       = 7;
LOW_FEC_BITS        = 63;
LOW_BER             = 1e-6;
HIGH_BER            = 1e-2;
FADE_TOGGLE_PROB    = 1e-4;
DETECT_TIME         = 1000;
HFHB_HIT_MATRIX = binopdf(1:7,HIGH_FEC_BITS,HIGH_BER);
HFLB_HIT_MATRIX = binopdf(1:7,HIGH_FEC_BITS,LOW_BER);
LFHB_HIT_MATRIX = binopdf(1:7,LOW_FEC_BITS,HIGH_BER);
LFLB_HIT_MATRIX = binopdf(1:7,LOW_FEC_BITS,LOW_BER);
 
%inits
hit_count   = 0;
miss        = 0;
lf          = 0;
hf          = 0;
t           = 0;
STATE       = LOW_FEC_LOW_BER;
FTP_FACTOR  = 1;
FADE_EVENT  = 1;
BER         = LFHB_HIT_MATRIX;
hit_miss    = [0 0 0 0 0 0 0; 0 0 0 0 0 0 0];
 
syndrome_lookup_generation;
