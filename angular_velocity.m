function w = angular_velocity(r1, r2, m1, m2, G)
    direction = [0 0 1];
    w = sqrt(G * (m1 + m2) / norm(r1 - r2)^3) .* direction;
end
