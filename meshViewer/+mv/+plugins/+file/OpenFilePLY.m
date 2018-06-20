classdef OpenFilePLY < mv.gui.Plugin
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
    function this = OpenFilePLY(varargin)
    % Constructor for SayHello class
    end
end % end constructors


%% Methods
methods
    function run(this, frame, src, evt) %#ok<INUSL>
       
        % Opens a dialog to choose a mesh file
        pattern = fullfile(frame.gui.lastPathOpen, '*.ply');
        [fileName, filePath] = uigetfile(pattern, 'Read PLY Mesh file');
        
        % check if cancel
        if fileName == 0
            return;
        end
        
        % setup last path used for opening
        frame.gui.lastPathOpen = filePath;
        
        % read the mesh contained in the selected file
        fprintf('Reading ply file...');
        tic;
        [v, f] = readMesh_ply(fullfile(filePath, fileName));
        t = toc;
        fprintf(' (done in %8.3f ms)\n', t*1000);
%        disp(sprintf('read mesh: %8.3f ms', t*1000));

        % Create mesh data structure
        tic;
        mesh = TriMesh(v, f);
        t = toc;
        fprintf('  create mesh: %8.3f ms', t*1000);

        % creates new frame
        addNewMeshFrame(frame.gui, mesh);
    end
end % end methods

end % end classdef

