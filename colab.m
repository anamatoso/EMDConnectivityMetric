%% Colab
% If you do not want to run the code below which can be quite long, just
% load the final matrix. M has a patient per row, the first column is the
% patient's signals, and the following columns are the IMFs of each signal
% of the patient.
%%
% total time up to 1907.255 s=31.78758min
disp("Loading the patients...");
myDir = uigetdir; %gets directory of the files
myFiles = dir(fullfile(myDir)); %gets all files

dataLines = [2, Inf];
lenfiles=length(myFiles);
for k = 4:lenfiles
    baseFileName = myFiles(k).name;
    fullFileName = fullfile(myDir, baseFileName);
    disp(k/lenfiles*100+"%");
    opts = delimitedTextImportOptions("NumVariables", 116);
    % Specify range and delimiter
    opts.DataLines = dataLines;
    opts.Delimiter = "\t";
    % Specify column names and types
    opts.VariableNames = ["VarName1", "VarName2", "VarName3", "VarName4", "VarName5", "VarName6", "VarName7", "VarName8", "VarName9", "VarName10", "VarName11", "VarName12", "VarName13", "VarName14", "VarName15", "VarName16", "VarName17", "VarName18", "VarName19", "VarName20", "VarName21", "VarName22", "VarName23", "VarName24", "VarName25", "VarName26", "VarName27", "VarName28", "VarName29", "VarName30", "VarName31", "VarName32", "VarName33", "VarName34", "VarName35", "VarName36", "VarName37", "VarName38", "VarName39", "VarName40", "VarName41", "VarName42", "VarName43", "VarName44", "VarName45", "VarName46", "VarName47", "VarName48", "VarName49", "VarName50", "VarName51", "VarName52", "VarName53", "VarName54", "VarName55", "VarName56", "VarName57", "VarName58", "VarName59", "VarName60", "VarName61", "VarName62", "VarName63", "VarName64", "VarName65", "VarName66", "VarName67", "VarName68", "VarName69", "VarName70", "VarName71", "VarName72", "VarName73", "VarName74", "VarName75", "VarName76", "VarName77", "VarName78", "VarName79", "VarName80", "VarName81", "VarName82", "VarName83", "VarName84", "VarName85", "VarName86", "VarName87", "VarName88", "VarName89", "VarName90", "VarName91", "VarName92", "VarName93", "VarName94", "VarName95", "VarName96", "VarName97", "VarName98", "VarName99", "VarName100", "VarName101", "VarName102", "VarName103", "VarName104", "VarName105", "VarName106", "VarName107", "VarName108", "VarName109", "VarName110", "VarName111", "VarName112", "VarName113", "VarName114", "VarName115", "VarName116"];
    opts.VariableTypes = ["double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double"];
    % Specify file level properties
    opts.ExtraColumnsRule = "ignore";
    opts.EmptyLineRule = "read";
    
    % Import the data
    Mpatients{k-3} = table2array(readtable(fullFileName, opts));% every cell has 1 patient
     
end
Mpatients=Mpatients'; % every row is 1 patient
disp("Patients loaded.");
clear opts myDir myFiles lenfiles dataLines baseFileName fullFileName k
%%
M_memd=Mpatients;
n_patients=length(M_memd);
disp("Starting calculating and saving the IMFs...");
for i=1:n_patients
    patient=M_memd{i,1};
    for j=1:116
        M_memd{i,j+1}=emd(patient(:,j)); % IMFs of each the nth region is on the n+1 column of the respective patient
    end
    disp(i/n_patients*100+"% done");
end

%%
M_memd=Mpatients;
[n_patients, ~]=size(M_memd);
[~,n_signals]=size(M_memd{1});
for p=1:n_patients
    m=memdalt(M_memd{p});
    for i=1:n_signals
        M_memd{p,i+1}= (squeeze(m(i,:,:)))';
    end
    disp(p/n_patients*100+"% done");
end
clear m i p
%% Plot correlation matrix with EMD
%load("M.mat");
patient=1;
imf=1;
rois=(1:116);
[mat_cor] = docorrmatrix(M,imf,patient,rois);
%% Plot correlation matrix with EMD
%load("M_memd.mat");
patient=1;
imf=1;
rois=(1:116);
[mat_cor] = docorrmatrix(M_memd,imf,patient,rois);
%%
minimf=inf;%=4
for p=1:n_patients
        [~,mi]=size(M_memd{p,2});
        if mi<minimf
            minimf=mi;
        end
end
clear p mi