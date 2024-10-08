M = 2; numBits = 1e3; chipRate = 10; snr = 10; fs = 1000;

% Generate random bits and perform BPSK modulation
dataBits = randi([0, 1], numBits, 1);
modulatedData = 2*dataBits - 1;

% Generate and modulate PN sequence
pnSequence = 2*randi([0, 1], numBits*chipRate, 1) - 1;
spreadSignal = repelem(modulatedData, chipRate) .* pnSequence;

% Transmit over AWGN channel and despread
receivedSignal = awgn(spreadSignal, snr, 'measured');
despreadSignal = receivedSignal .* pnSequence;
despreadBits = sum(reshape(despreadSignal, chipRate, numBits), 1)' / chipRate;

% Demodulation and BER calculation
receivedBits = despreadBits > 0;
BER_DSSS = mean(dataBits ~= receivedBits);

% Spectrum calculation using a common function
spectrumPlot = @(x) fftshift(fft(x, length(x)));

% Plotting
figure;
titles = {'Message Signal', 'PN Code', 'Spread Signal', 'Received Signal', 'Despread Signal', 'Demodulated Signal'};
data = {modulatedData, pnSequence, spreadSignal, receivedSignal, despreadSignal, despreadBits};
for i = 1:6
    subplot(3, 2, i);
    plot((-length(data{i})/2:length(data{i})/2-1)*(fs/length(data{i})), abs(spectrumPlot(data{i})));
    title([titles{i}, ' Spectrum']);
    xlabel('Frequency (Hz)'); ylabel('Magnitude');
    grid on;
end

fprintf('DSSS BER: %e\n', BER_DSSS);