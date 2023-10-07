close all
clear
clc

Niterations = 500;
Step = 1000; 

Xmin = -2;
Xmax = 2;

Ymin = -2;
Ymax = 2;

RangeX = linspace(Xmin, Xmax, Step);
RangeY = linspace(Ymin, Ymax, Step);

[gridX,gridY] = meshgrid(RangeX, RangeY);
Z0 = gridX + gridY*1i;
Z = Z0;

C = zeros(size(Z0)); %vector of zeros

for n=1:Niterations
    Z = Z.*Z + Z0; %element computation
    B = abs(Z)<=2;
    C = C + B;
end
C = log( C+1 );

imagesc(RangeX, RangeX, C);    
axis image;
axis off;
colormap hot;
title( "Mandelbrot fractal at [-2,2]x[-2,2]" );

userinteraction(Step, Niterations)

function drawing(Xmin, Xmax, Ymin, Ymax, Step, Niterations)

    RangeX = linspace(Xmin, Xmax, Step);
    RangeY = linspace(Ymin, Ymax, Step);

    [gridX,gridY] = meshgrid(RangeX, RangeY);
    Z0 = gridX + gridY*1i;
    Z = Z0;

    C = zeros(size(Z0)); %vector of zeros

    for n=1:Niterations
        Z = Z.*Z + Z0; %element computation
        B = abs(Z)<=2;
        C = C + B;
    end
    C = log( C+1 );

    imagesc(RangeX, RangeX, C);    
    axis image;
    axis off;
    colormap hot;
    title(['Mandelbrot fractal at [',num2str(Xmin) ,',' ,num2str(Ymin), ']x[', num2str(Xmax), ',', num2str(Ymax), ']']);

    userinteraction(Step, Niterations)
end

function userinteraction(Step, Niterations)
    [a1,b1,c]=ginput(1);
    if c<=3 %the mouse was clicked at point (a1,b1)
        [a2,b2]=ginput(1); %the second click point at (a2,b2)
        drawing(a1, a2, b1, b2, Step, Niterations)

    else %the keyboard was pressed instead

        switch c
            case "+"
                %increase the number of iterations and recompute
                Niterations = Niterations + 50;
                userinteraction(Step, Niterations)
            case "-"
                %decrease the number of iterations
                Niterations = Niterations - 50;
                userinteraction(Step, Niterations)

            case "q"
                %terminate the program
                quit

            case "Q"
                %terminate the program
                quit

        end
    end
end