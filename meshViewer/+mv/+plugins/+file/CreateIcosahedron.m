classdef CreateIcosahedron < mv.gui.Plugin
% Creates a new frame containing an icosahedron
%
%   Class SayHello
%
%   Example
%   SayHello
%
%   See also
%

% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2018-05-24,    using Matlab 9.4.0.813654 (R2018a)
% Copyright 2018 INRA - BIA-BIBS.


%% Properties
properties
end % end properties


%% Constructor
methods
    function this = CreateIcosahedron(varargin)
    % Constructor for SayHello class

    end

end % end constructors


%% Methods
methods
    function run(this, frame, src, evt) %#ok<INUSL>
        
        % creates the mesh
        [v, f] = createIcosahedron;
        mesh = TriMesh(v, f);
        
        % add new mesh to the current scene
        mh = createMeshHandle(frame.scene, mesh, 'icosahedron');
        frame.scene.addMeshHandle(mh);
        
        % update widgets and display
        updateMeshList(frame);
        updateDisplay(frame);
    end
    
end % end methods

end % end classdef

