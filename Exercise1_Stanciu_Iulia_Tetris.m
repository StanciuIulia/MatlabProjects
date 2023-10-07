close all
clear
clc

tetris([1,6,0,1;2,5,1,1;4,7,0,0;3,7,8,2;2,5,7,3;5,10,3,1;
5,3,9,3;2,8,15,1;7,5,3,1;6,11,0,1;5,1,0,0;3,9,2,1]);

function tetris(Matrix)

    Squares_horizontal = 12;
    Squares_vertical = 20;
    Spacing = 0.2;

    Grey = [0.7 0.7 0.7];
    LightGrey = [0.9 0.9 0.9];

    color1 = [0 1 1]; %cyan
    X1 = [0 0 4 4];
    Y1 = [0 1 1 0];
    
    color2 = [1 0 1]; %magenta
    X2 = [0 0 1 1 2 2 3 3];
    Y2 = [0 1 1 2 2 1 1 0];

    color3 = [0 0 1]; %blue
    X3 = [0 0 1 1 3 3];
    Y3 = [0 2 2 1 1 0];

    color4 = [1 1 0]; %yellow
    X4 = [0 0 2 2];
    Y4 = [0 2 2 0];

    color5 = [1 0.65 0]; %orange
    X5 = [0 0 2 2 3 3];
    Y5 = [0 1 1 2 2 0];

    color6 = [0 1 0]; %green
    X6 = [0 0 1 1 3 3 2 2];
    Y6 = [0 1 1 2 2 1 1 0];

    color7 = [1 0 0]; %red
    X7 = [0 0 2 2 3 3 1 1];
    Y7 = [1 2 2 1 1 0 0 1];

    X = [0 0 Squares_horizontal + Spacing Squares_horizontal + Spacing];
    Y = [0 Squares_vertical + Spacing Squares_vertical + Spacing 0];
    
    f = figure;
    f.Position = [200 0 420 700];
    fill(X, Y, Grey)
    hold on

    for n = 0:Squares_horizontal-1
        for m = 0:Squares_vertical-1
            Xb = [(Spacing + n) (Spacing + n) (1 + n) (1 + n)];
            Yb = [(Spacing + m) (1 + m) (1 + m) (Spacing + m)];
            fill(Xb, Yb, LightGrey)
        end
    end

    fill(Xb, Yb, LightGrey)
    hold on 
    
    for row = 1:size(Matrix, 1)
        switch Matrix(row, 4)
            case 0
                switch Matrix(row, 1)                  
                    case 1
                        fill(X1+Matrix(row, 2)+Spacing/2, Y1+Matrix(row, 3)+Spacing/2, color1)
                    case 2
                        fill(X2+Matrix(row, 2)+Spacing/2, Y2+Matrix(row, 3)+Spacing/2, color2)
                    case 3
                        fill(X3+Matrix(row, 2)+Spacing/2, Y3+Matrix(row, 3)+Spacing/2, color3)
                    case 4
                        fill(X4+Matrix(row, 2)+Spacing/2, Y4+Matrix(row, 3)+Spacing/2, color4)
                    case 5
                        fill(X5+Matrix(row, 2)+Spacing/2, Y5+Matrix(row, 3)+Spacing/2, color5)
                    case 6
                        fill(X6+Matrix(row, 2)+Spacing/2, Y6+Matrix(row, 3)+Spacing/2, color6)
                    case 7
                        fill(X7+Matrix(row, 2)+Spacing/2, Y7+Matrix(row, 3)+Spacing/2, color7)
                end
                
            case 1
                switch Matrix(row, 1)                  
                    case 1
                        fill(-Y1+Matrix(row, 2)+Spacing/2, X1+Matrix(row, 3)+Spacing/2, color1)
                    case 2
                        fill(-Y2+Matrix(row, 2)+Spacing/2, X2+Matrix(row, 3)+Spacing/2, color2)
                    case 3
                        fill(-Y3+Matrix(row, 2)+Spacing/2, X3+Matrix(row, 3)+Spacing/2, color3)
                    case 4
                        fill(-Y4+Matrix(row, 2)+Spacing/2, X4+Matrix(row, 3)+Spacing/2, color4)
                    case 5
                        fill(-Y5+Matrix(row, 2)+Spacing/2, X5+Matrix(row, 3)+Spacing/2, color5)
                    case 6
                        fill(-Y6+Matrix(row, 2)+Spacing/2, X6+Matrix(row, 3)+Spacing/2, color6)
                    case 7
                        fill(-Y7+Matrix(row, 2)+Spacing/2, X7+Matrix(row, 3)+Spacing/2, color7)
                end
                
            case 2
                switch Matrix(row, 1)                  
                    case 1
                        fill(-X1+Matrix(row, 2)+Spacing/2, -Y1+Matrix(row, 3)+Spacing/2, color1)
                    case 2
                        fill(-X2+Matrix(row, 2)+Spacing/2, -Y2+Matrix(row, 3)+Spacing/2, color2)
                    case 3
                        fill(-X3+Matrix(row, 2)+Spacing/2, -Y3+Matrix(row, 3)+Spacing/2, color3)
                    case 4
                        fill(-X4+Matrix(row, 2)+Spacing/2, -Y4+Matrix(row, 3)+Spacing/2, color4)
                    case 5
                        fill(-X5+Matrix(row, 2)+Spacing/2, -Y5+Matrix(row, 3)+Spacing/2, color5)
                    case 6
                        fill(-X6+Matrix(row, 2)+Spacing/2, -Y6+Matrix(row, 3)+Spacing/2, color6)
                    case 7
                        fill(-X7+Matrix(row, 2)+Spacing/2, -Y7+Matrix(row, 3)+Spacing/2, color7)
                end
                
            case 3
                switch Matrix(row, 1)                  
                    case 1
                        fill(Y1+Matrix(row, 2)+Spacing/2, -X1+Matrix(row, 3)+Spacing/2, color1)
                    case 2
                        fill(Y2+Matrix(row, 2)+Spacing/2, -X2+Matrix(row, 3)+Spacing/2, color2)
                    case 3
                        fill(Y3+Matrix(row, 2)+Spacing/2, -X3+Matrix(row, 3)+Spacing/2, color3)
                    case 4
                        fill(Y4+Matrix(row, 2)+Spacing/2, -X4+Matrix(row, 3)+Spacing/2, color4)
                    case 5
                        fill(Y5+Matrix(row, 2)+Spacing/2, -X5+Matrix(row, 3)+Spacing/2, color5)
                    case 6
                        fill(Y6+Matrix(row, 2)+Spacing/2, -X6+Matrix(row, 3)+Spacing/2, color6)
                    case 7
                        fill(Y7+Matrix(row, 2)+Spacing/2, -X7+Matrix(row, 3)+Spacing/2, color7)
                end 
        end         
    end
    
    title("Tetris 2022 - Stanciu Iulia")
    axis([0 Squares_horizontal + Spacing 0 Squares_vertical + Spacing])
    axis off
    
end

