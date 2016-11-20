%feed forward neural network with n hidden layers and L total layers
%thus L=n+2.
%the non linear function applied to any hidden layer is the sigmoid one:
%z=f(a)=1/(1+e^-s a).
%this function is not applied on the last nor on the first layer.

%z1 is the first layer 

%a2=W1*z1;
%z2=1./(1+exp(-s*a2)); %z2 is the second layer 

%a3=W2*z2;
%z3=1./(1+exp(-s*a3)); %z3 is the third layer 

%a4=W3*z3;
%z4=a4; %z4 is the third layer 

%this is a feature of the non-linear sigmoid function z=f(a)=1/(1+e^-s a)
s=1;

for l=1:n
    aa{l+1}=W{l}*z{l};
    z{l+1}=1./(1+exp(-s*aa{l+1}));
end

z{L}=W{L-1}*z{L-1};