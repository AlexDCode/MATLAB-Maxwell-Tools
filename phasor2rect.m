function rect = phasor2rect(phasor)
% phasor2rect Complex Number Notation of a Phasor [A phi].
%             Converts phasor of amplitude A and phase phi [deg] in the 
%             form [A phi] to a complex number
% rect = A*(cosd(phi)+1i*sind(phi))

    rect = phasor(1)*(cosd(phasor(2))+1i*sind(phasor(2)));
end