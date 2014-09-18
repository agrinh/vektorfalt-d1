function [ux, uy] = fluid_velocity_a(x, y, J, x0)
    ux = J*y.*( 1/(2*x0^2) - 1./((x+x0).^2+y.^2) - 1./((x-x0).^2+y.^2));
    uy = -J*(x./(2*x0^2) - (x+x0)./((x+x0).^2+y.^2) - (x-x0)./((x-x0).^2+y.^2));
end
