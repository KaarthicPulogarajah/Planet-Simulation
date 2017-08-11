function planetSim(last) % enter number of days to run simulation

% import planets info from excel file
data = xlsread('planets info.xlsx','B2:H10');

%earth data
earthMajor = data(3,1) / 1E6;
earthMinor = data(3,3) / 1E6;
earthDelta = data(3,6) / 1E6;
earthOrbitDays = data(3,7);

%mercury data
mercuryMajor = data(1,1) / 1E6;
mercuryMinor = data(1,3) / 1E6;
mercuryDelta = data(1,6) / 1E6;
mercuryOrbitDays = data(1,7);

%venus data
venusMajor = data(2,1) / 1E6;
venusMinor = data(2,3) / 1E6;
venusDelta = data(2,6) / 1E6;
venusOrbitDays = data(2,7);

% initial positions of planets derived from http://www.theplanetstoday.com/
aug08Mercury = 271 * pi / 180;
aug08Earth = 313 * pi / 180;
aug08Venus = 48 * pi / 180;

hold on;

while 1 == 1
    %plot stationary sun 
    sun = plot(0,0, 'ko');
    sun.MarkerSize = 2;
    
    %loop to plot each individual point on graphs
    for j= 0:1:last
        
%         %converts days to plottable orbit points of earth
%         e = 2*pi/earthOrbitDays*j;
%         %converts days to plottable orbit points of mercury
%         m = 2*pi/mercuryOrbitDays*j;
%         %converts days to plottable orbit points of venus
%         v = 2*pi/venusOrbitDays*j;
%         
%         
%         
%             %EARTH calcs
%         %generate x and y values for current position on elliptical orbit
%         earthX(j+1) = earthMajor.*cos(e + aug08Earth);
%         earthY(j+1) = earthMinor.*sin(e + aug08Earth);
%         
%         %apply rotation to ellipse to make orbit start on the +y axis,
%         %earth's orbit will be used as a benchmark for all other orbits
%         rot = rotation(earthX(j+1), earthY(j+1), 0);
%         
%         %update x and y values with the rotated values and apply vertical
%         %and horizontal translations of true orbit
%         earthX(j+1) = rot(1);
%         earthY(j+1) = rot(2)+earthDelta;
%             %EARTH calcs
%             
%             %MERCURY calcs
%         mercuryX(j+1) = mercuryMinor.*sin(-(m + aug08Mercury));
%         mercuryY(j+1) = mercuryMajor.*cos(m + aug08Mercury);
%         
%         rot = rotation(mercuryX(j+1), mercuryY(j+1), -90);
%         mercuryX(j+1) = rot(1)-mercuryDelta;
%         mercuryY(j+1) = rot(2);
%         
%         distSunMercury(j+1) = sqrt(mercuryX(j+1).^2 + mercuryY(j+1).^2);
%             %MERCURY calcs
%             
%             %VENUS calcs
%         venusX(j+1) = venusMajor.*cos(v + aug08Venus);
%         venusY(j+1) = venusMinor.*sin(v + aug08Venus);
%         
%         rot = rotation(venusX(j+1), venusY(j+1), 0);
%         venusX(j+1) = rot(1)-venusDelta;
%         venusY(j+1) = rot(2);
%         
%         distSunVenus(j+1) = sqrt(venusX(j+1).^2 + venusY(j+1).^2);
%             %VENUS calcs
%         
%         %plot orbit of earth through parametric equations
%         earth = plot(earthX(j+1), earthY(j+1), 'bo');
%         mercury = plot(mercuryX(j+1), mercuryY(j+1), 'go');
%         venus = plot(venusX(j+1), venusY(j+1), 'ro');
        
        earth = plotPlanet(j, earthMajor, earthMinor, 0, earthOrbitDays, 0, earthDelta, aug08Earth, 'b');
        mercury = plotPlanet(j, mercuryMajor, mercuryMinor, 0, mercuryOrbitDays, -mercuryDelta, 0, aug08Mercury, 'm');
        venus = plotPlanet(j, venusMajor, venusMajor, 0, venusOrbitDays, 0, venusDelta, aug08Venus, 'r');
        
        %plot details
        axis([-200 200 -200 200]);
        title(['August 08 2017 Day ' num2str(j)]);
        xlabel('* 1E6 km');
        ylabel('* 1E6 km');
        set(get(gca,'ylabel'),'Rotation',0)
        legend('Sun' , 'Earth', 'Mercury', 'Venus');
        
%         %pause for 0.1s if planets intersect
%          if (sin(e) == cos(e)) && (cos(e) == 2.*sin(e))
%              pause(0.1);
             
         %pause at end of specified days before repeating
         if j == last
             pause(5);
             
         %delete previously plotted points
         else
            pause(0.005);
            delete(earth);
            %delete(sun);
            delete(mercury);
            delete(venus);
        end

    end
    
    %pause and clear all points on graph
    pause(1);
    cla;
    
    
   
end
end

%this function accepts all relevant values of a planet's orbit and
%processes data to plot the next point of the orbit
%this function replaces having to do everything multiple times in the main

function planet = plotPlanet(j, majorAx, minorAx, rotDeg, orbitDays, deltaX, deltaY, offset, colour)

    %converts number of orbit days to plottable orbit points
    t = 2*pi/orbitDays*j;
    
    %generate x and y values for position on elliptical orbit on August 08
    planetX = majorAx.*cos(t + offset);
    planetY = minorAx.*sin(t + offset);
    
    %rotate ellipse by a certain number of degrees
    rot = rotation(planetX, planetY, rotDeg);
    
    %update x and y values with the rotated values and apply vertical
    %and horizontal translations of true orbit
    planetX = rot(1) + deltaX;
    planetY = rot(2) + deltaY;
    
    %plot single point of planet's current location
    planet = plot(planetX, planetY, 'o');
    planet.MarkerEdgeColor = colour;
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

