N = 64;              
CP_len = 16;         
SNR_dB = 0:2:30;     
numSymbols = 1000;   
M_values = [4, 8, 16, 32, 64];  
SER = zeros(length(SNR_dB), length(M_values));
for mIdx = 1:length(M_values)
    M = M_values(mIdx); 

    for idx = 1:length(SNR_dB)    
        data = randi([0 M-1], N, numSymbols);
        modData = pskmod(data, M, pi/M);
        ifftData = ifft(modData, N);
        cpData = [ifftData(end-CP_len+1:end, :); ifftData
        txSignal = cpData(:);
        rxSignal = awgn(txSignal, SNR_dB(idx), 'measured');
        rxSignal = reshape(rxSignal, N + CP_len, numSymbols);       
        rxSignal_noCP = rxSignal(CP_len+1:end, :);
        fftData = fft(rxSignal_noCP, N);
        demodData = pskdemod(fftData, M, pi/M);
        numSymbolErrors = sum(sum(data ~= demodData));
        SER(idx, mIdx) = numSymbolErrors / (N * numSymbols);
    end
end


figure;
semilogy(SNR_dB, SER, 'o-');
xlabel('SNR (dB)');
ylabel('Symbol Error Rate (SER)');
title('MPSK-CP-OFDM SER vs. SNR for Multiple Modulation Orders');
legend(arrayfun(@(x) sprintf('%d-PSK', x), M_values, 'UniformOutput', false));
grid on;


