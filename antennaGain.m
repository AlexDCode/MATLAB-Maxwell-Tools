function antenna_gain_dB = antennaGain(filename, spacing)
    % Read S-parameter data from Touchstone file
    data = sparameters(filename);
    
    % Extract frequency and S-parameter matrices
    freq = data.Frequencies;
    S21 = abs(squeeze(data.Parameters(2,1,:)));
    
    % Assuming S-parameters are in a 2x2 matrix format
    
    % Define constants
    c = 3e8; % Speed of light (m/s)
    lambda = c./freq; % Wavelength (m)
        
    % Calculate the complex exponential factor
    friis = (lambda./(4*pi*spacing)).^2;
    
    % Calculate gain
    antenna_gain_dB = 10*log10(sqrt((S21.^2)./friis));
    plot(freq/1e9, antenna_gain_dB);
    title('Antenna Gain')
    ylabel('Gain [dBi]')
    xlabel('Frequency [GHz]')
    pltAcademic(gcf,'display')
    ylim([0 int16(1.1*max(antenna_gain_dB))])
    yticks(0:2:int16(1.1*max(antenna_gain_dB)));
    xlim('auto')
end