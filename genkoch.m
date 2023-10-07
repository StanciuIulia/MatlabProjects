function M = genkoch(n, Patt, M0)

    M = [0,1;0,0];
    plotM = M0;
    
    if nargout==0
        clf;
        figure(1);
        suptitle("Koch fractal curve of orders 0 to " + n + " starting from a the given curve M0 and folowing the pattern of Patt");

        
        subplot(n+1,1,n+1)
        plot( plotM(1,:), plotM(2,:) );
        %axis([0 1 0 0.5]);
        axis equal;
        axis off;
    end
    
    points = size(Patt,2);
    
    for i = 1:n
        newM = zeros( 2, size(M,2)*(points-1)+1);
        plotM = zeros( 2, size(M,2)*(points-1)+1);
        
        for j = 1:size(M,2)-1
            u0 = M(1, j);
            u1 = M(1, j+1);
            v0 = M(2, j);
            v1 = M(2, j+1);
            
            newM(1, ((points-1)*j+1):((points-1)*j+points) )= u0 + (u1-u0)*Patt(1, :) - (v1-v0)*Patt(2, :);
            newM(2, ((points-1)*j+1):((points-1)*j+points) ) = v0 + (v1-v0)*Patt(1, :) + (u1-u0)*Patt(2, :);
        
            u0_plot = M0(1, 1);
            u1_plot = M0(1, 2);
            v0_plot = M0(2, 1);
            v1_plot = M0(2, 2);
            
            plotM(1, ((points-1)*j+1):((points-1)*j+points) )= u0_plot + (u1_plot-u0_plot)*newM(1, ((points-1)*j+1):((points-1)*j+points)) - (v1_plot-v0_plot)*newM(2, ((points-1)*j+1):((points-1)*j+points));
            plotM(2, ((points-1)*j+1):((points-1)*j+points) ) = v0_plot + (v1_plot-v0_plot)*newM(1, ((points-1)*j+1):((points-1)*j+points)) + (u1_plot-u0_plot)*newM(2, ((points-1)*j+1):((points-1)*j+points));
            
        end
        
        M = newM;
        if nargout==0
            subplot(n+1,1,n+1-i)
            plot( plotM(1,:), plotM(2,:) );
            %axis([0 1 0 0.5]);
            axis equal;
            axis off;
        end
    end
    M = plotM;
end    