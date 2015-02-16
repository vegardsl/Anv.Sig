clear;

Fs = 16000;
sample_duration = 5; %[s]

sequence_length = sample_duration*16000;
%segment_length = 4;
%number_of_segments = sequence_length/segment_length;

P_34 = [   1 0 1 1;
           1 1 0 1;
           1 1 1 0   ]

            
G = [eye(4) P_34']';

H = [P_34 eye(3)];

recieved_signal = [];
list_of_syndromes = [];
for i=1:sequence_length
    %code and transmitt

    msg = randi([0 1],4,1);
    %msg = [ 0;  1;  1;  0];

    coded_msg = mod(G*msg,2); % monulo 2 addition
   
    recieved_signal = [ recieved_signal ;
                        coded_msg'     ];
    
                    
    %receive and chech for errors
    
    %parity check:
    syndrome = H*coded_msg;
    list_of_syndromes = [list_of_syndromes syndrome];
    
    
end
