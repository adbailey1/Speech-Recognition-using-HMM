function [forward_likelihoods,overall_likelihood_forward] = forward_procedure(a,...
    output_probability_densities,exit_probabilities)
forward_likelihoods = zeros(9,3);
forward_likelihoods(1,:) = a(1,:).*output_probability_densities(1,:);

for t=2:9
    alpha_next1 = forward_likelihoods(t-1,:)*a(2:4,1);
    alpha_next1 = alpha_next1*output_probability_densities(t,1);
    
    alpha_next2 = forward_likelihoods(t-1,:)*a(2:4,2);
    alpha_next2 = alpha_next2*output_probability_densities(t,2);
    
    alpha_next3 = forward_likelihoods(t-1,:)*a(2:4,3);
    alpha_next3 = alpha_next3*output_probability_densities(t,3);
    
    forward_likelihoods(t,:) = [alpha_next1,alpha_next2,alpha_next3];
end

overall_likelihood_forward = forward_likelihoods(9,:)*exit_probabilities;

end