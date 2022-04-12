%% Sampling and reconstruction demo
clear,clc,close all;

%% Parameters
F = 400;     % frequency of signal [Hz]
Fs = 6*(F);   % sampling rate [Hz]
Ts = 1/Fs;  % sampling period [sec]

%% Generate "continuous time" signal and discrete time signal
tc = 0:1e-4:6/F;        % CT axis
xc = sawtooth(2*pi*F*tc);    % CT signal
td = 0:Ts:6/F;          % DT axis
xd = sawtooth(2*pi*F*td);    % DT signal
N = length(td);         % number of samples

%% Reconstruction by using the formula:
% xr(t) = sum over n=0,...,N-1: x(nT)*sin(pi*(t-nT)/T)/(pi*(t-nT)/T)
% Note that sin(pi*(t-nT)/T)/(pi*(t-nT)/T) = sinc((t-nT)/T)
% sinc(x) = sin(pi*x)/(pi*x) according to MATLAB
xr = zeros(size(tc));
sinc_train = zeros(N,length(tc));
for t = 1:length(tc)
    for n = 0:N-1
        sinc_train(n+1,:) = sin(pi*(tc-n*Ts)/Ts)./(pi*(tc-n*Ts)/Ts);
        xr(t) = xr(t) + xd(n+1)*sin(pi*(tc(t)-n*Ts)/Ts)/(pi*(tc(t)-n*Ts)/Ts);
    end
end

%% Plot the results
figure
hold on
grid on
plot(tc,xc)
stem(td,xd)
plot(tc,xr)
xlabel('Time [sec]')
ylabel('Amplitude')

%% Sinc train visualization    
figure
hold on
grid on
plot(tc,xd.'.*sinc_train)
stem(td,xd)
xlabel('Time [sec]')
ylabel('Amplitude')

%% FINDING THE PERIOD
 xr =  movmean(xr, 5);
 [~,peaklocs] = findpeaks(xr,tc);
 [~,peaklocsactual]=findpeaks(xc,tc);
 period = mean(diff(peaklocs));
 period1= mean(diff(peaklocsactual));
 disp(period1);
 disp(period);