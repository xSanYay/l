numBits = 20;
numHops = 6; 
hopFrequencies = [1, 2, 3, 4, 5, 6] * 1e3; 
hopDuration = 1e-3; 
snr = 10; 
fs = 20e3; 
dataBits = randi([0 1], numBits, 1);
modulatedData = 2*dataBits - 1; % BPSK mapping (0 -> -1, 1 -> 1)
bpskSignal = repelem(modulatedData, hopDuration*fs); % Create rectangular wave
t = (0:1/fs:hopDuration-1/fs)';
fhssSignal = [];
hopSignal = [];
for i = 1:numBits
    hopIdx = mod(i-1, numHops) + 1;
    freq = hopFrequencies(hopIdx);
    carrier = cos(2*pi*freq*t);
    hopSignal = [hopSignal; carrier];
    fhssSignal = [fhssSignal; bpskSignal((i-1)length(t)+1:i*length(t)) . carrier];
end
receivedSignal = awgn(fhssSignal, snr, 'measured');
demodulatedSignal = [];
receivedBits = zeros(numBits, 1);

for i = 1:numBits
    hopIdx = mod(i-1, numHops) + 1;
    freq = hopFrequencies(hopIdx);
    carrier = cos(2*pi*freq*t);
    segment = receivedSignal((i-1)*length(t)+1:i*length(t));
    demodulated = segment .* carrier;
    demodulatedSignal = [demodulatedSignal; demodulated];
    receivedBits(i) = sum(demodulated) > 0;
end
figure;
subplot(3, 2, 1);
stem(dataBits, 'filled');
title('Original 20-bit Sequence');
xlabel('Bit Index');
ylabel('Bit Value');
grid on;
subplot(3, 2, 2);
plot(bpskSignal);
title('BPSK Modulated Signal (Rectangular Wave)');
xlabel('Sample Index');
ylabel('Amplitude');
grid on;
subplot(3, 2, 3);
plot(hopSignal);
title('Spread Signal with 6 Frequencies');
xlabel('Sample Index');
ylabel('Amplitude');
grid on;
subplot(3, 2, 4);
plot(fhssSignal);
title('Frequency Hopped Spread Spectrum Signal');
xlabel('Sample Index');
ylabel('Amplitude');
grid on;
subplot(3, 2, 5);
plot(demodulatedSignal);
title('Demodulated BPSK Signal from Spread Signal');
xlabel('Sample Index');
ylabel('Amplitude');
grid on;
subplot(3, 2, 6);
stem(receivedBits, 'filled');
title('Original Transmitted Bits Sequence at Receiver');
xlabel('Bit Index');
ylabel('Bit Value');
grid on;
BER_FHSS = sum(dataBits ~= receivedBits) / numBits;
fprintf('FHSS BER: %e\n', BER_FHSS);
