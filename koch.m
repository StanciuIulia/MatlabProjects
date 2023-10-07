function M = koch(n)

    M = [0 1 cos(-pi/3) 0; 0 0 sin(-pi/3) 0];
    
    if nargout==0
        clf;
        figure(1);
        suptitle("Koch fractal curve of orders 0 to " + n + " starting from a equilateral triangle");

        subplot(n+1,1,n+1)
        plot( M(1,:), M(2,:) );

        axis equal;
        axis off;
    end
    
    for i = 1:n
        newM = zeros( 2, size(M,2)*4+1);

        for j = 1:size(M,2)-1
            newM(:, 4*j+1) = M(:, j);
            newM(:, 4*j+2) = (2*M(:, j) + M(:, j+1) )/3;
            link = M(:, j+1).'-M(:, j).';
            ang = atan2( link(2), link(1) );
            linkLeng = sqrt( sum(link.^2) );
            newM(:, 4*j+3) = newM(:, 4*j+2) + (linkLeng/3)*[ cos(ang+pi/3); sin(ang+pi/3) ];
            newM(:, 4*j+4) = (M(:, j) + 2*M(:, j+1) )/3;
        end
        M = newM;
        
        if nargout==0
            subplot(n+1,1,n+1-i)
            plot( M(1,:), M(2,:) );
            axis equal;
            axis off;
        end
    end
end    