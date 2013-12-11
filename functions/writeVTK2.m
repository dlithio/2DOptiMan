function myreturn = writeVTK2(pointsUsed2,index2,data)

closestPoints = closestPointArray(data,pointsUsed2,length(pointsUsed2));
%This first loop runs just to get totals that are necessary for the vtk
%file format
totalPoints = sum(pointsUsed2);
totalCells = 0;
totalCellLength = 0;
for timeStep = 1:(length(pointsUsed2)-1)
    for local = 1:pointsUsed2(timeStep)
        %local point 
        nextLocalThisRing = getNextLocalThisRing(local,timeStep,pointsUsed2);
        localNextRing = closestPoints(local,timeStep);
        nextLocalNextRing = getNextLocalNextRing2(local,timeStep,pointsUsed2,index2,closestPoints);
        beforeNextLocalNextRing = getBeforeNextLocalNextRing2(local,timeStep,pointsUsed2,index2,closestPoints);
        %Global point refs
        glocal = getGlobal(local,timeStep,pointsUsed2);
        gnextLocalThisRing = getGlobal(nextLocalThisRing,timeStep,pointsUsed2);
        glocalNextRing = getGlobal(localNextRing,timeStep+1,pointsUsed2);
        gnextLocalNextRing = getGlobal(nextLocalNextRing,timeStep+1,pointsUsed2);
        gbeforeNextLocalNextRing = getGlobal(beforeNextLocalNextRing,timeStep+1,pointsUsed2);
        %set mycell
        if glocalNextRing == gnextLocalNextRing
            myCell = [glocal glocalNextRing gnextLocalThisRing];
        else
            myCell = [glocal glocalNextRing:gbeforeNextLocalNextRing gnextLocalNextRing gnextLocalThisRing];
        end
        totalCells = totalCells + 1;
        totalCellLength = totalCellLength + length(myCell);
    end
end

%We open the file and write the header and the points that will be used
fileID = fopen('manifold.vtk','w');
fprintf(fileID,'# vtk DataFile Version 3.1\n');
fprintf(fileID,'this is an output from the manifold program\n');
fprintf(fileID,'ASCII\n');
fprintf(fileID,'DATASET UNSTRUCTURED_GRID\n');
fprintf(fileID,'%s %s %s\n','POINTS',num2str(totalPoints),'FLOAT');
for i = 1:length(pointsUsed2)
    fprintf(fileID,'%f %f %f\n',data(1:3,1:pointsUsed2(i),i));
end
fprintf(fileID,'\n');

%We go through and create the cells for the unstructured grid. The
%algorithm goes like this.
% start on a ring (called timestep) with a point (called local). Then, find
% where this point goes to on the next ring (nextLocalThisRing). Find both
% these points in the next ring (localNextRing and nextLocalNextRing). Draw
% an unstructured grid between all these points and the points inbetween
% them (there may be additional points inbetween the two points on the next
% ring because it is adaptive).
fprintf(fileID,'%s %s %s\n','CELLS',num2str(totalCells),num2str(totalCellLength+totalCells));
for timeStep = 1:(length(pointsUsed2)-1)
    for local = 1:pointsUsed2(timeStep)
        %local point 
        nextLocalThisRing = getNextLocalThisRing(local,timeStep,pointsUsed2);
        localNextRing = closestPoints(local,timeStep);
        nextLocalNextRing = getNextLocalNextRing2(local,timeStep,pointsUsed2,index2,closestPoints);
        beforeNextLocalNextRing = getBeforeNextLocalNextRing2(local,timeStep,pointsUsed2,index2,closestPoints);
        %Global point refs
        glocal = getGlobal(local,timeStep,pointsUsed2);
        gnextLocalThisRing = getGlobal(nextLocalThisRing,timeStep,pointsUsed2);
        glocalNextRing = getGlobal(localNextRing,timeStep+1,pointsUsed2);
        gnextLocalNextRing = getGlobal(nextLocalNextRing,timeStep+1,pointsUsed2);
        gbeforeNextLocalNextRing = getGlobal(beforeNextLocalNextRing,timeStep+1,pointsUsed2);
        %set mycell
        if glocalNextRing == gnextLocalNextRing
            myCell = [glocal glocalNextRing gnextLocalThisRing];
        else
            myCell = [glocal glocalNextRing:gbeforeNextLocalNextRing gnextLocalNextRing gnextLocalThisRing];
        end
        %set mycell
        myCell = [glocal glocalNextRing:gbeforeNextLocalNextRing gnextLocalNextRing gnextLocalThisRing];
        fprintf(fileID,'%s ',num2str(length(myCell)));
        fprintf(fileID,'%s\n',num2str(myCell));
    end
end
fprintf(fileID,'\n');

%Write out all the cell types as unstructured.
fprintf(fileID,'%s %s\n','CELL_TYPES',num2str(totalCells));
for i=1:totalCells
    fprintf(fileID,'%s ','7');
end
fprintf(fileID,'\n');

%Wrtie a scaler with each point that's the geodesic distance.
fprintf(fileID,'%s %s\n','POINT_DATA',num2str(totalPoints));
fprintf(fileID,'SCALARS Timestep float\n');
fprintf(fileID,'LOOKUP_TABLE default\n');
color=0;
for i = 1:length(pointsUsed2)
    for j = 1:pointsUsed2(i)
        fprintf(fileID,'%s\n',num2str(color));
    end
    color=color+1;
end
fclose(fileID);

end