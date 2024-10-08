M = 16; 
numSymbols = 1e5; 
SNRdB = 0:2:20; % Parameters
EbNo = SNRdB + 10*log10(log2(M)); % SNR to Eb/No
impairments = [0.1, 0.05, 0.05, 0.05]; % [gainImbalance, phaseMismatch, dcOffsetI, dcOffsetQ]
SER = zeros(1, length(SNRdB)); % Initialize SER array

for k = 1:length(SNRdB)
    data = randi([0 M-1], numSymbols, 1); % Random symbols
    modSignal = qammod(data, M, 'UnitAveragePower', true); % Modulate
    I = real(modSignal); Q = imag(modSignal);
    rx = (1+impairments(1))I + i(1-impairments(1))*Q; % Apply impairments
    rx = rx .* exp(1i*impairments(2)) + impairments(3) + 1i*impairments(4); % Phase & DC offsets
    rx = awgn(rx, SNRdB(k), 'measured'); % Add noise
    SER(k) = sum(data ~= qamdemod(rx, M, 'UnitAveragePower', true)) / numSymbols; % SER calculation
end

% Plot SER vs Eb/No
semilogy(EbNo, SER, 'b-o'); xlabel('E_b/N_0 (dB)'); ylabel('SER');
title('16-QAM SER with Receiver Impairments'); grid on;

% Display SER for each SNR point
disp('SNR (dB)    SER');
disp([SNRdB.' SER.']);

% Plot constellation at the highest SNR (no extra figure)
scatterplot(rx);
title('Received Signal Constellation at 20 dB');
grid on