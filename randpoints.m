function P = randpoints(N,varargin)

%disp ("Input arguments passed: " + nargin)
%celldisp (varargin)

switch nargin
    case 1
        P = rand(2,N);
        
    case 2
        switch varargin{1}
            case 'uniform'
                P = rand(2,N);
            case 'gaussian'
                P = randn(2,N);
            otherwise
                error('The points cannot be generated for this type of distribution.');
        end
        
    case 4
        switch varargin{1}
            case 'uniform'
                U = varargin{2};
                V = varargin{3};
                
                if(U(2)<U(1))
                    error('A1 must be less than B1.');
                elseif(V(2)<V(1))
                    error('A2 must be less than B2.');
                else
                    P(1,:) = rand(1,N)*(U(2)-U(1))+U(1); %x coordonates
                    P(2,:) = rand(1,N)*(V(2)-V(1))+V(1); %y coordonates
                end
            case 'gaussian'
                U = varargin{2};
                V = varargin{3};
                
                if(V(1)<0 || V(2)<0 )
                    error('Deviation cannot be negative.');
                else
                    P(1,:) = randn(1,N)*V(1)+U(1); %x coordonates
                    P(2,:) = randn(1,N)*V(2)+U(2); %y coordonates
                end
            otherwise
                error('The points cannot be generated for this type of distribution.');
        end
        
    otherwise
        error('The number of parameters can not be supported.');
end

    plot(P(1,:),P(2,:),".") %plotting the points
end