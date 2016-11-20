Num_samples    = 5;                %# of samples to memorize
Num_iterations = 100;              %# of iterations for the CD alghorithm

beta           = 1;                %inverse temperature
L_N            = [35 50 20 2];     %# of units of each layer
                                   %N(1) is the # of visible layers

L_tot          = numel(L_N);       %#of layers                    
eta            = 0.1;              %learning rate
L1             = 10^-4;            %L1 regularizer
F              = 5;                %Momentum

%here we use input data made of letters ----------------------------------
%N has to be 35 for this kind of data
[data,~] = input_letters(Num_samples,L_N(1));

data = data(:,1:Num_samples);

L_data{1} = data;
N1 = L_N(1);
M1 = L_N(2);
[J, Error] = CD(N1,M1,L_data{1},beta,eta,Num_samples,Num_iterations,L1,F);

plot(Error,'b')

L_J{1} = J;

for L=2:(L_tot-1)

    [L_data{L}] = data_L(L-1,L_N,L_J,beta,data);

    N=L_N(L);
    M=L_N(L+1);
    if (L<L_tot-1)
        [J, Error] = CD(N,M,L_data{L},beta,eta,Num_samples,Num_iterations,L1,F);
    else
        [J, Error] = CD_continuos(N,M,L_data{L},beta,eta,Num_samples,Num_iterations,L1,0.5);
    end
    figure
    plot(Error,'r')

    L_J{L} = J;

end

%L = numel(L_N) - 1;
%[LD_data] = LowDimRepresentation(L,L_N,L_J,beta,data);
%figure
%scatter(LD_data(1,:),LD_data(2,:))