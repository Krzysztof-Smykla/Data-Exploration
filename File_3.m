
%Using the PCA algorithm to reduce the 4 dimentional dataset into two
%dimentions:
Means = [mean(Patterns(:,1)), mean(Patterns(:,2)), mean(Patterns(:,3)), mean(Patterns(:,4))];
Deviations = [std(Patterns(:,1)), std(Patterns(:,2)), std(Patterns(:,3)), std(Patterns(:,4))];

% Krok 1 PCA - Standaryzacja
Patterns_Standard = zeros(size(Patterns)); % Preallocate the standardized matrix

for i = 1:size(Patterns, 2) % Iterate over columns (dimensions) of the Patterns matrix
    Patterns_Standard(:, i) = (Patterns(:, i) - Means(i)) ./ Deviations(i);
end

Patterns_Standard % Display the standardized matrix

% Krok 2 PCA - Macierz Kowariancji
Covariance_Matrix = cov(Patterns_Standard)
heatmap(Covariance_Matrix)

% Calculating eigenvectors and eigenvalues det(A-vI) = 0

[eigenvecs, eigenvals] = eig(Covariance_Matrix);
[eigenvecs, eigenvals];
% Sort eigenvalues in descending order
[eigenvals_sorted, indices] = sort(diag(eigenvals), 'descend');


% Sort eigenvectors accordingly
eigenvecs_sorted = eigenvecs(:, indices);

disp('Sorted Eigenvalues: ')
disp(eigenvals_sorted)

% Principal Components (PCs) are the eigenvectors corresponding to the largest eigenvalues
principal_components = eigenvecs_sorted(:, 1:2); % Select the first two eigenvectors for reducing to two dimensions

% Display the principal components
disp('Principal Components:');
disp(principal_components);

% Plot the principal components
Plot = scatter(principal_components(:,1), principal_components(:,2), 'filled');
title('Scatter plot of Principal Components');
xlabel('Principal Component 1');
ylabel('Principal Component 2');


% Implementing the K-means algorithm based on the reduced 2-dim principal components matrix

% Number of clusters (centroids)
K = input("Podaj wartość K")
K

% Limiting the dataset to the last two dimentions where the eigenvalues are the gratest
Patterns_Reduced = Patterns_Standard(:,3:4)

% Plotting the data points projected onto the principal components
scatter(Patterns_Reduced(:,1), Patterns_Reduced(:,2), 'filled');
title('Data Points in Reduced Dimensional Space');
xlabel('Principal Component 1');
ylabel('Principal Component 2');

% Applying K-means clustering
[idx, centroids] = kmeans(Patterns_Reduced, K);

% Plotting the clustered data points
hold on;
scatter(centroids(:,1), centroids(:,2), 100, 'rx', 'LineWidth', 2);
legend('Data Points', 'Cluster Centroids');
hold off;

