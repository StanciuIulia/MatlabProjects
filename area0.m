function area = area0()

load('ex_1_data.mat')

[x_grid,y_grid] = meshgrid(0:.1:L, 0:.1:L);
z_grid = griddata(vec_x,vec_y,function_value,x_grid,y_grid);

figure
mesh(x_grid,y_grid,z_grid)

figure
contour(x_grid,y_grid,z_grid)
end
