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
        
        %generate x and y values for current position on elliptical orbit
        earthX(j+1) = 149.6.*cos(i);
        earthY(j+1) = 149.6.*sin(i);
        
        %apply rotation to ellipse to make orbit start on the +y axis,
        %earth's orbit will be used as a benchmark for all other orbits
        rot = rotation(earthX(j+1), earthY(j+1), 90);
        
        %update x and y values with the rotated values and apply vertical
        %and horizontal translations of true orbit
        earthX(j+1) = rot(1);
        earthY(j+1) = rot(2)+0.025;
        
        %plot orbit of earth through parametric equations
        earth = plot(earthX(j+1), earthY(j+1), 'bo');
        %h is test orbit
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
    
    %display all positions of earth
    earthX;
    earthY;
    
   
end
end

%'rotated' function will rotate a vector [x,y] counter-clockwise by a
%specified number of degrees

%input current x and y positions of a single point and degrees to rotate
function rotated = rotation(x,y,deg)
    
    %convert degrees to radians
    deg = deg*pi/180;
    
    %rotation matrix in the form [cosx -sinx ; sinx cosx]
    rotMatrix = [cos(deg) -sin(deg); sin(deg) cos(deg)];
    
    %create a vector out of the given point
    v = [x;y];
    
    %multiplying rotation matrix by vector will result in rotated points
    rotated = rotMatrix*v;
    
end