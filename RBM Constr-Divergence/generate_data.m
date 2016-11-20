%this function creates random samples to feed the RBM

%N:               # of visible units
%bias:            value \in [-1,1]. 
%Num_samples:     # of samples to memorize

function [ data ] = generate_data(N, bias, Num_samples)

    data=zeros(N,Num_samples);

    for samp = 1:Num_samples
        data(:,samp) = (1+bias)/2 > rand(N,1);
    end

end