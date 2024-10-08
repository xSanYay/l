M = 2; numBits = 1e3; chipRate = 10; snr = 10; fs = 1000;

dataBits = randi([0, 1], numBits, 1);
modulatedData = 2*dataBits - 1;


pnSequence = 2*randi([0, 1], numBits*chipRate, 1) - 1;
spreadSignal = repelem(modulatedData, chipRate) .* pnSequence;
receivedSignal = awgn(spreadSignal, snr, 'measured');
despreadSignal = receivedSignal .* pnSequence;
despreadBits = sum(reshape(despreadSignal, chipRate, numBits), 1)' / chipRate;

receivedBits = despreadBits > 0;
BER_DSSS = mean(dataBits ~= receivedBits);

spectrumPlot = @(x) fftshift(fft(x, length(x)));


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
t = (0:length(data{i})-1) / fs; 
    % Plot the signal in time domain
    plot(t, data{i});
    title([titles{i}, ' (Time Domain)']);
    xlabel('Time (s)');
    ylabel('Amplitude');
    grid on;
