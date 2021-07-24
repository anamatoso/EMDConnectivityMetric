function [M] = performemd(Mpatients)

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

