function dist = l2_norm(V1, V2)

    V = V1 - V2;

    dist = sqrt(V * V'); % norm(V, 2)

end