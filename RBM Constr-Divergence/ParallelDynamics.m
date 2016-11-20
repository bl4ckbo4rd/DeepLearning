%This function is a parallel dynamics of the RBM where 
%starting from a given configuration of visible spins, 
%we upload in parallel all the hidden units and then, given
%them, we upload again in parallel all the visible spins.
%This process is repeated for T time steps and the dynamics
%is plotted

%input variable:
%T       : # of time steps for which we would like to run the dynamics

%output: 
%Q(t,n)  : overlap between the configuration sampled at time step t and
%          the configuration data indexed by n

%v_sampled = 2 * (0.5*ones(N,1) > rand(N,1)) - 1;
v_sampled = 2*data(:,2)-1;

data_RBM = [];

for t = 1:T
    h_field     = beta * J * v_sampled; % + beta*h_external' ;          
    h_sampled   = 2 * (1./(1 + exp(-h_field)) > rand(M,1) ) - 1;  
                
    v_field     = beta * J' * h_sampled; % + beta*h_external' ;          
    v_sampled   = 2 * (1./(1 + exp(-v_field)) > rand(N,1) ) - 1;
    
    data_RBM = [data_RBM, v_sampled];       
end

for t=1:T
    imagesc(reshape(data_RBM(:,t),5,7)')
    pause(0.05)
end

Q = zeros(T,Num_samples);

for t=1:T
    for n=1:Num_samples
        Q(t,n)=data_RBM(:,t)'*(2*data(:,n)-1);
    end
end