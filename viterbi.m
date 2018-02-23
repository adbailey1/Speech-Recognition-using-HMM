function [cumulative_likelihood,viterbi_joint_likelihood_over_observations,...
    best_path_viterbi] = viterbi(a,output_probability_densities,exit_probabilities)
cumulative_likelihood = zeros(9,3);
gamma = zeros(9,3);

cumulative_likelihood(1,:) = a(1,:).*output_probability_densities(1,:);
gamma(1,:) = [0,0,0];
for t = 2:9
    delta1 = cumulative_likelihood(t-1,:).*a(2:4,1)';
    delta2 = cumulative_likelihood(t-1,:).*a(2:4,2)';
    delta3 = cumulative_likelihood(t-1,:).*a(2:4,3)';
    
    cumulative_likelihoods = [delta1',delta2',delta3'];
    [maximum_cumulative_likelihood,Indicies] = max(cumulative_likelihoods);
    maximum_cumulative_likelihood = maximum_cumulative_likelihood.*output_probability_densities(t,:);
    gamma(t,:) = Indicies;
    cumulative_likelihood(t,:) = maximum_cumulative_likelihood;
end

viterbi_joint_likelihood_over_observations = cumulative_likelihood(9,:).*exit_probabilities';
[viterbi_joint_likelihood_over_observations,...
    indicies_final] = max(viterbi_joint_likelihood_over_observations,[],2);
best_path_viterbi = zeros(9,1);
best_path_viterbi(9) = indicies_final;

k = 9;
for i = 1:8
    best_path_viterbi(k-1) = gamma(k,best_path_viterbi(k));
    k = k-1;
end

max_cumulative_likelihood = zeros(9,1);
for i = 1:9
max_cumulative_likelihood(i) = cumulative_likelihood(i,best_path_viterbi(i));
end
end