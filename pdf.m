function [pdf1,pdf2,pdf3,probability_points_pdf1,probability_points_pdf2,...
    probability_points_pdf3,bo_formula] = pdf(observations)
x = -1:0.01:9;
B = [1.10,4.00,5.70;0.36,1.21,0.16];

mean = B(1,:);
standard_deviation = sqrt(B(2,:));

pdf1 = normpdf(x,mean(1),standard_deviation(1));
pdf2 = normpdf(x,mean(2),standard_deviation(2));
pdf3 = normpdf(x,mean(3),standard_deviation(3));

plot(x,pdf1);
hold on;
plot(x,pdf2);
hold on;
plot(x,pdf3);
legend('State 1','State 2','State 3');
title('PDF Plots for States 1-3');
xlabel('Observations');
ylabel('Probability');

pause; close all;

o_new = zeros(9,1);

% Find the observations postion on the xaxis given the range and increment
for i = 1:9
    o_new(i) = round(((observations(i)+1)/0.01)) + 1;
end

% Find the probabilities for the observations
probability_points_pdf1 = pdf1(o_new);
probability_points_pdf2 = pdf2(o_new);
probability_points_pdf3 = pdf3(o_new);

plot(x,pdf1)
hold on
plot(observations,probability_points_pdf1,'ro')
plot(x,pdf2)
hold on
plot(observations,probability_points_pdf2,'b*')
plot(x,pdf3)
hold on
plot(observations,probability_points_pdf3,'k+')
legend('State 1','PD State 1','State 2','PD State 2','State 3','PD State 3');
title('PDF Plots for States 1-3 with Probability Desnsities (PD)');
xlabel('Observations');
ylabel('Probability');
pause; 
close all;

bo_formula = zeros(9,3);

% Use a formula in order to calcualte the output probability densities and
% cross reference the output of the plots
for i = 1:9
    initial = sqrt(2*pi.*(B(2,:)));
    reciprocal = 1./initial;
    en = -((observations(i)-B(1,:)).^2);
    ed = 2*B(2,:);
    bo_formula(i,:) = reciprocal.*exp(en./ed);
end
end