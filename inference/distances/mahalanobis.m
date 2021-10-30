function dist = mahalanobis(V1, V2, eigan_values)
    V = V1 - V2;
    dist = sqrt((V * V') ./ eigan_values);
end
