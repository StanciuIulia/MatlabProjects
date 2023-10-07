function [lat, lon] = trilateration( lat_long_coord, distance)
r1 = distance(1);
r2 = distance(2);
r3 = distance(3);

a1 = lat_long_coord(1,1);
b1 = lat_long_coord(1,2);

a2 = lat_long_coord(2,1);
b2 = lat_long_coord(2,2);

a3 = lat_long_coord(3,1);
b3 = lat_long_coord(3,2);

colors = {'b', 'r', 'g', 'y'};
    
    figure
    axis equal
    hold on
    fimplicit(@(x, y)(x-a1).^2 + (y-b1).^2 - r1.^2, colors{1})
    plot(a1, b1, 'o', 'Color', colors{1})
    fimplicit(@(x, y)(x-a2).^2 + (y-b2).^2 - r2.^2, colors{2})
    plot(a2, b2, 'o', 'Color', colors{2})
    fimplicit(@(x, y)(x-a3).^2 + (y-b3).^2 - r3.^2, colors{3})
    plot(a3, b3, 'o', 'Color', colors{3})

%     fimplicit(@(x,y)(x-a1).^2 + (y-b1).^2 - r1.^2 + (x-a2).^2 + (y-b2).^2 - r2.^2 + (x-a3).^2 + (y-b3).^2 - r3.^2, 'o', 'Color', colors{4})

% freceiver = @(x,y)(x-a1).^2 + (y-b1).^2 - r1.^2 + (x-a2).^2 + (y-b2).^2 - r2.^2 + (x-a3).^2 + (y-b3).^2 - r3.^2;
% point = [0,0];
fsolve( @(x, y)(x-a1).^2 + (y-b1).^2 - r1.^2 + (x-a2).^2 + (y-b2).^2 - r2.^2 + (x-a3).^2 + (y-b3).^2 - r3.^2, 0);

lat = x;
lon = y;
    plot(lat, long, 'o', 'Color', colors{4})
end
