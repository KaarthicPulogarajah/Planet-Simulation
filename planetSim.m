function planetSim()

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
    for i= 0:pi/64:2*pi
        %p = plot(x1(i),y1(i), 'bo');
        %h = plot(x2(i),y2(i), 'ro');
        
        
        sun = plot(0,0, 'ko');
        sun.MarkerSize = 2;
        earth = plot(149.6.*cos(i), 149.6.*sin(i)+0.025, 'bo');
        h = plot(cos(i), 2.*sin(i), 'ro');
        
        axis([-200 200 -200 200]);
        title(['Day ' num2str(i)]);
        legend('Sun' , 'Earth','Test');
        
         if (sin(i) == cos(i)) && (cos(i) == 2.*sin(i))
             pause(0.1);
         else
            pause(0.05);
            delete(earth);
            delete(h);
            delete(sun);
        end

    end
    
    %pause and clear all points on graph
    pause(1);
    cla;
    
   
end