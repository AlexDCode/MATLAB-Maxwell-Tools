function phasor = rect2phasor(x)
% rect2phasor Phasor Notation [A phi_deg] of a Complex Number
%             Converts a complex number x = a+1i*b to a phasor notation
%             with amplitude A and phase phi [deg] in the form [A phi]
% A = abs(x);
% phi = rad2deg(angle(x));

    phasor = [abs(x) rad2deg(angle(x))];
end