close all;
clear all;

a = [0.92,0.08,0;0.83,0.12,0.05;0,0.87,0.07;0,0.11,0.85];
observations = [0.7,1.3,2.3,5,5.6,6.9,5.9,2.8,3.3];
exit_probabilities = [0;0.06;0.04];

[pdf1,pdf2,pdf3,probability_points_pdf1,probability_points_pdf2,probability_points_pdf3,...
    bo_formula] = pdf(observations);

output_probability_densities = [probability_points_pdf1',probability_points_pdf2',...
    probability_points_pdf3'];

[max_cumulative_likelihood,viterbi_joint_likelihood_over_observations,...
    best_path_viterbi] = viterbi(a,output_probability_densities,exit_probabilities);

[forward_likelihoods,overall_likelihood_forward] = forward_procedure(a,...
    output_probability_densities,exit_probabilities);

[backward_likelihoods,overall_likelihood_backward] = backward_procedure(a,...
    output_probability_densities,exit_probabilities);

occupation_likelihood = (forward_likelihoods.*backward_likelihoods)/overall_likelihood_backward;
[most_likely_state,max_likelihood_path] = max(occupation_likelihood,[],2);

ML_joint_likelihood_over_observations = ml_calculation(a,output_probability_densities,...
    max_likelihood_path,exit_probabilities);