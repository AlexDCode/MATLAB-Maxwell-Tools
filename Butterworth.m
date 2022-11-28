function [g, theta, p] = Butterworth(N)
% Butterworth Calculates the Butterworth Element Value Solutions
%   N: Filter Order
    theta = zeros(N,1);
    p = zeros(N,1);
    g = zeros(N,1);
    for k = 1:N
        theta(k) = (2*k - 1)/(2*N)*pi;
        p(k) = -sin(theta(k)+cos(theta(k)*1i));
        g(k) = 2*sin(theta(k));
    end
end