%% Colab
clear all

%% Load the patients to matrix Mpatients
% Mpatients has a patient per row.

Mpatients=loadpatients("./Data");
%load("Mpatients.mat")

%% Do EMD
% M has a patient per row, the first column is the patient's signals, and
% the following columns are the IMFs of each signal of the patient
% calculated using EMD.

M = performemd(Mpatients);
%load("M.mat");

%% Do MEMD
% M_memd has a patient per row, the first column is the patient's signals,
% and the following columns are the IMFs of each signal of the patient
% calculated using MEMD with a certainminimum number of IMFs.

minimf=8; % minimum number of IMF desired
M_memd=performmemd(Mpatients,minimf);

%% Plot correlation matrix with EMD
%load("M.mat");
patient=1; % choose the patient
imf=1; % choose the IMF numbre you want to correlate
rois=(1:116); % choose the ROIs you want to correlate

[mat_cor1] = docorrmatrix(M,imf,patient,rois);
%% Plot correlation matrix with MEMD
%load("M_memd.mat");
patient=1;
imf=1;
rois=(1:116);

[mat_cor2] = docorrmatrix(M_memd,imf,patient,rois);

