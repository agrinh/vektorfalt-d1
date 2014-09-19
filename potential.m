function phi = potential(r, r1, r2, m1, m2, w, G)
    wxr = cross(w, r);
    phi = -(G*m1/norm(r-r1)) - (G*m2/norm(r-r2)) - (1/2)*norm(wxr)^2;
end
