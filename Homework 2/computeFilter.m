% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %% Sudarson Selvaraj - 387649
% %% Mikko Honkanen - 387608
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [ filter ] = computeFilter( mids, freqs )
%COMPUTEFILTER Computes triangular filters
%   Computes and plots triangular filters.

%% Initialize the filter matrix
%disp(size(mids))
%disp(size(freqs))
% has size 26 257
filter = zeros(size(mids,2),size(freqs,1));


%% Loop through the mid values and compute the filter value for each frequency
for t = 2:25
    for i = 1:length(freqs)
        %disp(t);
        %disp(i);
        
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

%% Remove dummy parts (first and last row)
filter(1,:) = [];
filter(end,:) = [];

%% Plot the filters
%x = linspace(0, freqs(size(freqs,1)), size(freqs,1));
x = linspace(0, max(freqs), size(freqs,1));
figure('Name',['Triangluar filters']);
hold on;

% the first filter is still wrong
%disp(filter)

for t = 1:size(filter,1)
    plot(x,filter(t,:));
end

xlabel('Frequency [Hz]')
ylabel('Filter value')
hold off;

%% E O F