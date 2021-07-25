function [M] = performemd(Mpatients)
% This function performs EMD to a column of patients and puts each IMFs of
% each patient in the respective row, according to the patient, and column
% according to the signal.
%
% Input:    Mpatients - Column cell in which each row is a patient
%
% Output:   M - Matrix cell in which each row is a patient. In the first
% column is the original signal, in the second one, the EMD of the first
% signal, in the third one, the EMD of the second, and so on.

M=Mpatients;
n_patients=length(M);
f = waitbar(0,"Starting calculating and saving the IMFs...");
for i=1:n_patients
    patient=M{i,1};
    for j=1:116
        M{i,j+1}=emd(patient(:,j)); % IMFs of each the nth region is on the n+1 column of the respective patient
    end
    waitbar(i/n_patients,f);
end
close(f)

end

