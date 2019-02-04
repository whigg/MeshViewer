classdef IntersectPlaneMesh < mv.gui.Plugin
% Compute intersection with a plane
%
%   Class IntersectPlaneMesh
%
%   Example
%   IntersectPlaneMesh
%
%   See also
%

% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2019-01-30,    using Matlab 9.4.0.813654 (R2018a)
% Copyright 2018 INRA - BIA-BIBS.


%% Properties
properties
end % end properties


%% Constructor
methods
    function this = IntersectPlaneMesh(varargin)
    % Constructor for IntersectPlaneMesh class
    end
end % end constructors


%% Methods
methods
    function run(this, frame, src, evt) %#ok<INUSL>
        
        meshList =  selectedMeshHandleList(frame);
        if length(meshList) < 1
            return;
        end
        
        % compute middle position along Z axis
        bbox = viewBox(frame.scene.displayOptions);
        medZ = ( bbox(6) - bbox(5) ) / 2 + bbox(5);
        
        % create dialog for choosing translation paraemters
        gd = GenericDialog('Intersect with Plane');
        addChoice(gd, 'Plane Type: ', {'XY-Plane', 'ZX-Plane', 'YZ-Plane'}, 'XY-Plane');
        addNumericField(gd, 'Plane position: ', medZ, 2);
        gd.setSize([300 150]);
        showDialog(gd);
        if wasCanceled(gd)
            return;
        end
            
        % parse user choices
        dirIndex = getNextChoiceIndex(gd);
        position = getNextNumber(gd);
        
        % create base symmery transform
        switch dirIndex
            case 1
                plane = [0 0 position  1 0 0  0 1 0];
                planeDigit = 'Z';
            case 2
                plane = [0 position 0  0 0 1  1 0 0];
                planeDigit = 'Y';
            case 3
                plane = [position 0 0  0 1 0  0 0 1];
                planeDigit = 'X';
        end
        
        % allocate memory
        intersections = cell(length(meshList), 1);
        
        % apply translation matrix to each selected mesh
        for iMesh = 1:length(meshList)
            % get data for current mesh
            mh = meshList{iMesh};
            intersections{iMesh} = intersectPlaneMesh(plane, mh.mesh.vertices, mh.mesh.faces);
        end

        figure; hold on; axis equal;
        drawPolygon3d(intersections, 'color', 'b');
        title(sprintf('%s = %d', planeDigit, position));
    end
    
end % end methods

end % end classdef

