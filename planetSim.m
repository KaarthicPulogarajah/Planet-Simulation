function planetSim() % enter number of days, increment of points plotted, and size of axes to run simulation

last = input('Enter number of days to run simulation: ');
increment = input('Enter increment of days for each iteration: ');
axes = input('Enter axis scale (enter 0 for default): ');
planetName = input('Enter planet from which to calculate distances: ', 's');
planetName = lower(planetName);
if strcmp(planetName, 'mercury') planetNumber = 1;
elseif strcmp(planetName, 'venus') planetNumber = 2;
elseif strcmp(planetName, 'earth') planetNumber = 3;
elseif strcmp(planetName, 'mars') planetNumber = 4;
elseif strcmp(planetName, 'jupiter') planetNumber = 5;
elseif strcmp(planetName, 'saturn') planetNumber = 6;
elseif strcmp(planetName, 'uranus') planetNumber = 7;
elseif strcmp(planetName, 'neptune') planetNumber = 8;
elseif strcmp(planetName, 'pluto') planetNumber = 9;
end

if axes == 0
    axes = 250;
end


% import planets info from excel file
data = xlsread('planets info.xlsx','B2:I10');

%earth data
earthMajor = data(3,1) / 1E6;
earthMinor = data(3,3) / 1E6;
earthDeltaX = data(3,6) / 1E6;
earthDeltaY = data(3,7) / 1E6;
earthOrbitDays = data(3,8);

%mercury data
mercuryMajor = data(1,1) / 1E6;
mercuryMinor = data(1,3) / 1E6;
mercuryDeltaX = data(1,6) / 1E6;
mercuryDeltaY = data(1,7) / 1E6;
mercuryOrbitDays = data(1,8);

%venus data
venusMajor = data(2,1) / 1E6;
venusMinor = data(2,3) / 1E6;
venusDeltaX = data(2,6) / 1E6;
venusDeltaY = data(2,7) / 1E6;
venusOrbitDays = data(2,8);

%mars data
marsMajor = data(4,1) / 1E6;
marsMinor = data(4,3) / 1E6;
marsDeltaX = data(4,6) / 1E6;
marsDeltaY = data(4,7) / 1E6;
marsOrbitDays = data(4,8);

%jupiter data
jupiterMajor = data(5,1) / 1E6;
jupiterMinor = data(5,3) / 1E6;
jupiterDeltaX = data(5,6) / 1E6;
jupiterDeltaY = data(5,7) / 1E6;
jupiterOrbitDays = data(5,8);

%saturn data
saturnMajor = data(6,1) / 1E6;
saturnMinor = data(6,3) / 1E6;
saturnDeltaX = data(6,6) / 1E6;
saturnDeltaY = data(6,7) / 1E6;
saturnOrbitDays = data(6,8);

%uranus data
uranusMajor = data(7,1) / 1E6;
uranusMinor = data(7,3) / 1E6;
uranusDeltaX = data(7,6) / 1E6;
uranusDeltaY = data(7,7) / 1E6;
uranusOrbitDays = data(7,8);

%neptune data
neptuneMajor = data(8,1) / 1E6;
neptuneMinor = data(8,3) / 1E6;
neptuneDeltaX = data(8,6) / 1E6;
neptuneDeltaY = data(8,7) / 1E6;
neptuneOrbitDays = data(8,8);

%pluto data
plutoMajor = data(9,1) / 1E6;
plutoMinor = data(9,3) / 1E6;
plutoDeltaX = data(9,6) / 1E6;
plutoDeltaY = data(9,7) / 1E6;
plutoOrbitDays = data(9,8);


% initial positions of planets derived from http://www.theplanetstoday.com/
aug08Mercury = 271 * pi / 180;
aug08Earth = 313 * pi / 180;
aug08Venus = 48 * pi / 180;
aug08Mars = 130 * pi / 180;
aug08Jupiter = 209 * pi / 180;
aug08Saturn = 268 * pi / 180;
aug08Uranus = 25 * pi / 180;
aug08Neptune = 343 * pi / 180;
aug08Pluto = 280 * pi / 180 ;

hold on;
%figure('Name', 'Planet Simulation','NumberTitle','off');

%while 1 == 1
    
    %loop to plot each individual point on graphs
    for j= 0:increment:last

        %plot stationary sun 
        sun = plot(0,0, 'ko');
        sun.MarkerSize = 2;
        
        [mercury, mercuryCoor] = plotPlanet(j, mercuryMajor, mercuryMinor, 0, mercuryOrbitDays, -mercuryDeltaX, 0, aug08Mercury, 'm', 'o');
        [venus, venusCoor] = plotPlanet(j, venusMajor, venusMinor, 0, venusOrbitDays, 0, venusDeltaX, aug08Venus, 'r', 'o');
        [earth, earthCoor] = plotPlanet(j, earthMajor, earthMinor, 0, earthOrbitDays, 0, earthDeltaX, aug08Earth, 'b', 'o');
        [mars, marsCoor] = plotPlanet(j, marsMajor, marsMinor, 90, marsOrbitDays, marsDeltaX, marsDeltaY, aug08Mars - 90*pi/180, 'c', 'o');
        [jupiter, jupiterCoor] = plotPlanet(j, jupiterMajor, jupiterMinor, 0, jupiterOrbitDays, jupiterDeltaX, jupiterDeltaY, aug08Jupiter, 'g', 'o');
        [saturn, saturnCoor] = plotPlanet(j, saturnMajor, saturnMinor, 90, saturnOrbitDays, -saturnDeltaX, -saturnDeltaY, aug08Saturn - 90*pi/180, 'b', '*');
        [uranus, uranusCoor] = plotPlanet(j, uranusMajor, uranusMinor, 0, uranusOrbitDays, uranusDeltaX, uranusDeltaY, aug08Uranus, 'm', '*');
        [neptune, neptuneCoor] = plotPlanet(j, neptuneMajor, neptuneMinor, 90, neptuneOrbitDays, -neptuneDeltaX, neptuneDeltaY, aug08Neptune - 90*pi/180, 'r', '*');
        [pluto, plutoCoor] = plotPlanet(j, plutoMajor, plutoMinor, 130, plutoOrbitDays, plutoDeltaX, -plutoDeltaY, aug08Pluto - 130*pi/180, 'c', '*');
        
        coordinates = [mercuryCoor venusCoor earthCoor marsCoor jupiterCoor saturnCoor uranusCoor neptuneCoor plutoCoor];
                
        %plot details
        axis([-axes axes -axes axes]);
        title(['August 08 2017 Day ' num2str(j)]);
        xlabel('* 1E6 km');
        ylabel('* 1E6 km');
        set(get(gca,'ylabel'),'Rotation',0)
        legend('Sun' , 'Mercury', 'Venus', 'Earth', 'Mars', 'Jupiter', 'Saturn', 'Uranus', 'Neptune', 'Pluto');
        
%         %pause for 0.1s if planets intersect
%          if (sin(e) == cos(e)) && (cos(e) == 2.*sin(e))
%              pause(0.1);
             
         %pause at end of specified days before repeating
         if j == last
            distPlanetToSunKM = dist(0, 0, coordinates(1, planetNumber), coordinates(2, planetNumber))
            distPlanetToMercuryKM = dist(mercuryCoor(1), mercuryCoor(2), coordinates(1, planetNumber), coordinates(2, planetNumber))
            distPlanetToVenusKM = dist(venusCoor(1), venusCoor(2), coordinates(1, planetNumber), coordinates(2, planetNumber))
            distPlanetToEarthKM = dist(earthCoor(1), earthCoor(2), coordinates(1, planetNumber), coordinates(2, planetNumber))
            distPlanetToMarsKM = dist(marsCoor(1), marsCoor(2), coordinates(1, planetNumber), coordinates(2, planetNumber))
            distPlanetToJupiterKM = dist(jupiterCoor(1), jupiterCoor(2), coordinates(1, planetNumber), coordinates(2, planetNumber))
            distPlanetToSaturnKM = dist(saturnCoor(1), saturnCoor(2), coordinates(1, planetNumber), coordinates(2, planetNumber))
            distPlanetToUranusKM = dist(uranusCoor(1), uranusCoor(2), coordinates(1, planetNumber), coordinates(2, planetNumber))
            distPlanetToNeptuneKM = dist(neptuneCoor(1), neptuneCoor(2), coordinates(1, planetNumber), coordinates(2, planetNumber))
            distPlanetToPlutoKM = dist(plutoCoor(1), plutoCoor(2), coordinates(1, planetNumber), coordinates(2, planetNumber))
            pause(50);
             
         
         %delete previously plotted points
         else
            pause(0.005);
            delete(sun);
            delete(earth);
            delete(mercury);
            delete(venus);
            delete(mars);
            delete(jupiter);
            delete(saturn);
            delete(uranus);
            delete(neptune);
            delete(pluto);
        end

    end
    
    %pause and clear all points on graph
    pause(1);
    cla;
    
    
   
%end
end

%this function accepts all relevant values of a planet's orbit and
%processes data to plot the next point of the orbit
%this function replaces having to do everything multiple times in the main

function [planet,location] = plotPlanet(j, majorAx, minorAx, rotDeg, orbitDays, deltaX, deltaY, offset, colour, marker)

    %converts number of orbit days to plottable orbit points
    t = 2*pi/orbitDays*j;
    
    %convert rotD
    %rotDeg = rotDeg * pi / 180;
    
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
    planet = plot(planetX, planetY);
    planet.Marker = marker;
    planet.MarkerEdgeColor = colour;
    planet.LineStyle = 'none';
    
    location = [planetX ; planetY];
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

function distance = dist(x1,y1,x2,y2)
    distance = sqrt((x1-x2).^2 + (y1-y2).^2) * 1E6;
end

