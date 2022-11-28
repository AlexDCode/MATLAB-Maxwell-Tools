function M = dB2M(MdB)
    %dB2M Converts dB to magnitudes (power)
    M = 10^(MdB/10);
end