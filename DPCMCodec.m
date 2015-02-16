
% DPCM Codec 

%source = [1, 2, 3, 4, 5, 8, 9, 12, 12, 14, 7];

%source = rand(100,1);

[source,fs] = audioread('anvsb1_8kHz.wav');

pred = zeros(size(source));
recon = zeros(size(source));
quant = zeros(size(source));
hamming = zeros(size(source));
hamming = dec2bin(hamming, 4);


% First Order Pred
a = 0.9; %Prediction Coefficient

pred(1) = 0;
for i=2:length(source)
    pred(i) = a * source(i-1);
end

% Error Signal
error = source - pred;

% Quantizer
N = 4;
emax = 0.999 * max(abs(error));
step = emax/(2^N);

for i=1:length(error)
    quant(i) = floor(error(i)/step)*step;
end

% Hamming Module
for i=1:length(quant)
switch quant(i)
    case step*1
        hamming(i,1) = '0'; %0000000
        hamming(i,2) = '0';
        hamming(i,3) = '0';
        hamming(i,4) = '0';
    case step*2 
        hamming(i,1) = '0'; %1101001
        hamming(i,2) = '0';
        hamming(i,3) = '0';
        hamming(i,4) = '1';
    case step*3 
        hamming(i,1) = '0'; %0101010
        hamming(i,2) = '0';
        hamming(i,3) = '1';
        hamming(i,4) = '0';
    case step*4 
        hamming(i,1) = '0'; %1000011
        hamming(i,2) = '0';
        hamming(i,3) = '1';
        hamming(i,4) = '1';
    case step*5 
        hamming(i,1) = '0'; %1001100
        hamming(i,2) = '1';
        hamming(i,3) = '0';
        hamming(i,4) = '0';
    case step*6 
        hamming(i,1) = '0'; %0100101
        hamming(i,2) = '1';
        hamming(i,3) = '0';
        hamming(i,4) = '1';
    case step*7 
        hamming(i,1) = '0'; %1100110
        hamming(i,2) = '1';
        hamming(i,3) = '1';
        hamming(i,4) = '0';
    case step*8 
        hamming(i,1) = '0'; %0001111
        hamming(i,2) = '1';
        hamming(i,3) = '1';
        hamming(i,4) = '1';
    case step*-1 
        hamming(i,1) = '1'; %1110000
        hamming(i,2) = '0';
        hamming(i,3) = '0';
        hamming(i,4) = '0';
    case step*-2
        hamming(i,1) = '1'; %0011001
        hamming(i,2) = '0';
        hamming(i,3) = '0';
        hamming(i,4) = '1';
    case step*-3 
        hamming(i,1) = '1'; %1011010
        hamming(i,2) = '0';
        hamming(i,3) = '1';
        hamming(i,4) = '0';
    case step*-4 
        hamming(i,1) = '1'; %0110011
        hamming(i,2) = '0';
        hamming(i,3) = '1';
        hamming(i,4) = '1';
    case step*-5 
        hamming(i,1) = '1'; %0111100
        hamming(i,2) = '1';
        hamming(i,3) = '0';
        hamming(i,4) = '0';
    case step*-6 
        hamming(i,1) = '1'; %1010101
        hamming(i,2) = '1';
        hamming(i,3) = '0';
        hamming(i,4) = '1';
    case step*-7 
        hamming(i,1) = '1'; %0010110
        hamming(i,2) = '1';
        hamming(i,3) = '1';
        hamming(i,4) = '0';
    case step*-8
        hamming(i,1) = '1'; %1111111
        hamming(i,2) = '1';
        hamming(i,3) = '1';
        hamming(i,4) = '1';
end
end 

% First Order Recon
recon(1) = quant(1);
for i=2:length(quant)
    recon(i) = (a * recon(i-1)) + quant(i);
end;

figure()
plot(source)

figure()
plot(recon)

sound(recon,fs)
