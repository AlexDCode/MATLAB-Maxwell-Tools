function [g, epsilon, eta, theta, p] = Chebyshev(N,ripple_dB)
%Chebyshev Calculates the Chebyshev Element Value Solutions
%   N: Filter Order
%   ripple_dB: [dB] Passband Ripple

    theta = zeros(N,1);
    p = zeros(N,1);
    g = zeros(N+1,1);
    
    epsilon = sqrt(10^(ripple_dB/10)-1);
    eta = sinh((1/N)*asinh(1/epsilon));
    g(1) = (2/eta)*sin(pi/(2*N));
    for k = (1:N)
        theta(k) = (2*k - 1)/(2*N) * pi;
        p(k) = -eta*sin(theta(k)) - 1i*sqrt(1+eta^2)*cos(theta(k));
        g(k+1) = 4*sin((2*k - 1)/(2*N) * pi)*sin((2*k + 1)/(2*N) * pi)/(g(k)*(eta^2+(sin(k*pi/N))^2));
    end
    
    if rem(N, 2) == 0
        g(N+1) = (epsilon + sqrt(1+epsilon^2))^2;
    else
        g(N+1) = 1;
    end
end