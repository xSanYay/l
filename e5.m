M = 16; 
numSymbols = 1e5; 
SNRdB = 0:2:20; 
EbNo = SNRdB + 10*log10(log2(M)); 
impairments = [0.1, 0.05, 0.05, 0.05]; 
SER = zeros(1, length(SNRdB)); 

for k = 1:length(SNRdB)
    data = randi([0 M-1], numSymbols, 1); 
    modSignal = qammod(data, M, 'UnitAveragePower', true); 
    I = real(modSignal); Q = imag(modSignal);
    rx = (1+impairments(1))I *i(1-impairments(1))*Q; 
    rx = rx .* exp(1i*impairments(2)) + impairments(3) + 1i*impairments(4); 
    rx = awgn(rx, SNRdB(k), 'measured'); 
    SER(k) = sum(data ~= qamdemod(rx, M, 'UnitAveragePower', true)) / numSymbols; 
end

% Plot SER vs Eb/No
semilogy(EbNo, SER, 'b-o'); xlabel('E_b/N_0 (dB)'); ylabel('SER');
title('16-QAM SER with Receiver Impairments'); grid on;


disp('SNR (dB)    SER');
disp([SNRdB.' SER.']);


scatterplot(rx);
title('Received Signal Constellation at 20 dB');
grid on
