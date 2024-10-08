% Define different values of M (number of symbols)
M_values = [2, 4, 8, 16, 32];

% Eb/N0 range in dB
Eb_N0_dB = 0:20;

% Convert Eb/N0 from dB to linear scale
Eb_N0 = 10.^(Eb_N0_dB / 10);

% Initialize arrays to store results
Ps_mpsk = zeros(length(M_values), length(Eb_N0));

% Loop over each value of M
for i = 1:length(M_values)
    M = M_values(i);
    
    % Calculate probability of bit error for MPSK over AWGN channel
    Pe_mpsk = qfunc(sqrt(2 * Eb_N0 * sin(pi/M)^2));
    
    % Calculate probability of symbol error
    Ps_mpsk(i, :) = 1 - (1 - Pe_mpsk).^log2(M);
end

% Plotting
figure;
semilogy(Eb_N0_dB, Ps_mpsk','-o');
grid on;
xlabel('Eb/N0 (dB)');
ylabel('Probability of Symbol Error (Ps)');
title('Probability of Symbol Error for MPSK');
legend('M=2', 'M=4', 'M=8', 'M=16', 'M=32');

% Define different values of M (number of symbols)
M_values = [2, 4, 8, 16, 32];

% Eb/N0 range in dB
Eb_N0_dB = 0:20;

% Convert Eb/N0 from dB to linear scale
Eb_N0 = 10.^(Eb_N0_dB / 10);

% Initialize arrays to store results
Ps_mpam = zeros(length(M_values), length(Eb_N0));

% Loop over each value of M
for i = 1:length(M_values)
    M = M_values(i);
    
    % Calculate probability of bit error for MPAM over AWGN channel
    Pe_mpam = qfunc(sqrt(3 * log2(M) * Eb_N0 / (M^2 - 1)));
    
    % Calculate probability of symbol error
    Ps_mpam(i, :) = 1 - (1 - Pe_mpam).^log2(M);
end

% Plotting
figure;
semilogy(Eb_N0_dB, Ps_mpam','-o');
grid on;
xlabel('Eb/N0 (dB)');
ylabel('Probability of Symbol Error (Ps)');
title('Probability of Symbol Error for MPAM');
legend('M=2', 'M=4', 'M=8', 'M=16', 'M=32');

% Define different values of M (number of symbols)
M_values = [2, 4, 8, 16, 32];

% Eb/N0 range in dB
Eb_N0_dB = 0:20;

% Convert Eb/N0 from dB to linear scale
Eb_N0 = 10.^(Eb_N0_dB / 10);

% Initialize arrays to store results
Ps_mqam = zeros(length(M_values), length(Eb_N0));

% Loop over each value of M
for i = 1:length(M_values)
    M = M_values(i);
    
    % Calculate probability of bit error for MQAM over AWGN channel
    Pe_mqam = 2 * (1 - 1/sqrt(M)) * qfunc(sqrt(3 * log2(M) * Eb_N0 / (2 * (M - 1))));
    
    % Calculate probability of symbol error
    Ps_mqam(i, :) = 1 - (1 - Pe_mqam).^log2(M);
end

% Plotting
figure;
semilogy(Eb_N0_dB, Ps_mqam','-o');
grid on;
xlabel('Eb/N0 (dB)');
ylabel('Probability of Symbol Error (Ps)');
title('Probability of Symbol Error for MQAM');
legend('M=2', 'M=4', 'M=8', 'M=16', 'M=32');

% Define different values of M (number of symbols)
M_values = [2, 4, 8, 16, 32];

% Eb/N0 range in dB
Eb_N0_dB = 0:20;

% Convert Eb/N0 from dB to linear scale
Eb_N0 = 10.^(Eb_N0_dB / 10);

% Initialize arrays to store results
Ps_mfsk = zeros(length(M_values), length(Eb_N0));

% Loop over each value of M
for i = 1:length(M_values)
    M = M_values(i);
    
    % Calculate probability of symbol error for MFSK over AWGN channel
    Ps_mfsk(i, :) = 2 * (1 - qfunc(sqrt((6 * log2(M)) / (M^2 - 1) * Eb_N0)));
end

% Plotting
figure;
semilogy(Eb_N0_dB, Ps_mfsk','-o');
grid on;
xlabel('Eb/N0 (dB)');
ylabel('Probability of Symbol Error (Ps)');
title('Probability of Symbol Error for MFSK');
legend('M=2', 'M=4', 'M=8', 'M=16', 'M=32');

% Define different values of M (number of symbols)
M_values = [2, 4, 8, 16, 32];

% Eb/N0 range in dB
Eb_N0_dB = 0:20;

% Convert Eb/N0 from dB to linear scale
Eb_N0 = 10.^(Eb_N0_dB / 10);

% Initialize arrays to store results
Ps_mfsk_noncoherent = zeros(length(M_values), length(Eb_N0));

% Loop over each value of M
for i = 1:length(M_values)
    M = M_values(i);
    
    % Calculate probability of symbol error for non-coherent MFSK over AWGN channel
    Ps_mfsk_noncoherent(i, :) = 2 * (1 - qfunc(sqrt((3 * log2(M)) / (2 * (M^2 - 1)) * Eb_N0)));
end

% Plotting
figure;
semilogy(Eb_N0_dB, Ps_mfsk_noncoherent','-o');
grid on;
xlabel('Eb/N0 (dB)');
ylabel('Probability of Symbol Error (Ps)');
title('Probability of Symbol Error for Non-coherent MFSK');
legend('M=2', 'M=4', 'M=8', 'M=16', 'M=32');