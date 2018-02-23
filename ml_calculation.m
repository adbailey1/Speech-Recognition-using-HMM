function ML_joint_likelihood_over_observations = ml_calculation(a,...
    output_probability_densities,max_likelihood_path,exit_probabilities)
x = zeros(9,1);
for i = 1:9
   x(i) = max_likelihood_path(i); 
end

ML_joint_likelihood_over_observations = a(1,x(1))*output_probability_densities(1,x(1));
summation = 1;
for t=2:9
   inter = a(x(t-1)+1,x(t))*output_probability_densities(t,x(t));
   summation = inter*summation;
end

ML_joint_likelihood_over_observations = ML_joint_likelihood_over_observations*summation*...
    exit_probabilities(x(9));
end