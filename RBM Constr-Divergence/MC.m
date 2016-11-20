%This function performs a MC dynamics of the RBM where starting from a
%given configuration of visible spins, we upload in parallel all the 
%hidden units and then, using the set {h,v} as an initial condition, we run
%the MC dynamics perturbing one unit (visible or hidden) per time step.

%Notes:
%It works much more poorly than then Parallel dynamics because starting
%from a letter, it is never able to sample other letters.

%input variable:
%T       : # of time steps for which we would like to run the dynamics

%output: 
%Q(t,n)  : overlap between the configuration sampled at time step t and
%          the configuration data indexed by n


%v = 2 * (0.5*ones(N,1) > rand(N,1)) - 1;
v = 2*data(:,5)-1;


h_field     = beta * J * v; % + beta*h_external' ;          
h           = 2 * (1./(1 + exp(-h_field)) > rand(M,1) ) - 1;

data_RBM      = zeros(N, T+1);
data_RBM(:,1) = v;

for t=1:T
    r = randi([1 N+M]);
    if r <= M
        Jv = J*v;
        DeltaE = 2 * h(r) * Jv(r);
        p = min(1,exp(-beta*DeltaE));
        if rand < p
            h(r) = -h(r);
        end
    else
        Jh = J'*h;
        DeltaE = 2 * v(r-M) * Jh(r-M);
        p = min(1,exp(-beta*DeltaE));
        if rand < p
            v(r-M) = -v(r-M);
        end
    end
    data_RBM(:,t) = v;
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
