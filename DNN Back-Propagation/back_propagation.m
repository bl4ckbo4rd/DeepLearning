%this script performs the backpropagation step computing the 
%delta's at each layer, starting from the last one, until the first one.
%at each layer, it then computes the new weights using a gradient descent
%step.
%here is one example when there are 2 hidden layers.
%in the output layer, z4=a4, i.e. there are not non linear functions acting
%on the neurons.

%delta4 = (z4-target) 
%DeltaW_3 = delta4 * z3';
%n_W3 = W3 - eta * (DeltaW_3 + alpha * W3);

%delta3 = W3' * delta4 .* z3 .* (1-z3);
%DeltaW_2 = delta3 * z2';
%n_W2 = W2 - eta * (DeltaW_2 + alpha * W2);

%delta2 = W2 * delta3 .* z2 .* (1-z2);
%DeltaW_1 = delta2 * z1';
%n_W1 = W1 - eta * (DeltaW_1 + alpha * W1);


delta{L} = z{L} - target;
DeltaW{L-1} = delta{L} * z{L-1}';
n_W{L-1} = W{L-1} - eta * ( DeltaW{L-1} + alpha * W{L-1} );

for l=(L-1):-1:2
   
    delta{l}    = W{l}' * delta{l+1} .*  z{l} .* (1-z{l});
    DeltaW{l-1} = delta{l} * z{l-1}';
    n_W{l-1}    = W{l-1} - eta * ( DeltaW{l-1} + alpha * W{l-1} );
    
end

W=n_W;