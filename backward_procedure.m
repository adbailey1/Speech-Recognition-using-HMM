function [backward_likelihoods,overall_likelihood_backward] = backward_procedure(a,...
    output_probablity_densities,exit_probabilities)
backward_likelihoods = zeros(9,3);
backward_likelihoods(9,:) = exit_probabilities';
t = 9;

for i=2:9
    beta_next1 = a(2,:).*output_probablity_densities(t,:).*backward_likelihoods(t,:);
    backward_likelihoods(t-1,1) = sum(beta_next1);
    
    beta_next2 = a(3,:).*output_probablity_densities(t,:).*backward_likelihoods(t,:);
    backward_likelihoods(t-1,2) = sum(beta_next2);
   
    beta_next3 = a(4,:).*output_probablity_densities(t,:).*backward_likelihoods(t,:);
    backward_likelihoods(t-1,3) = sum(beta_next3);
    
    t = t-1;
end

overall_likelihood_backward = a(1,:).*output_probablity_densities(1,:).*backward_likelihoods(1,:);
overall_likelihood_backward = sum(overall_likelihood_backward);
end