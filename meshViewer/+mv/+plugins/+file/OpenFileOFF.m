classdef OpenFileOFF < mv.gui.Plugin
% Opens mesh file and creates a new frame
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
    function this = OpenFileOFF(varargin)
    % Constructor for the OpenFileOFF class
    end
end % end constructors


%% Methods
methods
    function run(this, frame, src, evt) %#ok<INUSL>
       
        % Opens a dialog to choose a mesh file
        pattern = fullfile(frame.gui.lastPathOpen, '*.off');
        [fileName, filePath] = uigetfile(pattern, 'Read OFF Mesh file');
        
        % check if cancel
        if fileName == 0
            return;
        end
        
        % setup last path used for opening
        frame.gui.lastPathOpen = filePath;
        
        % read the mesh contained in the selected file
        fprintf('Reading off file...');
        [v, f] = readMesh_off(fullfile(filePath, fileName));
        fprintf(' (done)\n');
        
        % Create mesh data structure
        mesh = TriMesh(v, f);
        
        % creates new frame
        [path, baseName] = fileparts(fileName); %#ok<ASGLU>
        addNewMeshFrame(frame.gui, mesh, baseName);
    end
end % end methods

end % end classdef

