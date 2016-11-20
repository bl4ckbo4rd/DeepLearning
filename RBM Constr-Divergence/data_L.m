function [ dataL ] = data_L (L,L_N,L_J,beta,data)

    Num_samples = size(data,2);

    L_data{1} = data;

    for l=1:L
        data     = L_data{l};
        new_data = zeros(L_N(l+1),Num_samples);
        for samp = 1:Num_samples
            h_field           = beta * L_J{l} * (2 * data(:,samp) - 1); % + beta*h_external' ;          
            new_data(:,samp)  = 1./(1 + exp(-2*h_field)) > rand(L_N(l+1),1);
        end
        L_data{l+1}=new_data;
    end
    
    dataL = L_data{L+1};
    
end