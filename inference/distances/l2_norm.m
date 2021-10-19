function dist = l2_norm(V1, V2)

    V = V1 - V2;

    dist = sqrt(V * V'); % norm(F1-F2, 2)

end