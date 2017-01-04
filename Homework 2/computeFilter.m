% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %% Sudarson Selvaraj - 387649
% %% Mikko Honkanen - 387608
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [ filter ] = computeFilter( mids, freqs )
%COMPUTEFILTER Computes triangular filters
%   Computes and plots triangular filters.

%% Initialize the filter matrix
filter = zeros(26,257);
length(mids)
%% Loop through the mid values and compute the filter value for each frequency
for t = 1:length(mids)
    for i = 1:length(freqs)
        % skip the first dummy filter
        if t == 1
            continue;
        end
        
        if freqs(i) < mids(t-1)
            filter(t,i) = 0;
        elseif freqs(i) >= mids(t-1) && freqs(i) < mids(t)
            filter(t,i) = (2*(freqs(i)-mids(t-1)))/((mids(t+1)-mids(t-1))*(mids(t)-mids(t-1)));
        elseif freqs(i) >= mids(t) && freqs(i) <= mids(t+1)
            filter(t,i) = (2*(mids(t+1)-freqs(i)))/((mids(t+1)-mids(t-1))*(mids(t+1)-mids(t)));
        elseif freqs(i) > mids(t+1)
            filter(t,i) = 0; 
        end
    end
end

%% Remove dummy parts
%%TODO

%% Plot the filters
x = linspace(0, freqs(size(freqs,1)), size(freqs,1));
figure();
hold on;

for t = 1:size(mids)
    plot(x,filter(t,:));
end

hold off;

