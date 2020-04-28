function corrected_phase = addPis(uncorrected_phase, omega_range)
%Both inputs are column vectors
%Frequency's (omega's) units are inverse frames
%uncorrected_phase units are degrees.

uncorrected_phase = uncorrected_phase*(pi/180);

exp_phases = exp(2i*uncorrected_phase);

time = 1:length(uncorrected_phase);

bigMatrix = omega_range*time;
bigMatrix = -2i*bigMatrix;
bigMatrix  = exp(bigMatrix);

output = bigMatrix*exp_phases;
output = sum(output, 2);
plot(omega_range, abs(output));

[~, idx] = max(abs(output));

omega_0 = omega_range(idx);
phi = angle(output(idx));

predicted_phase = omega_0*time+phi;
corrected_phase = mod((uncorrected_phase' - predicted_phase+(pi/2)),pi)+predicted_phase-(pi/2);
end
