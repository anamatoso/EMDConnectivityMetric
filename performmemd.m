function [M_memd] = performmemd(Mpatients,minimf)
% This function performs MEMD to a column of patients and puts each IMFs of
% each patient in the respective row, according to the patient, and column
% according to the signal.
%
% Input:    Mpatients - Column cell in which each row is a patient
%           minimf - minimum number of IMFs to have for each signal
%
% Output:   M_memd - Matrix cell in which each row is a patient. In the first
% column is the original signal, in the second one, the MEMD of the first
% signal, in the third one, the MEMD of the second, and so on.
%
% In the end, a verification of the minimum nuber of IMFs done is performed.
% In case the minimum number of IMFs is not achieved, a decrease in the
% threshold of the memdalt.m function should be done.

M_memd=Mpatients;
[n_patients, ~]=size(M_memd);
[~,n_signals]=size(M_memd{1});
f = waitbar(0,"Starting calculating and saving the IMFs...");
for p=1:n_patients
    m=memdalt(M_memd{p},minimf); % do MEMD
    for i=1:n_signals
        M_memd{p,i+1}= (squeeze(m(i,:,:)))'; % save in matrix
    end
    waitbar(p/n_patients,f);
end
close(f)

% check if minimum number of IMFs corresponds to the one above
realminimf=inf;%=4
notpatients=[];
for p=1:n_patients
        [~,mi]=size(M_memd{p,2});
        if mi<realminimf
            realminimf=mi;
        end
        if mi<minimf
            notpatients=[notpatients p];
        end
end

% display notices
notpatients=num2str(notpatients);
if realminimf==minimf
    disp("Minimum number of IMFs was achieved")
    
else
    disp("Minimum IMF was not achieved. Minimum number of IMFs is "+realminimf...
        +". Plus, the patients that have less than the established ...minimum number of IMFs are: "...
        +notpatients+".")
end

end