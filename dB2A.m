function A = dB2A(AdB)
    %dB2A Converts dB to magnitudes (voltage or current)
    A = 10^(AdB/20);
end