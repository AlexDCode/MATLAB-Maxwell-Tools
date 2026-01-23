function PdBm = W2dBm(P)
    %W2dBm Converts W to dBm
    PdBm = 10.*log10(P./1e-3);
end