function [mat_cor] = docorrmatrix(M,imf,patient,ROIsofinterest)
%docorrmatrix Calculates and plots the correlation matrix
%   Inputs: M - matrix that has the imfs and is formated according to the code in main.m
%           imf - number of imf to analyse
%           patient - patient to analyse
%           ROIsofinterest - ROIs to analyse
%
%   Outputs: matrix of correlation and respective plot

nROIs=length(ROIsofinterest);
imfs=zeros(length(M{patient,2}),nROIs);
for i=1:nROIs
    if ~isempty(M{patient,(ROIsofinterest(i))+1}) 
        imfs(:,i)=M{patient,(ROIsofinterest(i))+1}(:,imf);
    else
        disp("ERROR: The "+ROIsofinterest(i)+"th ROI does not have a signal")
    end
end
mat_cor=corr(imfs);
figure;
imagesc(mat_cor)
colormap jet
end

