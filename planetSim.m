function planetSim(last) % enter number of days to run simulation

%read data from excel
x1 = xlsread('testGraph.xlsx', 'A1:A60');
y1 = xlsread('testGraph.xlsx', 'B1:B60');
x2 = xlsread('testGraph.xlsx', 'D1:D60');
y2 = xlsread('testGraph.xlsx', 'E1:E60');
 
% p = plot(x,y)
% p.LineStyle = 'none';
%     p.Marker = 'o';
%     p.MarkerSize = 2;

hold on;
while 1 == 1
    %loop to plot each individual point on graphs
    for j= 0:1:last
        
        %converts days to plottable orbit points of earth
        i = 2*pi/365*j;
        
        %plot stationary sun 
        sun = plot(0,0, 'ko');
        sun.MarkerSize = 2;
        
        earthX(j+1) = 149.6.*cos(i);
        earthY(j+1) = 149.6.*sin(i)+0.025;
        
        %plot orbit of earth through parametric equations
        earth = plot(earthX(j+1), earthY(j+1), 'bo');
        h = plot(cos(i), 2.*sin(i), 'ro');
        
        %plot details
        axis([-200 200 -200 200]);
        title(['Day ' num2str(j)]);
        legend('Sun' , 'Earth','Test');
        
        %pause for 0.1s if planets intersect
         if (sin(i) == cos(i)) && (cos(i) == 2.*sin(i))
             pause(0.1);
             
         %pause at end of specified days before repeating
         elseif j == last
             pause(5);
             
         %delete previously plotted points
         else
            pause(0.005);
            delete(earth);
            delete(h);
            delete(sun);
        end

    end
    
    %pause and clear all points on graph
    pause(1);
    cla;
    earthX
    earthY
    
   
end