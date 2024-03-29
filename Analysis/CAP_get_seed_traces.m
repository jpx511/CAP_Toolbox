%% From the raw voxelwise data, computes a spatially averaged seed signal
% tcvox is a cell array (each cell has time x masked voxels dimension)
% seed is the seed mask (masked voxel x 1)
% S is a cell array (each cell is a time x 1 vector)
function [S] = CAP_get_seed_traces(tcvox,seed,SignMat,is_SS)

    % In the case when we have the same seed across subjects, we use it
    % throughout for the computations
    if ~is_SS
        if SignMat(1)
            % Computation of the spatially averaged seed signal
            S = cellfun(@(x) mean(x(:,seed),2), tcvox, 'un', 0);
        elseif SignMat(2)
            % Computation of the spatially averaged seed signal
            S = cellfun(@(x) (-1)*mean(x(:,seed),2), tcvox, 'un', 0);
        else
            errordlg('PROBLEM WITH SIGN MAT !!!');
        end
        
    % In the case when we have subject-specific seeds, we will compute the
    % seed signal separately for each subject
    else
        
        seed_cell = {};
        
        for s = 1:size(seed,2)
            seed_cell{s} = seed(:,s);
        end
        
        if SignMat(1)
            % Computation of the spatially averaged seed signal
            S = cellfun(@(x,y) mean(x(:,y),2), tcvox, seed_cell, 'un', 0);
        elseif SignMat(2)
            % Computation of the spatially averaged seed signal
            S = cellfun(@(x,y) (-1)*mean(x(:,y),2), tcvox, seed_cell, 'un', 0);
        else
            errordlg('PROBLEM WITH SIGN MAT !!!');
        end
    end
end