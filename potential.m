function phi = potential(r, r1, r2, m1, m2, G)
    w = angular_velocity(r1, r2, m1, m2, G);
    wxr = cross(w, r);
    phi = -(G*m1/norm(r-r1)) - (G*m2/norm(r-r2)) - (1/2)*norm(wxr)^2;
end
