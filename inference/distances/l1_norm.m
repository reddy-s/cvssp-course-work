function dist = l1_norm(V1, V2)

    V = V1 - V2;

    dist = sum(abs(V)); % norm(F1-F2, 1)

end